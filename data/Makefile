PINGPONGADDR=localhost
PINGPONGPORT=1491
TCP_EXE=../bin/tcp_ping
UDP_EXE=../bin/udp_ping

all: throughput ../data

../data:
	mkdir ../data

throughput: ../data/throughput.png

all_data: all_udp_data all_tcp_data

all_udp_data: ../data/udp_64.out ../data/udp_96.out ../data/udp_128.out ../data/udp_192.out ../data/udp_256.out

all_tcp_data: ../data/tcp_64.out ../data/tcp_96.out ../data/tcp_128.out ../data/tcp_192.out ../data/tcp_256.out

../data/udp_64.out:
	$(UDP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 64 501 > ../data/udp_64.out || mv -f ../data/udp_64.out ../data/udp_64.out.broken

../data/udp_96.out:
	$(UDP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 96 501 > ../data/udp_96.out || mv -f ../data/udp_96.out ../data/udp_96.out.broken

../data/udp_128.out:
	$(UDP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 128 501 > ../data/udp_128.out || mv -f ../data/udp_128.out ../data/udp_128.out.broken

../data/udp_192.out:
	$(UDP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 192 501 > ../data/udp_192.out || mv -f ../data/udp_192.out ../data/udp_192.out.broken

../data/udp_256.out:
	$(UDP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 256 501 > ../data/udp_256.out || mv -f ../data/udp_256.out ../data/udp_256.out.broken

../data/tcp_64.out:
	$(TCP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 64 501 > ../data/tcp_64.out || mv -f ../data/tcp_64.out ../data/tcp_64.out.broken

../data/tcp_96.out:
	$(TCP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 96 501 > ../data/tcp_96.out || mv -f ../data/tcp_96.out ../data/tcp_96.out.broken

../data/tcp_128.out:
	$(TCP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 128 501 > ../data/tcp_128.out || mv -f ../data/tcp_128.out ../data/tcp_128.out.broken

../data/tcp_192.out:
	$(TCP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 192 501 > ../data/tcp_192.out || mv -f ../data/tcp_192.out ../data/tcp_192.out.broken

../data/tcp_256.out:
	$(TCP_EXE) $(PINGPONGADDR) $(PINGPONGPORT) 256 501 > ../data/tcp_256.out || mv -f ../data/tcp_256.out ../data/tcp_256.out.broken

../data/throughput.png: ../data/tcp_throughput.dat ../data/udp_throughput.dat
	../scripts/gplot.bash

../data/udp_throughput.dat: all_udp_data
	../scripts/collect_throughput.bash udp

../data/tcp_throughput.dat: all_tcp_data
	../scripts/collect_throughput.bash tcp

clean:
	rm -f ../data/throughput.png ../data/tcp_throughput.dat ../data/udp_throughput.dat ../data/udp_64.out ../data/udp_64.out.broken ../data/udp_96.out ../data/udp_96.out.broken ../data/udp_128.out ../data/udp_128.out.broken ../data/udp_192.out ../data/udp_192.out.broken ../data/udp_256.out ../data/udp_256.out.broken ../data/tcp_64.out ../data/tcp_64.out.broken ../data/tcp_96.out ../data/tcp_96.out.broken ../data/tcp_128.out ../data/tcp_128.out.broken ../data/tcp_192.out ../data/tcp_192.out.broken ../data/tcp_256.out ../data/tcp_256.out.broken

