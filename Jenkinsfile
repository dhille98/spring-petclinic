pipeline{
    agent { label 'JDK-17'}
    triggers {
        pollSCM('* * * * *')
        
    }
    
    
    stages{
        stage( 'git' ) {
            steps{
                git url :' https://github.com/dhille98/spring-petclinic.git ',
                  branch: 'pod'
            }
        }
         stage('build') {
             steps {
                 sh "mvn clean package"
                 archiveArtifacts artifacts: '**/spring-petclinic-*.jar'
                 junit testResults: '**/TEST-*.xml'
             }  
         }
        stage('sonar-QUBE') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonar-id', installationName: 'sonar_cloud') { // You can override the credential to be used
                sh 'mvn clean package sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=dhille1998 -Dsonar.projectKey=dhille1998-spring-pet'}

            }
        }

    }
}
