#!/bin/bash

# Greet user
echo "This script creates a new Django project for you with CI templates."
read -p "Do you want to continue? Enter y for yes and n for no " user_consent

if [ $user_consent == "n" ]
  then 
    echo "Quiting..."
    exit
fi

# Navigate to the code folder 
cd code

# Get name of project root folder and create a new directory
read -p "Enter the name of the project root folder: " project_root
mkdir $project_root

# Copy scripts to the new project
cp scripts/requirements.in $project_root
cp scripts/requirements.txt $project_root
cp scripts/dev-requirements.txt $project_root
cp scripts/pytest.ini $project_root
cp scripts/LICENCE $project_root 
cp scripts/.dockerignore $project_root
cp scripts/Dockerfile $project_root
cp scripts/setup.cfg $project_root
cp scripts/docker-compose.yaml $project_root
cp scripts/.env_example $project_root
cp -r scripts/.github $project_root
cp scripts/codecov.yaml $project_root
cp scripts/.pre-commit-config.yaml $project_root
cp scripts/.gitignore $project_root

# Navigate to new folder and create a virtual environment
cd $project_root
python3.10 -m venv .venv
source .venv/bin/activate

# Install requirements
pip install --upgrade pip
pip install -r dev-requirements.txt
pip-compile
pip install -r requirements.txt

# Create a new django project
read -p "Enter the name of the django project you want to create: " project_name
django-admin startproject $project_name .
read -p "Enter the name of your new app: " app_name
python manage.py startapp $app_name

sed "2 i DJANGO_SETTINGS_MODULE=$project_name.settings" pytest.ini

echo "# $project_name" >> README.md
read -p "Enter a short description for your project: " project_description
sed "2 i $project_description" README.md

# Create a .env file for settings
cp .env_example .env

# Initialize git 
git init

# Install pre-commit
pre-commit install

# The end!
echo "Your new django project $django_project created successfully!"