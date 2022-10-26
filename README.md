# scripts

This project automates the creation of a new Django project that uses Docker. It is still a work in progress.

## Installation
Clone this repository using this command ``.

## Usage
The project assumes all your code resides in one location, a directory called `code`. 

If your set up is different, edit `line 14` of `make_django.sh` to put the folder that contains your project.

To create a new project, run the command:

On Mac:

`sh scripts/make_django.sh`

On Linux:

Make the file executable and run

`./scripts/make_django.sh`

## Making your new project work

### Configuring `python-dotenv`
I usually use `python-dotenv` for managing environment variables that I need to keep private. `pytest.ini` is already configured for use with `python-dotenv`. To make this work for your project, add the following lines
to your `manage.py`.

```python
from dotenv import load_dotenv, find_dotenv
load_dotenv(find_dotenv(filename='.env'))
```

### Database Setup
The script assumes you will be using `Postgres 14`, which you can change in `docker-compose.yml` and `dj_database_url`. You need to configure the database settings in `your_project/settings.py` and add the following lines:

```python
import os
import dj_database_url

DB_USER = os.environ.get('DATABASE_USER')
DB_HOST = os.environ.get("HOST")
DB_PASSWORD = os.environ.get('DATABASE_PASSWORD') 
DB_NAME = os.environ.get("DATABASE_NAME")
DB_PORT = os.environ.get("DATABASE_PROT")

DATABASES = {
    'default': dj_database_url.config(
        default=f"postgres://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT/DB_NAME}"
        )}

```

If you are not using `dj_database_url`, then just configure your `postgres` database engine as usual.

### Running tests
You can run tests by using the following command: `coverage run -m pytest` to get coverage reports or simply run `pytest`.

### Using Docker
The scripts copied into your new project include pre-configured `Dockerfile` , `docker-compose.yml` and `.dockerignore` files. To spin up
the docker containers run `docker-compose up -d --build`.

### Making pre-commit hooks work
Make sure you have [pre-commit](https://pre-commit.com/) installed on your local machine. If not, 
install [pre-commit](https://pre-commit.com/). To make [pre-commit](https://pre-commit.com/) work, 
run this command `pre-commit install` in the terminal of your new project. You can read more on 
[pre-commit here](https://pre-commit.com/). This will make sure your code is linted using `flake8` and 
formatted using `black`.

### CI with GitHub Actions and CodeCov
The project will have scripts for checking `flake8` linting, `black` code formatting and tests for the project already configured in `.github/workflows` folder which has `django.yaml`, `black.yaml` and `flake8.yaml` scripts. The project also already has a `codecov.yaml` in the project root for `CodeCov` integration, whic you will only need to add a token for private repositories.

### Making your own customisations
The project was made to automate the minimal standard configurations I have found repeating over and over again and taking up my valuable time each time I want to start a new project. You are welcome to add some configurations that you feel may be missing for your projects.
