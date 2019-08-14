# RSP TCP Server Docker Image

This Dockerfile is for building an image of RSP TCP Server, a port
of rtl_tcp. This is used for relaying samples from the SDRPlay range of
SDR devices to clients over the network.

To run: 

    docker run -d -p 1234:1234 --privileged -v /dev/bus:/dev/bus --name=rsp-tcp stanback/docker-rsptcpserver
