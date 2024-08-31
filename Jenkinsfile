pipeline {
    agent any

    tools {
        maven 'Maven' // Make sure Maven is configured in Jenkins under Global Tool Configuration
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/sohelmohammed0/spring-petclinic.git'
            }
        }

        stage('Build') {
            steps {
                // Run Maven build
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run tests
                sh 'mvn test'
            }
        }

        stage('Static Code Analysis') {
            steps {
                // Perform static code analysis (optional)
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('Deploy') {
            steps {
                // Placeholder for deployment steps
                echo 'Deploying to server...'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
            junit '**/target/surefire-reports/*.xml'
        }
        success {
            echo 'Build and test stages completed successfully!'
        }
        failure {
            echo 'Build or test stage failed.'
        }
    }
}

