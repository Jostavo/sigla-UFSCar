#include "Digital.h"

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

static size_t Digital::write_callback(char *ptr, size_t size, size_t nmemb, void *userdata){
  return static_cast<Digital*>(userdata)->write_json(ptr, size, nmemb);
}

/*
 * Write all fingerprint's data to a file
 * @param name of the file
 */
void Digital::write_data(string name){
  cout << "❮ ▶ ❯ Writing all fingerprints to cache... " << endl;
  fstream fs;

  fs.open(name, ios::out|ios::trunc);

  for(json& unique : this->data){
    string biometric = unique["biometric"];
    replace(biometric.begin(), biometric.end(), ' ', '+');
    fs << unique["user_id"] << "|" << biometric << endl;
  }

  fs.close();

  cout << "❮ ✔ ❯ Cache is ready" << endl << endl;
}

/*
 * Download all fingerprint's data to a variable.
 * Uses curl to accomplish it.
 */

int Digital::get_data(){
  CURL* curl;
  CURLcode res;
  curl = curl_easy_init();
  if (curl == NULL){
    cerr << "❮ ⚠ ❯ Couldn't get a curl handler!" << endl;
  }else {

    /* First set the URL that is about to receive our POST. This URL can
       just as well be a https:// URL if that is what should receive the
       data. */
    string body = "laboratory_id=2";

    curl_easy_setopt(curl, CURLOPT_URL,
        "https://siglaufscar.herokuapp.com/dashboard/access/fingerprint/get/all");
    /* Now specify the POST data */
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, Digital::write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, this);

    /* Perform the request, res will get the return code */
    res = curl_easy_perform(curl);
    /* Check for errors */
    if (res != CURLE_OK) {
      cerr << "❮ ⚠ ❯ Could not donwload all fingerprints! (" << curl_easy_strerror(res) << ")" << endl;
      return 0;
    }else{
      cout << "❮ ✔ ❯ Downloaded all fingerpritns!" << endl;
    }

    this->data = json::parse(this->json_string);

    /* always cleanup */
    curl_easy_cleanup(curl);
    return 1;
  }

}
