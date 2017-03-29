#include <iostream>
#include <fstream>

#include <list>
#include <string.h>

#include "Digital.h"
#include "lib/json.hpp"

using namespace std;
using json = nlohmann::json;

std::string gPASSWORD = "testelabpesquisa";

#ifdef DEBUG
std::string gURL= "https://siglaufscar.herokuapp.com";
#else
std::string gURL= "https://siglaufscar.herokuapp.com";

#endif
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmissing-noreturn"
int main(int argc, char * argv[]) {
  Digital dig;

  /*
   * Initialize WiringPI and libcurl
   */

  if (argc == 1) {
    dig.init();
  }else if (argc > 1) {
    Device device;
    device.enroll_scan();
  }

  return 0;
}
#pragma clang diagnostic pop
