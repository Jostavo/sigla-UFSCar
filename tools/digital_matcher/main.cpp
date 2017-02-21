#include <iostream>
#include <fstream>

#include <list>
#include <string.h>

#if DEBUG == 0
#define DOOR 15
#include <wiringPi.h>
#endif

#include "Digital.h"
#include "lib/json.hpp"

using namespace std;
using json = nlohmann::json;



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
