#!/usr/bin/env python3
"""Install a Python package using pip."""
import argparse
import json
import subprocess
import sys

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--package", required=True)
    args = parser.parse_args()
    try:
        process = subprocess.Popen(
            [sys.executable, "-m", "pip", "install", args.package],
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1)
        for line in process.stdout:
            print(line, end="", flush=True)
        process.wait()
        if process.returncode == 0:
            print(json.dumps({"success": True}))
        else:
            print(json.dumps({"success": False, "error": f"pip exited with code {process.returncode}"}))
            sys.exit(1)
    except Exception as e:
        print(json.dumps({"success": False, "error": str(e)}))
        sys.exit(1)

if __name__ == "__main__":
    main()
