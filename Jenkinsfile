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
                withSonarQubeEnv(credentialsId: 'sonar_id', installationName: 'sonar_cloud') { // You can override the credential to be used
                sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.6.0.1398::sonar -D sonar.organization=dhill98 -D sonar.projectKey=0e96ed61aeff30d6c7e31d950a0c1c851cbf8e53'}

            }
        }

    }
}
