pipeline {
    agent any

    tools {
        python 'Python 3.11'
    }

    environment {
        PLAYWRIGHT_BROWSERS_PATH = "${WORKSPACE}/playwright-browsers"
    }

    stages {
        stage('Setup') {
            steps {
                sh '''
                    python -m venv .venv
                    . .venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    playwright install --with-deps chromium
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    . .venv/bin/activate
                    pytest --junitxml=test-results/results.xml --html=reports/report.html --self-contained-html
                '''
            }
        }

        stage('Publish Results') {
            steps {
                junit 'test-results/results.xml'
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'reports',
                    reportFiles: 'report.html',
                    reportName: 'Playwright Test Report'
                ])
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            emailext (
                subject: "Jenkins Build Failed: ${JOB_NAME} - ${BUILD_NUMBER}",
                body: "Build failed: ${BUILD_URL}",
                to: "${EMAIL_RECIPIENTS}"
            )
        }
    }
}