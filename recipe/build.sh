#!/bin/bash

EXTRA_CMAKE_ARGS=""
if [[ `uname` == 'Darwin' ]];
then
    EXTRA_CMAKE_ARGS="-DZMQ_BUILD_FRAMEWORK=OFF"
else
    export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi
export EXTRA_CMAKE_ARGS

mkdir build
cd build
cmake -D WITH_PERF_TOOL=OFF -D ZMQ_BUILD_TESTS=ON -D ENABLE_CPACK=OFF -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=$PREFIX -D CMAKE_INSTALL_LIBDIR=lib ${EXTRA_CMAKE_ARGS} ..
make install

# Add missing symlink for libzmq.so.5 required for pyzmq
# https://github.com/conda-forge/zeromq-feedstock/issues/16
ln -f -s libzmq${SHLIB_EXT} $PREFIX/lib/libzmq${SHLIB_EXT}.5

./bin/test_ancillaries
./bin/test_atomics
./bin/test_base85
./bin/test_bind_after_connect_tcp
./bin/test_bind_src_address
./bin/test_capabilities
./bin/test_conflate
./bin/test_connect_resolve
./bin/test_connect_rid
./bin/test_ctx_destroy
./bin/test_ctx_options
./bin/test_diffserv
./bin/test_disconnect_inproc
./bin/test_filter_ipc
./bin/test_fork
./bin/test_getsockopt_memset
./bin/test_heartbeats
./bin/test_hwm
./bin/test_hwm_pubsub
./bin/test_immediate
./bin/test_inproc_connect
./bin/test_invalid_rep
./bin/test_iov
./bin/test_ipc_wildcard
./bin/test_issue_566
./bin/test_last_endpoint
./bin/test_many_sockets
./bin/test_metadata
./bin/test_monitor
./bin/test_msg_ffn
./bin/test_msg_flags
./bin/test_pair_inproc
./bin/test_pair_ipc
./bin/test_pair_tcp
./bin/test_probe_router
./bin/test_proxy
./bin/test_proxy_single_socket
./bin/test_proxy_terminate
./bin/test_pub_invert_matching
./bin/test_req_correlate
./bin/test_req_relaxed
./bin/test_reqrep_device
./bin/test_reqrep_inproc
./bin/test_reqrep_ipc
./bin/test_reqrep_tcp
./bin/test_router_handover
./bin/test_router_mandatory
./bin/test_router_mandatory_hwm
./bin/test_security_null
./bin/test_security_plain
./bin/test_setsockopt
./bin/test_sockopt_hwm
./bin/test_sodium
./bin/test_spec_dealer
./bin/test_spec_pushpull
./bin/test_spec_rep
./bin/test_spec_req
./bin/test_spec_router
./bin/test_srcfd
./bin/test_stream
./bin/test_stream_disconnect
./bin/test_stream_empty
./bin/test_stream_exceeds_buffer
./bin/test_stream_timeout
./bin/test_sub_forward
./bin/test_term_endpoint
./bin/test_timeo
./bin/test_unbind_inproc
./bin/test_unbind_wildcard
./bin/test_use_fd_ipc
./bin/test_use_fd_tcp
./bin/test_xpub_manual
./bin/test_xpub_nodrop
./bin/test_xpub_welcome_msg
./bin/test_zmq_poll_fd

#./bin/test_security_curve
#./bin/test_shutdown_stress
#./bin/test_system
#./bin/test_thread_safe
