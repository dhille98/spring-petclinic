pipeline{
    agent any
    triggers {
        pollSCM('* * * * *') // Polls every 15 minutes
    }

    environment {
        MAVEN_SETTINGS_CRED_ID = 'maven-settings-file'  // Replace with your credential ID
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

        stage('Copy settings.xml') {
            steps {
                withCredentials([file(credentialsId: "${MAVEN_SETTINGS_CRED_ID}", variable: 'SETTINGS_FILE')]) {
                    // Copy to .m2 directory on the node
                    sh 'mkdir -p ~/.m2'
                    sh 'cp $SETTINGS_FILE ~/.m2/settings.xml'
                }
            }
        }
        // stage(deploythe-artifacts-jforg){
        //     steps{
        //         sh 'mvn clean deploy -Dskiptest'
        //         }
        //     }
    }
        
 }

