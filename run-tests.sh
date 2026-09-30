#!/usr/bin/env bash
# run-tests.sh - Cross-platform test runner

set -e

echo "========================================="
echo "  Web Automation - Test Runner"
echo "========================================="
echo ""

MODE=${1:-docker}

case $MODE in
    docker)
        echo "Ejecutando tests en Docker (headless)..."
        docker compose run --rm test
        ;;
    headed)
        echo "Ejecutando tests en Docker (visible)..."
        docker compose run --rm test-headed
        ;;
    debug)
        echo "Ejecutando tests en modo debug..."
        docker compose run --rm test-debug
        ;;
    local)
        echo "Ejecutando tests localmente..."
        if [ ! -d ".venv" ]; then
            echo "Creando entorno virtual..."
            python -m venv .venv
            . .venv/bin/activate
            pip install --upgrade pip
            pip install -r requirements.txt
            playwright install chromium
        else
            . .venv/bin/activate
        fi
        pytest --junitxml=test-results/results.xml --html=reports/report.html --self-contained-html
        ;;
    *)
        echo "Uso: ./run-tests.sh [docker|headed|debug|local]"
        echo ""
        echo "  docker   - Headless en Docker (default, CI/CD)"
        echo "  headed   - Visible en Docker"
        echo "  debug    - Interactivo con slowmo"
        echo "  local    - Usa Python local (desarrollo)"
        exit 1
        ;;
esac

echo ""
echo "========================================="
echo "  Tests completados"
echo "========================================="
echo "Reportes:"
echo "  - test-results/results.xml (JUnit)"
echo "  - reports/report.html (HTML)"
echo "  - playwright-report/ (Playwright)"