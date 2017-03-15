#include <iostream>
#include <fstream>
#include <list>
#include <libfprint/fprint.h>
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/buffer.h>
#include <curl/curl.h>

#include "lib/json.hpp"

#ifndef __DIGITAL_H__
#define __DIGITAL_H__
#include "Device.h"

extern std::string gPASSWORD;

class Digital{
  private:
    Device * device;
    std::string json_string;
    nlohmann::json data;

    size_t write_json(char * ptr, size_t size, size_t nmemb);
    static size_t write_callback(char * ptr, size_t size, size_t nmemb, void * userdata);

  public:
    void write_data(std::string name);
    int get_data();
    int init();
};

#endif
