/* stages {
        stage('Verificar Directorios') {
            steps {
                script {
                    def directoriosEncontrados = findDirectoriesInWorkspace()
                    if (directoriosEncontrados.size() > 0) {
                        echo "Se encontraron directorios en el workspace."
                    } else {
                        echo "No se encontraron directorios en el workspace. Saltando el stage."
                        currentBuild.result = 'ABORTED' // Opcional: marca la construcción como abortada
                        return // Salir del script
                    }
                }
            }
        }
        
        stage('Tu Otro Stage') {
            when {
                expression { findDirectoriesInWorkspace().size() > 0 }
            }
            steps {
                // Aquí coloca las acciones que deseas ejecutar si se encuentran directorios
            }
        }
    }
}

def findDirectoriesInWorkspace() {
    def directorios = []
    def workspaceDir = new File(env.WORKSPACE)
    workspaceDir.eachDir { directory ->
        directorios.add(directory.name)
    }
    return directorios
}

*/

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

        stage ('Clean GitHub'){
            steps{
                script{
                    sh 'git init'
                    sh 'git config --global init.defaultBranch main'
                    sh 'git pull https://github.com/AntonioSesePerez/victorantonio.git '
                    sh 'rm -r data_directory'
                    sh 'rm -r zip_directory'
                    sh 'git remote add origin https://github.com/AntonioSesePerez/victorantonio.git'
                    sh 'git branch --list'
                    sh 'git add .'
                    sh 'git commit -m "Borrar directorios anteriores"'
                    sh 'git push origin main'
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
                    sh 'git init'
                    sh 'git config --global init.defaultBranch main'
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
                sh 'git pull https://github.com/AntonioSesePerez/victorantonio.git'
                dir('zip_directory') {
                    sh 'unzip data_dir.zip'
                    sh 'git add .'
                    sh 'git commit -m "Adding artifacts"'
                    sh 'git push origin main'
                }
             }
        }
    }
 }     
}

