pipeline {
    agent { label 'JDK-17'}

   
        triggers { pollSCM('* * * * *') }
    
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
    }
}