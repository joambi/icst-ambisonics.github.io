#!/usr/bin/env python3
import socket
import struct
import sys


def osc_pad(data: bytes) -> bytes:
    pad = (4 - (len(data) % 4)) % 4
    return data + (b"\0" * pad)


def osc_string(text: str) -> bytes:
    return osc_pad(text.encode("utf-8") + b"\0")


def osc_packet_start(address: str, marker_index: int, marker_pos: float, marker_name: str) -> bytes:
    return (
        osc_string(address)
        + osc_string(",ifs")
        + struct.pack(">i", marker_index)
        + struct.pack(">f", marker_pos)
        + osc_string(marker_name)
    )


def osc_packet_interval(
    address: str,
    marker1_index: int,
    marker1_pos: float,
    marker2_index: int,
    marker2_pos: float,
    diff_ms: int,
) -> bytes:
    return (
        osc_string(address)
        + osc_string(",ififi")
        + struct.pack(">i", marker1_index)
        + struct.pack(">f", marker1_pos)
        + struct.pack(">i", marker2_index)
        + struct.pack(">f", marker2_pos)
        + struct.pack(">i", diff_ms)
    )


def osc_packet_target(address: str, scene_name: str) -> bytes:
    return osc_string(address) + osc_string(",s") + osc_string(scene_name)


def osc_packet_store(address: str, scene_name: str) -> bytes:
    return osc_string(address) + osc_string(",s") + osc_string(scene_name)


def osc_packet_setduration(address: str, diff_ms: int) -> bytes:
    return osc_string(address) + osc_string(",i") + struct.pack(">i", diff_ms)


def main() -> int:
    if len(sys.argv) < 5:
        return 1

    host = sys.argv[1]
    port = int(sys.argv[2])
    address = sys.argv[3]
    mode = sys.argv[4]

    if mode == "start":
        if len(sys.argv) != 8:
            return 1
        packet = osc_packet_start(address, int(sys.argv[5]), float(sys.argv[6]), sys.argv[7])
    elif mode == "interval":
        if len(sys.argv) != 10:
            return 1
        packet = osc_packet_interval(
            address,
            int(sys.argv[5]),
            float(sys.argv[6]),
            int(sys.argv[7]),
            float(sys.argv[8]),
            int(sys.argv[9]),
        )
    elif mode == "target":
        if len(sys.argv) != 6:
            return 1
        packet = osc_packet_target(address, sys.argv[5])
    elif mode == "store":
        if len(sys.argv) != 6:
            return 1
        packet = osc_packet_store(address, sys.argv[5])
    elif mode == "setduration":
        if len(sys.argv) != 6:
            return 1
        packet = osc_packet_setduration(address, int(sys.argv[5]))
    else:
        return 1

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        sock.sendto(packet, (host, port))
    finally:
        sock.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
