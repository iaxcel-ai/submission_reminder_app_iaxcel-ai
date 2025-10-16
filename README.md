# Submission Reminder Application

This application is a simple shell-based tool to check for pending assignment submissions and send reminders.

## Table of Contents
- [How to Run the Application](#how-to-run-the-application)
  - [Create the Application Environment](#create-the-application-environment)
  - [Navigate to the Application Directory](#navigate-to-the-application-directory)
  - [Run the Application](#run-the-application)
- [How it Works](#how-it-works)

## How to Run the Application

### Create the Application Environment
First, you need to run the `create_environment.sh` script. This script will set up the necessary directory structure and files for the application.
    
    ```bash
    ./create_environment.sh
    ```

    When you run this script, it will prompt you to enter your name. The script will then create a new directory named `submission_reminder_<your_name>`.

### Navigate to the Application Directory
Change your current directory to the one that was just created.

    ```bash
    cd submission_reminder_<your_name>
    ```
    *(Replace `<your_name>` with the name you entered in the previous step)*.

### Run the Application
Inside the new directory, there is a `startup.sh` script. Execute this script to run the reminder application.

    ```bash
    ./startup.sh
    ```

## How it Works

The application consists of several shell scripts that work together:

*   **`create_environment.sh`**: This script scaffolds the entire application, creating all the necessary files and directories.
*   **`startup.sh`**: This is the main entry point to run the application. It simply executes the `reminder.sh` script.
*   **`app/reminder.sh`**: This is the core script. It sources the configuration and functions, and then calls the function to check submission statuses.
*   **`modules/functions.sh`**: This script contains the `check_submissions` function, which reads the `submissions.txt` file and identifies students who have not submitted the required assignment.
*   **`config/config.env`**: This file contains configuration variables for the application, such as the assignment name (`ASSIGNMENT`) and the days remaining for submission (`DAYS_REMAINING`).
*   **`assets/submissions.txt`**: This is a file that contains the list of students, the assignment, and their submission status.

When you run `startup.sh`, it will check the `submissions.txt` file and print a reminder for each student who has a "not submitted" status for the assignment defined in `config.env`.
