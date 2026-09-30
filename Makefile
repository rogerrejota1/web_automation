.PHONY: help test test-headed test-debug build docker-build docker-run clean

help:
	@echo "Comandos disponibles:"
	@echo "  make test          - Ejecuta tests en Docker (headless)"
	@echo "  make test-headed   - Ejecuta tests en Docker (visible)"
	@echo "  make test-debug    - Ejecuta tests en modo debug (interactivo)"
	@echo "  make build         - Construye la imagen Docker"
	@echo "  make clean         - Limpia artifacts de test"

test:
	docker compose run --rm test

test-headed:
	docker compose run --rm test-headed

test-debug:
	docker compose run --rm test-debug

build:
	docker compose build

docker-build:
	docker build -t web-automation-tests .

docker-run:
	docker run --rm -v $(PWD)/test-results:/app/test-results -v $(PWD)/reports:/app/reports web-automation-tests

clean:
	rm -rf test-results reports playwright-report .pytest_cache __pycache__ pages/__pycache__ tests/**/__pycache__
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true

# Local development (requires local Python/Playwright)
local-install:
	python -m venv .venv
	. .venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt && playwright install chromium

local-test:
	. .venv/bin/activate && pytest --junitxml=test-results/results.xml --html=reports/report.html --self-contained-html

local-test-headed:
	. .venv/bin/activate && PLAYWRIGHT_HEADLESS=false pytest --junitxml=test-results/results.xml --html=reports/report.html --self-contained-html