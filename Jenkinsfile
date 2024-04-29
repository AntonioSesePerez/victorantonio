pipeline {
    agent any 
    environment {
        GITHUB_CREDENTIALS_ID = 'victorAntonioCred'
    }
    stages {
        stage('Clean Workspace') {
            steps {
               cleanWs()
            }
        }
        
        stage('Init Pipeline'){
            steps {
                script{
                    sh 'echo "Pipeline Started !"'
                }
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
                    sh 'git config --global init.defaultBranch main'
                    sh 'git init'
                    sh 'git remote add origin https://github.com/AntonioSesePerez/victorantonio.git'
                    sh 'git pull https://github.com/AntonioSesePerez/victorantonio.git'
                    sh 'git add .'
                    sh 'git commit -m "Adding artifacts"'
                    sh 'git push origin main'
                }
            }
        }


        stage('Pull Artifacts') {
            steps{
                script {
            sh "git clone https://github.com/AntonioSesePerez/victorantonio.git" // Pon el repo completo
            dir('zip_directory') {
                sh 'unzip data_dir.zip > prueba.txt'
                     }
                }
            }
        }
    }     
}
