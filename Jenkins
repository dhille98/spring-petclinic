pipeline{
    agent any
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
    }
}
