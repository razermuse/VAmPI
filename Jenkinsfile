pipeline {
    agent none 
    stages {
        stage('Build') { 
            agent {
                docker {
                    image 'python:3' 
                }
            }
            steps {
                sh 'pip3 install -r requirements.txt' 
                sh 'python3 app.py'
            }
        }
    }
}
