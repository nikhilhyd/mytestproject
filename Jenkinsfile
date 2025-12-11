pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nikhilhyd/mytestproject.git'
            }
        }

        stage('Build') {
            steps {
                bat 'echo Building...'
            }
        }

        stage('Unit Test') {
            steps {
                bat 'pytest'
            }
        }
    }
}
