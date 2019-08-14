# RSP TCP Server Docker Image

This Dockerfile is for building an image of [RSP TCP Server](https://github.com/SDRplay/RSPTCPServer),
a port of rtl_tcp. This is used for relaying samples from the SDRPlay range of
SDR devices to clients over the network.

To run: 

    docker run -d -p 1234:1234 --privileged -v /dev/bus:/dev/bus --name=rsp-tcp stanback/docker-rsptcpserver
    
You can pass the following arguments:

	-p listen port (default: 1234)
	-d RSP device to use (default: 1, first found)
	-P Antenna Port select* (0/1/2, default: 0, Port A)
	-T Bias-T enable* (default: disabled)
	-R Refclk output enable* (default: disabled)
	-f frequency to tune to [Hz]
	-s samplerate in Hz (default: 2048000 Hz)
	-n max number of linked list buffers to keep (default: 500)
	-v Verbose output (debug) enable (default: disabled)
	-E RSP extended mode enable (default: rtl_tcp compatible mode)
	-A AM notch enable (default: disabled)
	-B Broadcast notch enable (default: disabled)
	-D DAB notch enable (default: disabled)
	-F RF notch enable (default: disabled)
	-b Sample bit-depth (8/16 default: 8)
