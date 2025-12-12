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

            def version = "1.0.0"

            def timestamp = powershell(returnStdout: true, script: """
                Get-Date -Format "yyyyMMdd_HHmmss"
            """).trim()

            def zipName = "package_v${version}_${timestamp}.zip"

            echo "Packaging: ${zipName}"

            // ZIP only specific files/folders on Windows
            powershell """
                \$paths = @(
                    'calculator.py',
                    'requirements.txt',
                    'tests'
                )

                # Filter only items that actually exist
                \$existing = \$paths | Where-Object { Test-Path \$_ }

                if (-not \$existing) {
                    Write-Host 'ERROR: None of the specified items exist!' -ForegroundColor Red
                    exit 1
                }

                Compress-Archive -Path \$existing -DestinationPath ${zipName} -Force
            """

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