#!/bin/bash

# Script settings
PROJECT_DIR="$(dirname "$0")/.."   # Project directory
DATA_DIR="$PROJECT_DIR/2_data"    # Directory for raw data
RESULT_DIR="$PROJECT_DIR/3_results" # Directory for formatted results
LOG_DIR="$PROJECT_DIR/5_logs"     # Directory for logs
LOG_FILE="$LOG_DIR/format_data.log"
INPUT_FILE="$DATA_DIR/open_registry_data.json" # Raw data file
OUTPUT_FILE="$RESULT_DIR/formatted_data.json"  # Formatted data file

# Create directories if they don't exist
mkdir -p "$RESULT_DIR" "$LOG_DIR"

# Log start time
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting JSON formatting" >> "$LOG_FILE"

# Check if input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Input file $INPUT_FILE not found" >> "$LOG_FILE"
    echo "Error: Input file $INPUT_FILE not found"
    exit 1
fi

# Format JSON using Python's json.tool
echo "$(date '+%Y-%m-%d %H:%M:%S') - Formatting data from $INPUT_FILE" >> "$LOG_FILE"
python -m json.tool < "$INPUT_FILE" > "$OUTPUT_FILE" 2>> "$LOG_FILE"

# Check if formatting was successful
if [[ $? -eq 0 ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Data successfully formatted and saved to $OUTPUT_FILE" >> "$LOG_FILE"
    echo "Data successfully formatted and saved to $OUTPUT_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Failed to format data" >> "$LOG_FILE"
    echo "Error: Failed to format data"
    exit 1
fi

# Log end time
echo "$(date '+%Y-%m-%d %H:%M:%S') - JSON formatting completed" >> "$LOG_FILE"