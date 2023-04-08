VENV_NAME = .venv

# Determine the virtual environment directory based on the operating system
ifeq ($(OS),Windows_NT)
    VENV_DIR = $(VENV_NAME)\Scripts
else
    VENV_DIR = $(VENV_NAME)/bin
endif

PYTHON = $(VENV_DIR)/python
PIP = $(VENV_DIR)/pip


setup:
	python -m venv $(VENV_NAME)

source:
	. $(VENV_DIR)/activate

install: requirements.txt
	$(PIP) install --upgrade pip &&\
		$(PIP) install -r requirements.txt

lint-force:
	black . --exclude $(VENV_NAME)

lint-check:
	black --check . --exclude $(VENV_NAME)
	flake8 . --exclude $(VENV_NAME)
	pylint --disable=R,C,pointless-string-statement *.py --ignore=$(VENV_NAME)

test:
	coverage run -m pytest -vv ./tests

clean:
	rm -rf __pycache__
	rm -rf $(VENV_NAME)
