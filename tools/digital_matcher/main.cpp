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
std::string gURL= "http://localhost:3000";
#else
std::string gURL= "https://siglaufscar.herokuapp.com";
#endif

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmissing-noreturn"
int main() {
  Digital dig;

  /*
   * Initialize WiringPI and libcurl
   */
  dig.init();

  return 0;
}
#pragma clang diagnostic pop
