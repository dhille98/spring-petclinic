pipeline{
    agent any
    triggers {
        pollSCM('* * * * *') // Polls every 15 minutes
    }
    tools {
		jfrog 'jfrog-cli'
	}

    environment {
        MAVEN_SETTINGS_CRED_ID = 'maven-settings-file'  // Replace with your credential ID
        DOCKER_IMAGE_NAME = "dhilli.jfrog.io/spc-jenkins-docker/spc:${env.BUILD_ID}"
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
                    sh 'cp $SETTINGS_FILE ~/.m2/settings.xml || exit 0'
                }
            }
        }
        stage('deploythe-artifacts-jforg'){
            steps{
                sh 'mvn clean deploy -Dskiptest'
            }
        }
        stage('dockerimagebuild'){
            steps{
                sh 'docker image build -t $DOCKER_IMAGE_NAME .'
            }
        }
        stage('scanandpush'){
            steps{
               // scan the docker image
                // jf 'docker scan $DOCKER_IMAGE_NAME'
                // push the docker image
                jf 'docker push $DOCKER_IMAGE_NAME'
            }
        }
        stage('Publish build info') {
			steps {
				jf 'rt build-publish'
			}
		}
        stage(trivyscan){
            steps {
                        sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'
                        sh 'mkdir -p reports && rm -rf reports/dev_trivy_report.html' 
                        sh """sudo trivy image $DOCKER_IMAGE_NAME --security-checks vuln --exit-code 0 --severity CRITICAL --timeout 15m --format template --template \"@html.tpl\" --output reports/dev_trivy_report.html  """
                        //sh 'aws s3 cp reports/dev_trivy_report.html s3://sreeterraformbucket/dev_trivy_report.html'
                    }
        }
    }
        
 }

