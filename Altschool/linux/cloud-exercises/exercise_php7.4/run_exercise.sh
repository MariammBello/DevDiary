#!/bin/bash


# This bash script only aims at creatin the submission content
# Create directory called 'altschool' in the current directory
mkdir -p altschool

# Navigate into the 'altschool' directory
cd altschool

# Create output files with specified content
cat /etc/apt/sources.list.d/ondrej-ubuntu-php-jammy.list >> php_sources_list.d_output.txt
cat /etc/apt/sources.list >> sources_list_output.txt
php -v > php_version_output.txt

# Go back to the original directory (one level up)
cd ..

# Copy the script itself into the 'altschool' directory
cp "$0" altschool/

echo "The 'altschool' directory, output files, and script copy have been created successfully."
