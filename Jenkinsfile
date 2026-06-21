pipeline {
    agent {
        label "${params.AGENT_MACHINE ?: 'built-in'}"
    }

    options {
        timeout(time: 2, unit: 'MINUTES') 
    }

    parameters {
        choice(name: 'AGENT_MACHINE', choices: ['built-in', 'any'], description: 'Select the target machine')
        
        // This is only used for manual human builds
        string(name: 'FIRMWARE_VERSION', defaultValue: 'MANUAL_RUN', description: 'Enter version (Leave as-is if you want Jenkins to read from version.txt)')
    }

    environment {
        PYTHONPATH = "${WORKSPACE}"
        // env.VERSION will be assigned dynamically inside the first stage
    }

    stages {
        stage('Checkout & Detect Version') {
            steps {
                checkout scm
                
                script {
                    // 1. Check if the build was started by a GitHub Webhook push event
                    def startedByWebhook = currentBuild.buildCauses.toString().contains('GitHubPushCause')
                    
                    // 2. Decide where to get the firmware version number
                    if (startedByWebhook || params.FIRMWARE_VERSION == 'MANUAL_RUN') {
                        echo "🤖 Trigger source: Webhook (or manual run with default text). Reading version.txt..."
                        
                        // Read from the file inside your repository workspace
                        def versionFromFile = readFile('version.txt').trim()
                        env.VERSION = versionFromFile
                    } else {
                        echo "👤 Trigger source: Manual user entry."
                        
                        // Use the exact text the human typed into the Jenkins box
                        env.VERSION = params.FIRMWARE_VERSION
                    }
                    
                    echo "🎯 Final Firmware Version used for this build: ${env.VERSION}"
                }
            }
        }
        
        // ... Keep your 'Install Dependencies', 'Build', 'Unit Test', etc. exactly the same.
        // The Package stage below will automatically pick up the correct ${env.VERSION}!
    }
}

