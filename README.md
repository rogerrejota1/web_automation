# Web Automation Project

Automatización de pruebas con Playwright + Pytest, lista para Jenkins, GitHub Actions y ejecución local via Docker.

## Ejecución rápida

### Con Docker (recomendado, portable)
```bash
# Headless (CI/CD)
./run-tests.sh docker

# Visible (headed)
./run-tests.sh headed

# Debug interactivo
./run-tests.sh debug
```

### Local (desarrollo)
```bash
./run-tests.sh local
# o con Make
make local-test
```

### Con Make (cross-platform)
```bash
make test        # Docker headless
make test-headed # Docker visible
make test-debug  # Debug interactivo
make build       # Construir imagen
make clean       # Limpiar artifacts
```

## CI/CD

### Jenkins
- Usa `Jenkinsfile` con agent Docker
- No requiere Python/Node en el agente
- Reportes JUnit + HTML archivados

### GitHub Actions
- Workflow en `.github/workflows/playwright.yml`
- Ejecuta en push/PR a main/develop

## Estructura
```
├── tests/              # Tests organizados por feature
│   ├── login/
│   ├── products/
│   └── cart/
├── pages/              # Page Object Model
├── Dockerfile          # Imagen de test portable
├── docker-compose.yml  # Servicios de test
├── Jenkinsfile         # Pipeline Jenkins
├── Makefile            # Comandos cross-platform
├── run-tests.sh        # Script unificado
├── requirements.txt    # Dependencias Python
└── pytest.ini         # Config pytest
```

## Reportes
- `test-results/results.xml` - JUnit (Jenkins/GitHub)
- `reports/report.html` - HTML pytest
- `playwright-report/` - HTML Playwright (traces, screenshots, videos)

## Variables de entorno
- `BASE_URL` - URL base (default: https://www.saucedemo.com)
- `PLAYWRIGHT_HEADLESS` - false para modo visible
- `PLAYWRIGHT_BROWSERS_PATH` - Cache de navegadores