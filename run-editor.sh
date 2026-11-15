#!/bin/sh
# macOS / Linux: private virtual environment + locked requirements, then the editor on http://localhost:8010/
cd "$(dirname "$0")" && exec python3 launcher.py
