
# L39 – Error Log Summarizer

## Problem
The Error Log Summarizer is a Linux-based project that helps users summarize application log files. It displays INFO, WARN and ERROR messages, shows recent errors, searches for keywords and archives old log files.

## Who Will Use It
This project can be used by system administrators and technical support teams to check application logs and identify errors easily.

## Folder Structure
- `main.sh` – Main script that displays the project menu.
- `lib/functions.sh` – Contains all project functions and features.
- `data/` – Stores the application log file.
- `reports/` – Stores generated error summary reports.
- `logs/` – Stores project activity and cron logs.
- `backups/` – Stores backup files.
- `README.md` – Contains project information and instructions.

## Features
1. Count INFO, WARN and ERROR messages.
2. Display the last 10 errors.
3. Show errors per day.
4. Search log records using a keyword.
5. Archive files older than 7 days using `find` and `gzip`.
6. View application log data.
7. Create a backup of the data folder.
8. View project activity logs.
9. Generate an automatic error summary report using cron.

## How to Run
Open the Ubuntu terminal and enter:

```bash
cd ~/linux_project/errsummary
chmod +x main.sh
./main.sh
```

To display help:

```bash
./main.sh --help
```

To create a backup:

```bash
./main.sh --backup
```

To run the scheduled task manually:

```bash
./main.sh --cron
```

## My Crontab Line and What It Means

```bash
0 2 * * * /bin/bash $HOME/linux_project/errsummary/main.sh --cron >> $HOME/linux_project/errsummary/logs/cron.log 2>&1
```

Explanation of the five time fields:

- `0` – Minute (0)
- `2` – Hour (2 AM)
- `*` – Every day of the month
- `*` – Every month
- `*` – Every day of the week

This cron job runs the script every day at 2 AM. It generates an error summary report and archives files older than 7 days.

## Commands I Used and Why
- `grep` – To search and count log messages.
- `awk` – To extract dates and summarize errors.
- `tail` – To display the last 10 errors.
- `find` – To locate files older than 7 days.
- `gzip` – To compress old log files.
- `tar` – To create backup archives.
- `chmod` – To give execution permission to the script.
- `crontab` – To schedule automatic execution.
- `mkdir` – To create required directories.

## What I Learned
Through this project, I learned how to write and execute Bash scripts in Linux. I understood how to use commands such as grep, awk, tail, find and gzip. I also learned how to create backups and schedule automatic tasks using cron. This project improved my understanding of Linux commands and shell scripting.
