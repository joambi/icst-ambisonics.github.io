#!/usr/bin/env python3
import socket
import sys


def build_message(address: str, mode: str, args: list[str]) -> str | None:
    if mode == "start":
        if len(args) != 3:
            return None
        marker_index, marker_pos, marker_name = args
        return f"{address} {marker_index} {marker_pos} {marker_name}".strip()
    if mode == "interval":
        if len(args) != 5:
            return None
        marker1_index, marker1_pos, marker2_index, marker2_pos, diff_ms = args
        return f"{address} {marker1_index} {marker1_pos} {marker2_index} {marker2_pos} {diff_ms}"
    if mode == "target":
        if len(args) != 1:
            return None
        scene_name = args[0]
        return f"{address} {scene_name}".strip()
    return None


def main() -> int:
    if len(sys.argv) < 5:
        return 1

    host = sys.argv[1]
    port = int(sys.argv[2])
    address = sys.argv[3]
    mode = sys.argv[4]

    message = build_message(address, mode, sys.argv[5:])
    if message is None:
        return 1

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        sock.sendto(message.encode("utf-8"), (host, port))
    finally:
        sock.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
