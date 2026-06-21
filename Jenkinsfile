pipeline {
    // 1. Parameterized Agent: Dynamically targets the node label chosen by the user
    agent {
        label "${params.AGENT_MACHINE}"
    }

    // Parameters block defines the UI choices for the user
    parameters {
        choice(name: 'AGENT_MACHINE', choices: ['any', 'windows-node', 'linux-node'], description: 'Select the target machine/node for this build')
        string(name: 'FIRMWARE_VERSION', defaultValue: '1.0.0', description: 'Enter the firmware version number')
    }

    environment {
        PYTHONPATH = "${WORKSPACE}"
        // 2. Parameterized Version: Reads the value typed in by the user
        VERSION    = "${params.FIRMWARE_VERSION}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Build') {
            steps {
                bat 'python -m compileall .'
                echo "Build OK on branch: ${env.BRANCH_NAME}"
            }
        }

        stage('Unit Test') {
            steps {
                bat 'if not exist reports mkdir reports'
                bat '''pytest tests/ --maxfail=1 --disable-warnings -q ^
                    --html=reports/pytest-report.html ^
                    --self-contained-html ^
                    --cov=calculator ^
                    --cov-report=xml:reports/coverage.xml ^
                    --cov-report=html:reports/coverage-html'''
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'reports/*.xml'
                    archiveArtifacts artifacts: 'reports/**', allowEmptyArchive: true
                }
            }
        }

        stage('Integration Test') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'main'
                }
            }
            steps {
                bat 'pytest tests/integration/ --junitxml=reports/integration.xml -v'
            }
        }

        stage('PR Quality Gate') {
            when { changeRequest() }
            steps {
                script {
                    def failCount = currentBuild.testResultAction?.failCount ?: 0
                    if (failCount > 0) {
                        error("PR BLOCKED: ${failCount} test(s) are failing. Fix before merging.")
                    }
                    echo "Quality gate PASSED — this PR is safe to merge"
                }
            }
        }

        stage('Package') {
            when { branch 'main' }
            steps {
                script {
                    def timestamp = powershell(
                        returnStdout: true,
                        script: 'Get-Date -Format "yyyyMMdd_HHmmss"'
                    ).trim()
                    def zipName = "package_v${env.VERSION}_${env.BUILD_NUMBER}_${timestamp}.zip"
                    echo "Packaging: ${zipName}"
                    powershell """
                        \$paths = @('__init__.py', 'calculator.py', 'requirements.txt')
                        \$existing = \$paths | Where-Object { Test-Path \$_ }
                        if (-not \$existing) { Write-Error 'No files found!'; exit 1 }
                        Compress-Archive -Path \$existing -DestinationPath ${zipName} -Force
                    """
                    archiveArtifacts artifacts: "${zipName}", fingerprint: true
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline PASSED on ${env.BRANCH_NAME} — build #${env.BUILD_NUMBER}"
            build job: 'freestyle1', wait: false
        }
        failure {
            echo "Pipeline FAILED on ${env.BRANCH_NAME} — build #${env.BUILD_NUMBER}"
        }
        always {
            cleanWs()
        }
    }
}

