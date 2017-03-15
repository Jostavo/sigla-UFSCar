#include <iostream>
#include <fstream>
#include <list>
#include <libfprint/fprint.h>
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/buffer.h>
#include <curl/curl.h>

#include "lib/json.hpp"

#ifndef __DEVICE_H__
#define __DEVICE_H__

extern std::string gPASSWORD;

using namespace std;

class Device{
  private:
    int * ids;
    fp_print_data ** cache;
    fp_dev* device;

    // variables needed to check updates
    std::string buffer;
    bool flag;

    void fatalError(string msg);
    static size_t write_callback(char *ptr, size_t size, size_t nmemb, void *userdata);
    struct fp_dev* init_libfp();

  public:
    size_t response_json(char *ptr, size_t size, size_t nmemb);
    void load_cache(string cacheFileName);
    Device();
    int scan();
};

#endif
