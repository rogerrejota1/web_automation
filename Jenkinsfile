pipeline {
    agent any

    environment {
        PLAYWRIGHT_BROWSERS_PATH = "${WORKSPACE}/playwright-browsers"
    }

    stages {
        stage('Setup') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    playwright install chromium
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
                archiveArtifacts artifacts: 'reports/report.html', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            echo "Build failed: ${BUILD_URL}"
        }
    }
}