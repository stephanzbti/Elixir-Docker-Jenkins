node("docker") {
    checkout scm

    stage('build') {
        echo "Starting Build"
        sh 'sudo docker build -t ${name_project}:latest-${environment} .'
        echo "Finishing Build"
    }
    stage('RepositoryImage') {
        echo "Starting Login Repository"
        sh 'sudo docker login -u ${docker_login} -p ${docker_password}'
        sh 'sudo docker tag ${name_project}:latest ${repository_name}/${name_project}:latest-${environment}'
        sh 'sudo docker push ${repository_name}/${name_project}:latest-${environment}'
        sh 'sudo docker tag ${repository_name}/${name_project}:latest-${environment} ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment}'
        sh 'sudo docker push ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment}'
        sh 'sudo docker rmi -f ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment}'
        echo "Finishing Login Repository"
    }
}