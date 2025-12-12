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
            // 1: Version (static or read from file)
            def version = "1.0.0"

            // 2: Timestamp using PowerShell
            def timestamp = powershell(returnStdout: true, script: """
                Get-Date -Format "yyyyMMdd_HHmmss"
            """).trim()

            // Build filename → example: source_v1.0.0_20250212_154225.zip
            def zipName = "source_v${version}_${timestamp}.zip"

            echo "Packaging Windows ZIP: ${zipName}"

            // 3: Package only specific folders on Windows
            // NOTE: Compress-Archive cannot exclude patterns like .git,
            // so we simply do not include .git in the folder list.
            powershell """
                \$folders = @('src', 'config', 'scripts')
                Compress-Archive -Path \$folders -DestinationPath ${zipName} -Force
            """

            // Archive the zip as Jenkins artifact
            archiveArtifacts artifacts: "${zipName}", fingerprint: true
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