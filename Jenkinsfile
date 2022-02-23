pipeline {
    agent none 
    stages {
        stage('Build') { 
            agent {
                docker {
                    image 'python:2-alpine' 
                }
            }
            steps {
                sh 'pip3 install -r requirements.txt' 
                sh 'python3 app.py'
            }
        }
    }
}
