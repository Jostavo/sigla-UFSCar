#include "Digital.h"

//using json = nlohmann::json;
using namespace std;

/*
 * Callback using curl, when curl download fingerprint's data,
 * this function converts every string into a json data
 */
size_t Digital::write_json(char *ptr, size_t size, size_t nmemb){
  string aux = (string)ptr;
  if(aux.size() != nmemb){
    // it is the last packet, so, we need to remove some chunk bytes there
    this->json_string.append(ptr,0,((string)ptr).size()-7);
  }else{
    this->json_string.append(ptr);
  }
  return size*nmemb;
}

/*
 * A way to use this lib (made in C) to C++
 */

size_t Digital::write_callback(char *ptr, size_t size, size_t nmemb, void *userdata){
  return static_cast<Digital*>(userdata)->write_json(ptr, size, nmemb);
}

/*
 * Write all fingerprint's data to a file
 * @param name of the file
 */
void Digital::write_data(string name){
  int i;
  cout << "❮ ▶ ❯ Writing all fingerprints to cache... " << endl;
  fstream fs;
  string biometric;

  fs.open(name, ios::out|ios::trunc);

  for(i = 0; i < this->data.size(); i++){
    biometric = this->data[i]["biometric"].asString();
    std::replace(biometric.begin(), biometric.end(), ' ', '+');
    fs << this->data[i]["user_id"] << "|" << biometric << endl;
  }

  cout << "❮ ▶ ❯ Writed " << this->data.size() << " fingerprints" << endl;

  cout << "❮ ✔ ❯ Cache is ready" << endl;
}

/*
 * Download all fingerprint's data to a variable.
 * Uses curl to accomplish it.
 */
int Digital::init(){

#if DEBUG == 0
  /**
   * initialize wiringPi
   */
  cout << "❮ ▶ ❯ Initialiaing wiringPi... " << endl;
  wiringPiSetup();
  pinMode(DOOR, OUTPUT);
  digitalWrite(DOOR, LOW);

  cout << "❮ ✔ ❯ WiringPi ready" << endl << endl;
#endif

  /**
   * initialize libcurl
   */
  cout << "❮ ▶ ❯ Initialiaing libcurl... " << endl;
  curl_global_init(CURL_GLOBAL_ALL);
  cout << "❮ ✔ ❯ Libcurl ready for use" << endl << endl;

  /*
   * Download fingerprint's cache
   */
  if(this->get_data()){
    this->write_data("cache");
  }

  device = new Device();

  device->load_cache("cache");
  while(device->scan()){
    if(this->get_data()){
      this->write_data("cache");
      device->load_cache("cache");
    }
  }
}

/*
 * Download all fingerprint's data to a variable.
 * Uses curl to accomplish it.
 */

int Digital::get_data(){
  CURL* curl;
  CURLcode res;
  Json::Reader reader;
  curl = curl_easy_init();
  if (curl == NULL){
    cerr << "❮ ⚠ ❯ Couldn't get a curl handler!" << endl;
  }else {

    this->json_string = "";

    /* First set the URL that is about to receive our POST. This URL can
       just as well be a https:// URL if that is what should receive the
       data. */
    string body = "embedded_password="+gPASSWORD;
    string url = gURL + "/api/fingerprint/";

    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    /* Now specify the POST data */
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, Digital::write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, this);

    /* Perform the request, res will get the return code */
    res = curl_easy_perform(curl);
    /* Check for errors */
    if (res != CURLE_OK) {
      cerr << "❮ ⚠ ❯ "<< url << endl; 
      cerr << "❮ ⚠ ❯ Could not donwload all fingerprints! (" << curl_easy_strerror(res) << ")" << endl;
      return 0;
    }else{
      cout << "❮ ✔ ❯ Downloaded all fingerpritns!" << endl;
    }

    this->data.clear();
    reader.parse(this->json_string, this->data);

    /* always cleanup */
    curl_easy_cleanup(curl);
    return 1;
  }

}
