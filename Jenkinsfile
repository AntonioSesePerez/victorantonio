pipeline {
    agent any 

    environment {
        GITHUB_CREDENTIALS_ID = 'victorAntonioCred'
        WORKSPACE_DIR = "${WORKSPACE}/temp_workspace"
    }

    def cleanDirectory(directoryPaths) {
        directoryPaths.each { directory ->
            if (fileExists(directory)) {
                sh "rm -r ${directory}"
                echo "Directorio ${directory} borrado."
            } else {
                echo "El directorio ${directory} no existe, no se pudo borrar."
            }
        }
    }

    def fileExists(filePath) {
        return sh(script: "[ -d ${filePath} ]", returnStatus: true) == 0
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        
        stage('Init Pipeline') {
            steps {
                script {
                    echo "Pipeline Started !"
                }
            }
        }

        stage('Clone Repository') {
            steps {
                script {
                    sh "rm -rf ${WORKSPACE_DIR}"
                    sh "git clone https://github.com/AntonioSesePerez/victorantonio.git ${WORKSPACE_DIR}"
                }
            }
        }

        stage('Clean Repository') {
            steps {
                script {
                    cleanDirectory([WORKSPACE_DIR])
                }
            }
        }

        stage('Login GitHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: GITHUB_CREDENTIALS_ID, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "git config --global credential.helper 'store --file=${HOME}/.git-credentials'"
                        sh "echo 'https://${env.USERNAME}:${env.PASSWORD}@github.com' > ${HOME}/.git-credentials"
                    }
                }
            }
        }

        stage('Generating .zip') {
            steps {
                script {
                    sh "mkdir -p ${WORKSPACE_DIR}/data_directory"
                    sh "echo test_data > ${WORKSPACE_DIR}/data_directory/data.txt"
                    zip dir: "${WORKSPACE_DIR}/data_directory", exclude: '', glob: '', zipFile: "${WORKSPACE_DIR}/zip_directory/data_dir.zip"
                }
            }
        }

        stage('Push Artifacts') {
            steps {
                script {
                    dir(WORKSPACE_DIR) {
                        sh 'git add .'
                        sh 'git commit -m "Adding artifacts"'
                        sh 'git push origin dev'
                    }
                }
            }
        }

        stage('Pull Artifacts') {
            steps {
                script {
                    dir("${WORKSPACE_DIR}/zip_directory") {
                        sh 'unzip -o data_dir.zip'
                        sh 'git add .'
                        sh 'git commit -m "Adding artifacts"'
                        sh 'git push origin dev'
                    }
                }
            }
        }
    }
}
