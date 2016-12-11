#include <iostream>
#include <libfprint/fprint.h>
#include <openssl/sha.h>
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/buffer.h>
#include <curl/curl.h>

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


int main() {

    /**
     * initialize fprintlib
     */
    cout << "❮ ▶ ❯ Initialiaing fingeprint reader..." << endl;
    cout << "aaa\033[2Kbbb";


    // if the lib couldn't be initialized
    if(fp_init() < 0){
        fatalError("Failed to initialize libfprint!");
    }

    /**
     * initialize libcurl
     */
    curl_global_init(CURL_GLOBAL_ALL);


    /**
     * find and open fingerprint reader
     */
    struct fp_dscv_dev** devices_found = fp_discover_devs();

    // if no device found, exit the program
    if (devices_found == NULL || devices_found[0] == NULL){
        fatalError("No reader found!");
    }

    // list devices found
    cout << "Chosen reader: " << endl;
    for(int i = 0; devices_found[i] != NULL; i++){
        struct fp_dscv_dev* dscv_device = devices_found[i];
        struct fp_driver* driver = fp_dscv_dev_get_driver(dscv_device);
        if ( i == 0){
            cout << "\t➜ ";
        }else {
            cout << "\t● ";
        }
        cout << fp_driver_get_full_name(driver) << endl;
    }

    // choose one reader to use, and open it
    struct fp_dev* device = fp_dev_open(devices_found[0]);

    // check if the reader could be opened
    if (device == NULL){
        fatalError("Couldn't open selected reader for use!");
    }

    // free list of devices from memory
    fp_dscv_devs_free(devices_found);


    cout << "❮ ✔ ❯ Reader ready for use" << endl;

    /**
     * keep enrolling fingers...
     */
    cout << endl << "Press ENTER to enroll a finger or ESC to exit" << endl;
    while (cin.get() != 27){

        bool aborted  = false;
        struct fp_print_data* print = NULL;

        // enroll a finger
        int num_enroll_stages = fp_dev_get_nr_enroll_stages(device);
        for (int i = num_enroll_stages; i > 0; i--) {
            cout << "Waiting for finger..." << endl;
            int returnCode = fp_enroll_finger(device, &print);

            if (returnCode < 0){
                cout << "❮ ✖ ❯ I/O error, aborting enrollment..." << endl;
                aborted = true;
                break;
            }

            switch(returnCode){
                case FP_ENROLL_FAIL:
                    cout << "❮ ☝ ✖ ❯ Data processing failed, aborting enrollment ..." << endl;
                    aborted = true;
                    break;

                case FP_ENROLL_RETRY:
                case FP_ENROLL_RETRY_TOO_SHORT:
                case FP_ENROLL_RETRY_CENTER_FINGER:
                case FP_ENROLL_RETRY_REMOVE_FINGER:
                    cout << "❮ ☝ ↻ ❯ Failed to read fingerprint, retrying stage..." << endl;

                    // retry this stage
                    i++;
                    break;

                case FP_ENROLL_PASS:
                    cout << "❮ ☝ ✔ ❯ Stage " << (1 + num_enroll_stages - i) << "/" << num_enroll_stages << " successful" << endl;
                    break;

                case FP_ENROLL_COMPLETE:
                    cout << "❮ ✔ ❯ Enrollment completed" << endl;
                    break;
            }
            cout << endl;

            if (aborted){
                break;
            }

        }

        // if we finished enrolling the finger
        if (!aborted){
            // get fingerprint data
            unsigned char * printData = NULL;
            size_t printDataSize = 0;
            printDataSize = fp_print_data_get_data(print, &printData);

//            cout << "❮ ☝ ❯ size: "<< printDataSize << endl;

//            // show hash
//            char outputBuffer[SHA256_DIGEST_LENGTH*2 +1];
//            unsigned char hash[SHA256_DIGEST_LENGTH];
//            SHA256_CTX sha256;
//            SHA256_Init(&sha256);
//            SHA256_Update(&sha256, printData, printDataSize);
//            SHA256_Final(hash, &sha256);
//            int i = 0;
//            for(i = 0; i < SHA256_DIGEST_LENGTH; i++){
//                sprintf(outputBuffer + (i * 2), "%02X", hash[i]);
//            }
//            outputBuffer[64] = 0;
//            cout << "❮ ☝ ♯ ❯ " << outputBuffer << endl;

            // generate base64
            BIO *bio, *b64;
            BUF_MEM* bufferPtr;

            b64 = BIO_new(BIO_f_base64());
            bio = BIO_new(BIO_s_mem());
            bio = BIO_push(b64, bio);

            BIO_set_flags(bio, BIO_FLAGS_BASE64_NO_NL); //Ignore newlines - write everything in one line
            BIO_write(bio, printData, printDataSize);
            BIO_flush(bio);
            BIO_get_mem_ptr(bio, &bufferPtr);
            BIO_set_close(bio, BIO_NOCLOSE);
            BIO_free_all(bio);

//            cout << "❮ ☝ ❯ base64: "<< (string(bufferPtr->data, bufferPtr->length)) << endl;

            cout << "❮ ☝ ⬆ ❯ uploading fingerprint..." << endl;
            // send data over http
            CURL* curl;
            CURLcode res;
            curl = curl_easy_init();
            if (curl == NULL){
                cerr << "❮ ⚠ ❯ Couldn't get a curl handler, fingerprint was NOT saved on the server!" << endl;
            }else {

                /* First set the URL that is about to receive our POST. This URL can
                   just as well be a https:// URL if that is what should receive the
                   data. */
                string body = "hash_biometric=" + std::string(bufferPtr->data, bufferPtr->length);

                curl_easy_setopt(curl, CURLOPT_URL,
                                 "https://siglaufscar.herokuapp.com/dashboard/access/fingerprint/set");
                /* Now specify the POST data */
                curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body.c_str());
                curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);

                /* Perform the request, res will get the return code */
                res = curl_easy_perform(curl);
                /* Check for errors */
                if (res != CURLE_OK) {
                    cerr << "❮ ⚠ ❯ Could not save fingerprint on the server! (" << curl_easy_strerror(res) << ")" << endl;
                }else{
                    cout << "❮ ✔ ❯ Fingerprint saved to the server" << endl;
                }



                /* always cleanup */
                curl_easy_cleanup(curl);
            }

            // clean up
            delete[] printData;
            fp_print_data_free(print);
        }

        cout << endl << "Press ENTER to enroll a finger or ESC to exit" << endl;
    }


    // clean up
    fp_dev_close(device); // close fingerprint reader
    fp_exit(); // unload libfprint
    curl_global_cleanup(); // unload libcurl
    return 0;
}