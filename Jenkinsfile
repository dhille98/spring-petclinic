pipeline{
    agent any
    triggers {
        pollSCM('* * * * *')
        
    }
    parameters {
        file(name: 'settings.xml')
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

        stage(copyfile){
            steps{
                script {
                    // Access the uploaded file
                    sh 'cp $settings.xml /var/lib/jenkins/.m2/settings.xml'
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
