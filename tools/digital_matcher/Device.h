#include <iostream>
#include <fstream>
#include <list>
#include <libfprint/fprint.h>
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/buffer.h>
#include <curl/curl.h>
#include <cstring>
#include <unistd.h>

#ifndef DEBUG
#define DOOR 15
#include <wiringPi.h>
#endif

//#include "lib/json.hpp"
#include <json/json.h>

#ifndef __DEVICE_H__
#define __DEVICE_H__

extern std::string gPASSWORD;
extern std::string gURL;

using namespace std;

class Device{
  private:
    int * ids;
    fp_print_data ** cache;
    fp_dev* device;

    // variables needed to check updates
    string buffer_json;
    bool update;

    struct fp_dev* init_libfp();
    void fatalError(string msg);
    void set_update_check(int flag);

    bool sent_request(int user_id);
    static size_t write_callback(char *ptr, size_t size, size_t nmemb, void *userdata);
    size_t response_json(char *ptr, size_t size, size_t nmemb);

    BUF_MEM * preparing_data_enroll(fp_print_data ** print);
    bool sent_enroll_request(BUF_MEM * bufferPtr);

  public:
    void load_cache(string cacheFileName);
    Device();
    int enroll_scan();
    int scan();
    bool update_check();
};

#endif
