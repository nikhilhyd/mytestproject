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
                bat 'echo Packaging'
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