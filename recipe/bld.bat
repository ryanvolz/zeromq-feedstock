mkdir build
cd build
cmake -G "NMake Makefiles" -D ENABLE_DRAFTS=OFF -D WITH_PERF_TOOL=OFF -D ZMQ_BUILD_TESTS=ON -D ENABLE_CPACK=OFF -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ..
if errorlevel 1 exit 1
nmake install
if errorlevel 1 exit 1
