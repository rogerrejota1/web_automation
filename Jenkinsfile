pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/playwright:v1.63.0-jammy'
            args '-u root -v $HOME/.cache/playwright:/root/.cache/playwright'
            reuseNode true
        }
    }

    environment {
        PLAYWRIGHT_BROWSERS_PATH = "${WORKSPACE}/playwright-browsers"
        BASE_URL = 'https://www.saucedemo.com'
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '5'))
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                    pip install --no-cache-dir -r requirements.txt
                    playwright install chromium
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    pytest --junitxml=test-results/results.xml --html=reports/report.html --self-contained-html
                '''
            }
        }

        stage('Publish Results') {
            steps {
                junit 'test-results/results.xml'
                archiveArtifacts artifacts: 'reports/report.html', allowEmptyArchive: true
                archiveArtifacts artifacts: 'test-results/results.xml', allowEmptyArchive: true
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