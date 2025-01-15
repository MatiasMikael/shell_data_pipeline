#!/bin/bash

# Log file
LOG_FILE="5_logs/analyze_data.log"

# Create the log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Start logging
echo "Starting data analysis: $(date)" > "$LOG_FILE"

# Check if the input JSON file exists
if [ ! -f "3_results/formatted_data.json" ]; then
    echo "Error: 3_results/formatted_data.json not found!" | tee -a "$LOG_FILE"
    exit 1
fi

# Query 1: Count the total number of companies
COMPANY_COUNT=$(grep -o '"id":' 3_results/formatted_data.json | wc -l)
echo -e "\n===== Total Number of Companies =====" | tee -a "$LOG_FILE"
echo "Number of companies: $COMPANY_COUNT" | tee -a "$LOG_FILE"

# Query 2: List all unique main industries
echo -e "\n===== Unique Main Industries =====" | tee -a "$LOG_FILE"
grep '"mainIndustry":' 3_results/formatted_data.json | sed 's/.*"mainIndustry": "\(.*\)",/\1/' | sort | uniq | tee -a "$LOG_FILE"

# Query 3: Count the number of companies registered in 2025
COUNT_2025=$(grep '"registrationDate": "2025' 3_results/formatted_data.json | wc -l)
echo -e "\n===== Companies Registered in 2025 =====" | tee -a "$LOG_FILE"
echo "Companies registered in 2025: $COUNT_2025" | tee -a "$LOG_FILE"

# Query 4: Find the top 3 most common main industries
echo -e "\n===== Top 3 Main Industries =====" | tee -a "$LOG_FILE"
grep '"mainIndustry":' 3_results/formatted_data.json | sed 's/.*"mainIndustry": "\(.*\)",/\1/' | sort | uniq -c | sort -nr | head -3 | tee -a "$LOG_FILE"

# End logging
echo -e "\n===== Data Analysis Completed =====" | tee -a "$LOG_FILE"
echo "Data analysis completed: $(date)" >> "$LOG_FILE"