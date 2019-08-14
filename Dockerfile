#
# Dockerfile for RSP TCP Server (rsp_tcp) (https://github.com/SDRplay/RSPTCPServer)
#
# RSP TCP Server is a port of rtl_tcp, used for relaying samples from the SDRPlay
# range of SDR devices over the network.
#
# Build with:
#     docker build --rm --tag=rsp-tcp:latest .
#
# Run with:
#     docker run -d -p 1234:1234 --privileged -v /dev/bus:/dev/bus --name=rsp-tcp rsp-tcp
#
# Prerequisites:
#
# On the host you might need to blacklist modules related to SDR.
# E.g.: For RSP1A, Create: /etc/modprobe.d/blacklist-msi2500.conf with:
#
#     # Blacklist msi2500 so Docker container can use the device
#     blacklist sdr_msi3101
#     blacklist msi001
#     blacklist msi2500
#
# License:
#
# By running this, you automatically agree to the EULA contained in the
# SDRplay driver (https://www.sdrplay.com/downloads/).
#

FROM ubuntu:latest

ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib

RUN apt-get update \
  && apt-get install -y \
    wget git cmake g++ udev libudev-dev libusb-1.0-0-dev \
  && wget http://www.sdrplay.com/software/SDRplay_RSP_API-Linux-2.13.1.run \
  && chmod +x *.run \
  && ./SDRplay_RSP_API-Linux-2.13.1.run --noexec --keep \
  && cd package \
  && sed -i -n '1,4p;16,$p' install_lib.sh \
  && sed -i 's/sudo / /g' install_lib.sh \
  && ./install_lib.sh \
  && cd .. \
  && git clone https://github.com/SDRplay/RSPTCPServer.git \
  && cd RSPTCPServer \
  && mkdir build \
  && cd build \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make \
  && make install \
  && cd ../.. \
  && rm -fr ./SDRplay_RSP_API-Linux-2.13.1.run package RSPTCPServer \
  && apt-get purge -y cmake wget git \
  && apt-get autoremove -y --purge \
  && apt-get clean

EXPOSE 1234

ENTRYPOINT ["rsp_tcp", "-a", "0.0.0.0"]
CMD ["-E", "-v"]
