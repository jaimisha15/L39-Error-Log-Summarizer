#!/bin/bash

# Main program for Error Log Summarizer

cd "$(dirname "$0")" || exit 1

source lib/functions.sh

# Command-line arguments
case "$1" in
    --help)
        show_help
        exit
        ;;
    --backup)
        do_backup
        exit
        ;;
    --cron)
        cron_task
        exit
        ;;
esac

# Main menu
while true
do
    echo "================================="
    echo "     ERROR LOG SUMMARIZER"
    echo "================================="
    echo "1. Count INFO / WARN / ERROR"
    echo "2. Last 10 Errors"
    echo "3. Errors Per Day"
    echo "4. Search by Keyword"
    echo "5. Archive Logs Older Than 7 Days"
    echo "6. View Data"
    echo "7. Backup Data"
    echo "8. View Activity Log"
    echo "0. Exit"
    echo "================================="

    read -p "Enter your choice: " choice

    case "$choice" in
        1) feature_1 ;;
        2) feature_2 ;;
        3) feature_3 ;;
        4) feature_4 ;;
        5) feature_5 ;;
        6) view_data ;;
        7) do_backup ;;
        8) view_log ;;
        0)
            echo "Thank you for using Error Log Summarizer!"
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

done
