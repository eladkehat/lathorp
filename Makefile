all: help

help:
	@echo "version      - Display the current version from setup.py."
	@echo "lint         - Run flake8, mypy."
	@echo "test         - Run pytest."
	@echo "coverage     - Measure code coerage."
	@echo "clean        - Remove build artifacts."
	@echo "build        - Generate distribution packages."
	@echo "publish      - Publish to PyPI, if lint, tests and coverage all pass."

version:
	python3 setup.py --version

lint:
	flake8
	mypy lathorp

test:
	python3 -m pytest -vv

coverage:
	python3 -m pytest --cov=lathorp --cov-fail-under=100 --cov-report=term --cov-report=html

clean: clean-pyc clean-build

clean-pyc:
	-find . -type f -a \( -name "*.pyc" -o -name "*$$py.class" \) | xargs rm
	-find . -type d -name "__pycache__" | xargs rm -r

clean-build:
	rm -rf build/ dist/ .eggs/ *.egg-info/

build:
	python3 setup.py sdist bdist_wheel

publish: lint coverage clean build
	python3 -m twine upload dist/*
