pipeline {
    agent any 
    enviroment {
        GITHUB_CREDENTIALS_ID = ''
    }
    stages {
        stage('Init Pipeline'){
            steps {
                sh echo 'Pipeline Started !'
            }
        }

        stage('Login GitHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: GITHUB_CREDENTIALS_ID, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                        sh 'git config --global credential.helper "store --file=$HOME/.git-credentials"'
                        sh "echo 'https://${env.USERNAME}:${env.PASSWORD}@github.com' > $HOME/.git-credentials"
                    }
                }
            }
        }
        stage('Generating .zip') {
            steps {
                script {
                    sh 'mkdir data_directory'
                    sh 'echo test_data > data_directory/data.txt'
                    zip dir: 'data_directory', exclude: '', glob: '', zipFile: 'zip_directory/data_dir.zip'
                }
            }
        }

        stage('Push Artifacts') {
            steps {
                script {
                    sh 'git add .'
                    sh 'git commit -m "Adding artifacts"'
                    sh 'git push origin master'
                }
            }
        }

        stage('Clean Workspace') {
            steps {
                //Crear funcion
            }
        }

        stage('Pull Artifacts') {
            steps{
                script {
            sh "git clone https://github.com/AntonioSesePerez/victorantonio.git" // Pon el repo completo
            cd('directorio_del_repo') {
                sh 'unzip data_dir.zip'
                     }
                }
            }
        }
    }     
}
