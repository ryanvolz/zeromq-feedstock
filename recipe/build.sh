#!/bin/bash

./configure --prefix="$PREFIX" --with-libsodium
make -j${NUM_CPUS}
make check
make install

# Generate CMake files, so downstream packages can use `find_package(ZeroMQ)`,
# which is normally only available when libzmq is itself installed with CMake

CMAKE_DIR="$PREFIX/share/cmake/ZeroMQ"
mkdir -p "$CMAKE_DIR"

cat << EOF > "$CMAKE_DIR/ZeroMQConfig.cmake"
set(PN ZeroMQ)
set(\${PN}_INCLUDE_DIR "$PREFIX/include")
set(\${PN}_LIBRARY "$PREFIX/lib/libzmq${SO}")
set(\${PN}_STATIC_LIBRARY "$PREFIX/lib/libzmq.a")
set(\${PN}_FOUND TRUE)
EOF

cat << EOF > "$CMAKE_DIR/ZeroMQConfigVersion.cmake"
set(PACKAGE_VERSION "$PKG_VERSION")

# Check whether the requested PACKAGE_FIND_VERSION is compatible
if("\${PACKAGE_VERSION}" VERSION_LESS "\${PACKAGE_FIND_VERSION}")
  set(PACKAGE_VERSION_COMPATIBLE FALSE)
else()
  set(PACKAGE_VERSION_COMPATIBLE TRUE)
  if ("\${PACKAGE_VERSION}" VERSION_EQUAL "\${PACKAGE_FIND_VERSION}")
    set(PACKAGE_VERSION_EXACT TRUE)
  endif()
endif()
EOF

