pipeline {
    agent any
    
    tools {
        jdk "jdk17"
        maven "maven3"
    }
    
    environment {
        SCANNER_HOME= tool 'sonar-scanner'
    }
    stages {
        stage ("clean workspace") {
            steps {
                cleanWs()
            }
        }
        
        stage ("git checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/prasanth-r-5/board-game.git'
            }
        }
        
        stage ("code compile") {
            steps {
                sh "mvn compile"
            }
        }
        
        stage ("code test") {
            steps {
                sh "mvn test"
            }
        }
        
        stage ("file scanner") {
            steps {
                sh "trivy fs --format table -o trivy-fs-report-board-game.html ."
            }
        }
        
        stage ("sonar scanner") {
            steps {
                withSonarQubeEnv("sonar") {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Board-Game -Dsonar.projectKey=Board-Game \
                        -Dsonar.java.binaries=. '''
                }
            }
        }
        
        stage ("Build") {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage ("Upload in Nexus") {
            steps {
                withMaven(globalMavenSettingsConfig: 'global-settings', jdk: 'jdk17', maven: 'maven3', mavenSettingsConfig: '', traceability: true) {
                    sh 'mvn deploy'
                }
            }
        }

        stage ("Build Docker image")
    }
}