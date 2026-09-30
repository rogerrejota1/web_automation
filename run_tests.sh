#!/bin/bash
# Run tests locally with Playwright

set -e

echo "Setting up virtual environment..."
python -m venv .venv
source .venv/bin/activate

echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Installing Playwright browsers..."
playwright install --with-deps chromium

echo "Running tests..."
pytest --junitxml=test-results/results.xml --html=reports/report.html --self-contained-html

echo "Tests completed. Reports available in:"
echo "  - test-results/results.xml (JUnit)"
echo "  - reports/report.html (HTML)"
echo "  - playwright-report/ (Playwright HTML)"