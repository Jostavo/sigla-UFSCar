#include "lib/json.hpp"
#include "Device.h"

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
