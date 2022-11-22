# Reproduction steps


## On Windows:

On windows, it fails to build due to a missing include.
```
conan profile new cuddly-rotary-phone --detect
conan install . -if build/deps/conan --build missing --profile cuddly-rotary-phone -s build_type=RelWithDebInfo
```

Now open Visual Studio 2022, 17.4.x and try to build the above. You will see that it fails to compile the vivid files because one of them cannot include 
```
... cuddly-rotary-phone\thirdparty\vivid\src\colormap.cpp(9,1): fatal error C1083: Cannot open include file: 'nlohmann/json.hpp': No such file or directory 
```


## On Linux

It builds fine on linux.

```
conan profile new cuddly-rotary-phone --detect
conan profile update settings.compiler.libcxx=libstdc++11 cuddly-rotary-phone
conan install . -if build/deps/conan --build missing --profile cuddly-rotary-phone -s build_type=RelWithDebInfo
cmake --preset="dev-unix"
cmake --build --preset="dev-unix"
```
