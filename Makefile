# This Makefile will:
# - setup a python environment
# - install requirements
# - lint and test code
# - clean up the venv
# Configured to work for a linux environment


# variables

VENV_NAME = .venv


# targets

setup:
	python -m venv $(VENV_NAME)

source:
	. $(VENV_NAME)/bin/activate

install: requirements.txt
	python -m pip install --upgrade pip &&\
		python -m pip install -r requirements.txt

lint-force:
	python -m black . --exclude $(VENV_NAME)

lint-check:
	python -m black --check . --exclude $(VENV_NAME)
	python -m flake8 . --exclude $(VENV_NAME)
	python -m pylint --disable=R,C,pointless-string-statement *.py --ignore=$(VENV_NAME)

test:
	python -m coverage run -m pytest -vv ./tests

clean:
	rm -rf __pycache__
	rm -rf $(VENV_NAME)
