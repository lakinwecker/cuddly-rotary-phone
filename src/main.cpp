#include <iostream>
#include <vivid/vivid.h>
#include <vivid/color.h>

int main() {
    vivid::ColorMap colorMap(vivid::ColorMap::Preset::Rainbow);
    std::cout << "Hello World" << std::endl;
}
