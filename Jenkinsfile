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
                sh 'echo Building...'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'pytest'
            }
        }
    }
}
