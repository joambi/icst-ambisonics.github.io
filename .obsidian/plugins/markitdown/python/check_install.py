#!/usr/bin/env python3
"""Check Python environment and installed packages."""
import argparse
import json
import sys

ALLOWED_PACKAGES = {"markitdown"}

def check_package(name):
    if name not in ALLOWED_PACKAGES:
        return {"installed": False, "version": None}
    if name == "markitdown":
        try:
            from markitdown import MarkItDown
        except (ImportError, AttributeError, TypeError):
            return {"installed": False, "version": None}
    try:
        from importlib.metadata import version, PackageNotFoundError
        try:
            ver = version(name)
            return {"installed": True, "version": ver}
        except PackageNotFoundError:
            return {"installed": False, "version": None}
    except ImportError:
        try:
            import pkg_resources
            ver = pkg_resources.get_distribution(name).version
            return {"installed": True, "version": ver}
        except Exception:
            return {"installed": False, "version": None}

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", required=True)
    args = parser.parse_args()
    packages = ["markitdown"] if args.check == "all" else [args.check]
    result = {"python_version": f"{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}", "packages": {}}
    for pkg in packages:
        result["packages"][pkg] = check_package(pkg)
    print(json.dumps(result))

if __name__ == "__main__":
    main()
