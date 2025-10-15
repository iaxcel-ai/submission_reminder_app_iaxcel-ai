#!/bin/bash

#prompt the user for their name
read -p "Enter your name:" name

#always convert the name to lowercase

name=$(echo "$name" | tr '[:upper:]' '[:lower:]')

# check if the name is empty

if [ -z "$name" ]; then
  echo "Name cannot be empty. Run the script again and enter a valid name."
  exit 1
fi

# check if the name is valid

if [[ ! "$name" =~ ^[a-zA-Z]+$ ]]; then
  echo "The name is invalid."
  exit 1
fi

dir="submission_reminder_$name"
submissions_file="$dir/assets/submissions.txt"
config_file="$dir/config/config.env"

# check if the directory already exists

if [ ! -d "$dir" ]; then
  echo "Directory $dir does not exist."
exit 1
fi

read -p "input the assignment name: " assignment
read -p "input the number of days remaining for submission: " days

# check if the assignment name is not empty and is valid

if [[ -z "$assignment" ]]; then
  echo "Assignment name cannot be empty. Run the script again and enter a valid name."
  exit 1
fi

if [[ ! "$assignment" =~ ^[a-zA-Z\ ]+$ ]]; then
  echo "The assignment name is invalid. Run the script again and enter a valid name."
  exit 1
fi

# check if the days remaining is a number

if ! [[ "$days" =~ ^[0-9]+$ ]]; then
  echo "Days remaining must be a number. Run the script again and enter a valid number."
  exit 1
fi

# check if assignment exists in submissions.txt

matched_assignment=$(grep -i "$assignment" "$submissions_file" | awk -F, '{print $2}' | head -n 1 | xargs)
if [ -z "$matched_assignment" ]; then
  echo "No matching assignment found in submissions.txt. Please check the assignment name and try again."
  exit 1
fi
# update config file with assignment and days remaining

cat << EOF > "$config_file"
ASSIGNMENT="$matched_assignment"
DAYS_REMAINING=$days
EOF

read -p "do you want to run the reminder script now? (y/n): " run

# input validation for run variable

if [[ "$run" =~ ^[Yy]$ ]]; then
  echo "Running app..."
  cd "$dir"
  ./startup.sh
else
  echo "You can run the reminder script later by going to the $dir directory and executing ./startup.sh."
fi