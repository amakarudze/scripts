# scripts

This project automates the creation of a new Django project that uses Docker. It is still a work in progress.

## Installation
Clone this repository using this command ``.

## Usage
The project assumes all your code resides in one location, a directory called `code`. 

If your set up is different, edit `line 14` of `make_django.sh`.

To create a new project, run the command:

On Mac:

`sh scripts/make_django.sh`

On Linux:

Make the file executable and run

`./scripts/make_django.sh`

## Making your new project work
### Making pre-commit hooks work
If the pre-commit install fails, install [pre-commit](https://pre-commit.com/). To make [pre-commit](https://pre-commit.com/) work, run this command `pre-commit install` in the terminal of your new project. You can read more on 
[pre-commit here](https://pre-commit.com/). This will make sure your code is linted using `flake8` and 
formatted using `black`.

