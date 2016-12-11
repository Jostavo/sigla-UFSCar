cmake_minimum_required(VERSION 3.6)
project(digital)


#set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} /usr/local/Cellar/libusb/1.0.20/lib/)
#set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} /usr/include)


#include_directories(/usr/include/) /usr/local/Cellar/nspr/4.12_1/lib/
find_path(FPRINT_INCLUDE NAMES libfprint/fprint.h)
#include_directories(/usr/include/)



#find_library(LIBFPRINT libfprint.la)
#find_library(LIBUSB libusb-1.0.a PATHS /usr/local/Cellar/libusb/1.0.20/lib/)
#find_library(LIBNSS libnss.a PATHS /usr/local/opt/nss/lib)
#find_library(LIBNSPR libnspr.a PATHS /usr/local/Cellar/nspr/4.12_1/lib/)



#  -L/usr/lib/ -L/usr/local/Cellar/ -I${FPRINT_INCLUDE}
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -I${FPRINT_INCLUDE} ")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I/usr/local/opt/openssl/include")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L/usr/local/opt/openssl/lib")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L/opt/local/lib")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L/usr/local/Cellar/nss/3.26/lib")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L/usr/local/Cellar/nspr/4.12_1/lib")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L/usr/local/Cellar/libusb/1.0.20/lib")

set(SOURCE_FILES main.cpp)
add_executable(digital ${SOURCE_FILES})

target_link_libraries(digital /usr/lib/libfprint.a)
target_link_libraries(digital intl)
target_link_libraries(digital glib-2.0)
target_link_libraries(digital pixman-1)
target_link_libraries(digital nss3)
target_link_libraries(digital nssutil3)
target_link_libraries(digital smime3)
target_link_libraries(digital ssl3)
target_link_libraries(digital plds4)
target_link_libraries(digital plc4)
target_link_libraries(digital nspr4)
target_link_libraries(digital usb-1.0)
target_link_libraries(digital crypto)
target_link_libraries(digital curl)

