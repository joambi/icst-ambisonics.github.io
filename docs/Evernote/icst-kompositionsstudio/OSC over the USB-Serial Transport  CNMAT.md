---
source: https://cnmat.berkeley.edu/library/uosc_project_documentation/users_guide/osc_over_usb_serial_transport
---
# OSC over the USB-Serial Transport

\# Overview

A serial port is a bidirectional point-to-point communications channel. Open Sound Control is a datagram protocol which means that it requires a packetized transport (UDP is a common example of this). Serial isn't a packetized transport (nor is, for example, TCP).

\# The SLIP framing protocol

In order to send OSC on a serial link we use \[<http://tools.ietf.org/html/rfc1055>|SLIP RFC1055\] to "frame" the OSC packets. Specifically we use the "double-ENDed" variant of SLIP which places the SLIP\_END character at both the start \*and\* the end of a frame. Double-ended SLIP has slightly better behavior with respect to parser exceptions (e.g. coding error or stream availability interruption) because it is able to cleanly reject the corrupted packets.

\# IANA MIME header

When you open up the uOSC port, the first thing that is transmitted is an IANA MIME Version 1.0 header section. The MIME type identifies the stream type (x-application/osc), version, address schema and framing protocol. The end of headers is signaled by two line breaks, at which point the SLIP-encoded OSC begins. The MIME header packet can safely be fed through any OSC parser without side effects, since it is not a valid OSC packet. Furthermore if the stream was opened up with a SLIP decoder from the start, the lack of SLIP\_END marking the start of the MIME section would cause the parser to reject that data section. In this way the MIME header does not interfere with any well-behaved SLIP or OSC implementation. However in theory the port could be opened with a general purpose MIME decoder and the appropriate stream type handler identified (SLIP+OSC) by reading that meta-data.

\# Access in User Applications

Getting data to and from the serial device requires using a COM/serial-port. Many applications only support OSC over network connections. If this is the case then there are two options; 1) rewrite the application, 2) use another program to relay data from the serial port to the network. Option #2 almost certainly will introduce extra latency and jitter in the data stream.
