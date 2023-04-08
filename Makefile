setup:
	python -m venv .venv

source:
	. .venv/bin/activate

install: requirements.txt
	pip install --upgrade pip &&\
		pip install -r requirements.txt

lint-force:
	black . --exclude .venv

lint-check:
	black --check . --exclude .venv
	flake8 . --exclude .venv
	pylint --disable=R,C,pointless-string-statement *.py --ignore=.venv

test:
	coverage run -m pytest -vv ./tests

clean:
	rm -rf __pycache__
	rm -rf .venv