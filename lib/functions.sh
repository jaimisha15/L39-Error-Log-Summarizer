#!/bin/bash

DATA="data/app.log"
LOG="logs/activity.log"

# Record activity
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" >> "$LOG"
}

# Check whether data exists
check_data() {
    if [ ! -f "$DATA" ]; then
        echo "Data file not found!"
        return 1
    fi
    return 0
}

# Help instructions
show_help() {
    echo "Error Log Summarizer"
    echo "Usage:"
    echo "./main.sh          - Open menu"
    echo "./main.sh --help   - Show help"
    echo "./main.sh --backup - Create backup"
    echo "./main.sh --cron   - Run scheduled task"
}

# View data
view_data() {
    check_data || return
    echo "========== LOG DATA =========="
    cat -n "$DATA"
    log "Viewed data"
}

# Create backup
do_backup() {
    mkdir -p backups
    backup_file="backups/data_$(date +%Y%m%d_%H%M%S).tar.gz"
    tar -czf "$backup_file" data/
    echo "Backup created: $backup_file"
    log "Created backup"
}

# View activity log
view_log() {
    if [ -f "$LOG" ]; then
        echo "========== ACTIVITY LOG =========="
        tail -n 15 "$LOG"
    else
        echo "No activity log found yet."
    fi
}

# Feature 1: Count INFO, WARN and ERROR
feature_1() {
    check_data || return

    echo "========== LOG SUMMARY =========="

    info_count=$(grep -c " INFO " "$DATA")
    warn_count=$(grep -c " WARN " "$DATA")
    error_count=$(grep -c " ERROR " "$DATA")

    echo "INFO  : $info_count"
    echo "WARN  : $warn_count"
    echo "ERROR : $error_count"

    log "Counted INFO, WARN and ERROR messages"
}

# Feature 2: Last 10 errors
feature_2() {
    check_data || return

    echo "========== LAST 10 ERRORS =========="
    grep " ERROR " "$DATA" | tail -n 10

    log "Displayed last 10 errors"
}

# Feature 3: Errors per day
feature_3() {
    check_data || return

    echo "========== ERRORS PER DAY =========="
    grep " ERROR " "$DATA" | awk '{print $1}' | sort | uniq -c

    log "Displayed errors per day"
}

# Feature 4: Search by keyword
feature_4() {
    check_data || return

    read -p "Enter keyword to search: " keyword

    if [ -z "$keyword" ]; then
        echo "Keyword cannot be empty."
        return
    fi

    results=$(grep -i "$keyword" "$DATA")

    if [ -z "$results" ]; then
        echo "No matching records found."
    else
        echo "========== SEARCH RESULTS =========="
        echo "$results"
    fi

    log "Searched for keyword: $keyword"
}

# Feature 5: Archive old logs
feature_5() {
    mkdir -p backups

    echo "Searching for files older than 7 days..."

    find data -type f ! -name "*.gz" -mtime +7 -exec gzip -f {} \;

    echo "Archiving task completed."

    log "Archived files older than 7 days"
}

# Cron task
cron_task() {
    mkdir -p reports logs

    report="reports/error_summary_$(date +%Y%m%d).txt"

    {
        echo "ERROR LOG SUMMARY"
        echo "Date: $(date)"
        echo
        echo "INFO: $(grep -c " INFO " "$DATA")"
        echo "WARN: $(grep -c " WARN " "$DATA")"
        echo "ERROR: $(grep -c " ERROR " "$DATA")"
        echo
        echo "Errors per day:"
        grep " ERROR " "$DATA" | awk '{print $1}' | sort | uniq -c
    } > "$report"

    find data -type f ! -name "*.gz" -mtime +7 -exec gzip -f {} \;

    echo "Cron report created: $report"

    log "Cron task executed"
}
