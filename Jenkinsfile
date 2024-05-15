pipeline {
    agent { label 'JDK-17'}

   
    triggers { pollSCM('* * * * *') }

environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub' // Replace with your credentials ID
        DOCKERHUB_REPO = 'dhillevajja/jenkins' // Replace with your Docker Hub repository
        IMAGE_TAG = "${env.BUILD_NUMBER}" // or use a specific tag like BUILD_NUMBER or COMMIT_SHA
        }
    
    stages{
        stage('git'){
            steps{
               git branch: 'prod', url: 'https://github.com/dhille98/spring-petclinic.git'
            }
        }
        stage('build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('test'){
            steps{
                junit stdioRetention: '', testResults: '**/**/*.xml'
                archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true
            }
        }
         stage('sonar-QUBE') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonar-cloud', installationName: 'sonar-cloud') { // You can override the credential to be used
                sh 'mvn clean package sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=dhille98 -Dsonar.projectKey=dhille98-spring-pet'}

            }
        }
        
        stage('Build') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh 'docker build -t $DOCKERHUB_REPO:$IMAGE_TAG .'
                }
            }
        }
    }
}
