#include <iostream>
#include <fstream>
#include <curl/curl.h>
#include "json.hpp"

// for convenience
using json = nlohmann::json;
using namespace std;

class Digital{
  private:
    string json_string;
    json data;

    size_t write_json(char *ptr, size_t size, size_t nmemb){
      string aux = (string)ptr;
      if(aux.size() != nmemb){
        // it is the last packet, so, we need to remove some chunk bytes there
        this->json_string.append(ptr,0,((string)ptr).size()-7);
      }else{
        this->json_string.append(ptr);
      }
      return size*nmemb;
    }

    static size_t write_callback(char *ptr, size_t size, size_t nmemb, void *userdata){
      return static_cast<Digital*>(userdata)->write_json(ptr, size, nmemb);
    }

  public:
    int write_data(string name){
      fstream fs;

      fs.open(name, ios::out|ios::trunc);
      cout << "hahaha" << endl;

      for(json& unique : this->data){
        string biometric = unique["biometric"];
        fs << unique["user_id"] << "|" << biometric << endl;
      }

      fs.close();

      return 1;
    }
    void get_data(){
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
        //                    cout << body << endl;

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
          cerr << "❮ ⚠ ❯ Could not save log on the server! (" << curl_easy_strerror(res) << ")" << endl;
        }else{
          cout << "❮ ✔ ❯ Log saved to the server" << endl;
        }

        this->data = json::parse(this->json_string);

        /* always cleanup */
        curl_easy_cleanup(curl);
      }

    }
};



int main(){
  Digital dig;
  dig.get_data();
  dig.write_data("cache");
}
