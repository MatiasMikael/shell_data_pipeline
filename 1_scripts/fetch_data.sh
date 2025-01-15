#!/bin/bash

# Script settings
PROJECT_DIR="$(dirname "$0")/.."   # Project directory (one level up from script)
DATA_DIR="$PROJECT_DIR/2_data"    # Directory for storing fetched data
LOG_DIR="$PROJECT_DIR/5_logs"     # Directory for storing logs
LOG_FILE="$LOG_DIR/fetch_data.log"
API_URL="https://public.api.avoimuusrekisteri.fi/open-data-register-notification" # API endpoint
OUTPUT_FILE="$DATA_DIR/open_registry_data.json"

# Create directories if they don't exist
mkdir -p "$DATA_DIR" "$LOG_DIR"

# Log start time
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting data fetch from $API_URL" >> "$LOG_FILE"

# Check if output file already exists
if [[ -f "$OUTPUT_FILE" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Warning: Overwriting existing file $OUTPUT_FILE" >> "$LOG_FILE"
fi

# Fetch data from API
echo "$(date '+%Y-%m-%d %H:%M:%S') - Fetching data from $API_URL..." >> "$LOG_FILE"
curl -s -o "$OUTPUT_FILE" "$API_URL"

# Check if the fetch was successful
if [[ $? -eq 0 ]]; then
    if [[ -s "$OUTPUT_FILE" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Data successfully fetched and saved to $OUTPUT_FILE" >> "$LOG_FILE"
        echo "Data successfully fetched and saved to $OUTPUT_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: File $OUTPUT_FILE is empty" >> "$LOG_FILE"
        echo "Error: File $OUTPUT_FILE is empty"
        exit 1
    fi
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Failed to fetch data from $API_URL" >> "$LOG_FILE"
    echo "Error: Failed to fetch data from $API_URL"
    exit 1
fi

# Log end time
echo "$(date '+%Y-%m-%d %H:%M:%S') - Data fetch completed" >> "$LOG_FILE"