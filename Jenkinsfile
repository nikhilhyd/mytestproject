pipeline {
    agent any

    environment {
        PYTHONPATH = "${WORKSPACE}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nikhilhyd/mytestproject.git'
            }
        }

        stage('Package') {
            steps {
        script {

            // 1: Version number (you can set manually or read from file)
            def version = "1.0.0"

            // 2: Timestamp
            def timestamp = bat(script: "date +%Y%m%d_%H%M%S", returnStdout: true).trim()

            // Build filename → e.g. source_v1.0.0_20250212_153455.zip
            def zipName = "source_v${version}_${timestamp}.zip"

            echo "Creating package: ${zipName}"

            // 3: Package only selected folders
        bat 'powershell Compress-Archive -Path * -DestinationPath source_code.zip'
        archiveArtifacts artifacts: 'source_code.zip', fingerprint: true
        }
            }
        }

        stage('Build') {
            steps {
                bat 'echo Building...'
            }
        }

        stage('Unit Test') {
            steps {
                bat 'pytest --maxfail=1 --disable-warnings -q --html=reports/pytest-report.html --self-contained-html --cov=calculator --cov-report=xml:reports/coverage.xml --cov-report=html:reports/coverage-html'
            }
        }
    }
}