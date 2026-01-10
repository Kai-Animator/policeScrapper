#!/bin/bash

# スクレイパーを実行するラッパースクリプト
# Wrapper script to run the scraper with environment variables

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source the config file to load LINE credentials
source "$SCRIPT_DIR/config.local.sh"

# Run the scraper
cd "$SCRIPT_DIR"
exec go run cmd/scraper/main.go
