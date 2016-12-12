#include <iostream>
#include <fstream>
#include <libfprint/fprint.h>
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/buffer.h>
#include <curl/curl.h>
#include <list>
// #include <wiringPi.h>
// #define DOOR 24

using namespace std;

/**
 * Shows a fatal error message, unloads fprintlib and exit the program with
 * the status code EXIT_FAILURE
 * @param msg Message to be displayed
 */
void inline fatalError(string msg){
    cerr << "❮ ☠ ❯ " << msg << endl;
    fp_exit();
    exit(EXIT_FAILURE);
}

size_t write_callback(char *ptr, size_t size, size_t nmemb, void *userdata){
    // ignore data and does nothing :)
    return size*nmemb;
}

/**
 * initialize fprintlib and open a device for use
 * @return device to be used
 */
inline struct fp_dev* init_libfp(){
    /**
     * initialize fprintlib
     */
    cout << "❮ ▶ ❯ Initialiaing fingeprint reader..." << endl;


    // if the lib couldn't be initialized
    if (fp_init() < 0) {
        fatalError("Failed to initialize libfprint!");
    }


    /**
     * find and open fingerprint reader
     */
    struct fp_dscv_dev **devices_found = fp_discover_devs();

    // if no device found, exit the program
    if (devices_found == NULL || devices_found[0] == NULL) {
        fatalError("No reader found!");
    }

    // list devices found
    cout << "Chosen reader: " << endl;
    for (int i = 0; devices_found[i] != NULL; i++) {
        struct fp_dscv_dev *dscv_device = devices_found[i];
        struct fp_driver *driver = fp_dscv_dev_get_driver(dscv_device);
        if (i == 0) {
            cout << "\t➜ ";
        } else {
            cout << "\t● ";
        }
        cout << fp_driver_get_full_name(driver) << endl;
    }

    // choose one reader to use, and open it
    struct fp_dev* device = fp_dev_open(devices_found[0]);

    // check if the reader could be opened
    if (device == NULL) {
        fatalError("Couldn't open selected reader for use!");
    }

    // free list of devices from memory
    fp_dscv_devs_free(devices_found);


    cout << "❮ ✔ ❯ Reader ready for use" << endl << endl;
    return device;
}

/**
 * Read cached fingerprints from a file an return it via parameters
 * @param cacheFileName file to read from
 * @param cache prints from the file
 * @param ids user IDs referring to the prints
 */
inline void load_cache(string cacheFileName, struct fp_print_data*** cache, int** ids){
    cout << "❮ ▶ ❯ Loading fingerprints... " << endl;

    // open cache file
    ifstream cacheFile("cache");

    // if failed to open file, quit program
    if (!cacheFile.is_open()) {
        fatalError("failed to open cache file");
    }

    // read entries
    string line;
    std::list<int> idList;
    std::list<struct fp_print_data*> printsList;
    while (getline(cacheFile, line)) {
        string idString = "";
        int dataStartPos = -1;
        for(int i = 0; i < line.size(); i++){
            // found separator
            if (line[i] == '|'){
                dataStartPos = i + 1;
                break;
            }

            // add another digiti to the id
            idString += line[i];
        }

        /**
         * add id to list
         */
        idList.push_back(std::stoi(idString));

        /**
         * convert print data from base64 to binary
         */
        BIO *bio, *b64;
        char* b64message = (char*)line.substr(dataStartPos).c_str();
//        b64message[264] = '\0';
//        cout << "❮ ☝ ❯ base64: "<< (string(b64message, strlen(b64message))) << endl;


        // get original size
        size_t y = line.size();
        size_t b64messageSize = strlen(b64message);
        size_t decodeLen = (3*strlen(b64message))/4;

        // remove padding from size
        if (line[line.size() - 1] == '='){
            decodeLen--;
        }
        if (line[line.size() - 2] == '='){
            decodeLen--;
        }

        unsigned char* buffer = (unsigned char*)malloc(decodeLen + 1);


        bio = BIO_new_mem_buf(b64message, -1);
        b64 = BIO_new(BIO_f_base64());
        bio = BIO_push(b64, bio);

        BIO_set_flags(bio, BIO_FLAGS_BASE64_NO_NL); //Do not use newlines to flush buffer
        size_t length = BIO_read(bio, buffer, b64messageSize);
        BIO_free_all(bio);

        /**
         * add print data to the list
         */

        struct fp_print_data* tmp = fp_print_data_from_data(buffer, decodeLen);

        // failed to convert data
        if (tmp == NULL){
            fatalError("could not read entry from cache file");
        }

        // add print to list
        printsList.push_back(tmp);
    }

    // close file
    cacheFile.close();

    /**
     * convert lists into array and return it
     */
    // generate array of ids
    *ids = new int[idList.size()];
    copy(idList.begin(), idList.end(), *ids);

    // generate array of prints
    *cache = new struct fp_print_data*[printsList.size() + 1];
    (*cache)[printsList.size()] = NULL;
    copy(printsList.begin(), printsList.end(), *cache);

    cout << "❮ ✔ ❯ Fingerprints loaded" << endl << endl;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmissing-noreturn"
int main() {
    /**
     * initialize wiringPi
     */
    cout << "❮ ▶ ❯ Initialiaing wiringPi... " << endl;
//    wiringPiSetup();
//    pinMode(DOOR, OUTPUT);
//    digitalWrite(DOOR, LOW);
    cout << "❮ ✔ ❯ WiringPi ready" << endl << endl;

    /**
     * initialize libcurl
     */
    cout << "❮ ▶ ❯ Initialiaing libcurl... " << endl;
    curl_global_init(CURL_GLOBAL_ALL);
    cout << "❮ ✔ ❯ Libcurl ready for use" << endl << endl;

    /**
     * init libfprint and get a device
     */
    struct fp_dev* device = init_libfp();

    /**
     * Load cached prints
     */
    // cache all fingerprints and ids from database
    struct fp_print_data** cache = NULL;
    int* ids = NULL;
    load_cache("cache", &cache, &ids);

    /**
     * keep scanning fingers...
     */
    while(true){

        cout << endl << "❮ ☝ ❯ Waiting for finger..." << endl;

        size_t cacheMatchPos = 0;
        int resultCode = fp_identify_finger(device, cache, &cacheMatchPos);

        // if there was a error, retry
        if (resultCode < 0){
            cerr << "❮ ⚠ ❯ Error matching fingerprint!" << endl;
            continue;
        }

        switch (resultCode){

            case FP_VERIFY_NO_MATCH:
                cout << "❮ ☝ ✖ ❯ Fingerprint does not match any database entry" << endl;
                break;

            case FP_VERIFY_RETRY:
            case FP_VERIFY_RETRY_TOO_SHORT:
            case FP_VERIFY_RETRY_CENTER_FINGER:
            case FP_VERIFY_RETRY_REMOVE_FINGER:
                cout << "❮ ☝ ↻ ❯ Failed to read fingerprint, retrying..." << endl;
                break;

            case FP_VERIFY_MATCH:
                cout << "❮ ☝ ✔ ❯ Fingerprint match user ID: " << ids[cacheMatchPos] << endl;
                // open the door
//                digitalWrite(DOOR, HIGH);
//                delay(5000);
//                digitalWrite(DOOR, LOW);


                // log on server that the door was opened
                cout << "❮ ⬆ ❯ uploading log..." << endl;
                CURL* curl;
                CURLcode res;
                curl = curl_easy_init();
                if (curl == NULL){
                    cerr << "❮ ⚠ ❯ Couldn't get a curl handler!" << endl;
                }else {

                    /* First set the URL that is about to receive our POST. This URL can
                       just as well be a https:// URL if that is what should receive the
                       data. */
                    string body = "laboratory_id=2&user_id=" + std::to_string(ids[cacheMatchPos]);
//                    cout << body << endl;

                    curl_easy_setopt(curl, CURLOPT_URL,
                                     "https://siglaufscar.herokuapp.com/dashboard/access/fingerprint/access");
                    /* Now specify the POST data */
                    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body.c_str());
                    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);

                    /* Perform the request, res will get the return code */
                    res = curl_easy_perform(curl);
                    /* Check for errors */
                    if (res != CURLE_OK) {
                        cerr << "❮ ⚠ ❯ Could not save log on the server! (" << curl_easy_strerror(res) << ")" << endl;
                    }else{
                        cout << "❮ ✔ ❯ Log saved to the server" << endl;
                    }

                    /* always cleanup */
                    curl_easy_cleanup(curl);
                }
                break;
        }
    }

    return 0;
}
#pragma clang diagnostic pop