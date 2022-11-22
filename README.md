# CLI


## Windows:
```
conan profile new cuddly-rotary-phone --detect
conan profile update settings.compiler.libcxx=libstdc++11 cuddly-rotary-phone
conan install . -if build/deps/conan --build missing --profile cuddly-rotary-phone -s build_type=RelWithDebInfo
```

Now open Visual Studio 2022, 17.4.x and try to build the above.



## Linux

```
conan profile new cuddly-rotary-phone --detect
conan profile update settings.compiler.libcxx=libstdc++11 cuddly-rotary-phone
conan install . -if build/deps/conan --build missing --profile cuddly-rotary-phone -s build_type=RelWithDebInfo
cmake --preset="dev-unix"
cmake --build --preset="dev-unix"
```
