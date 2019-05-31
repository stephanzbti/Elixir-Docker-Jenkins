node("docker") {
    checkout scm

    stage('Build') {
        echo "Starting Build"
        sh 'sudo docker build -t ${name_project}:latest-${environment} .'
        sh 'sudo docker login -u ${docker_login} -p ${docker_password}'
        sh 'sudo docker tag ${name_project}:latest-${environment} ${repository_name}/${name_project}:latest-${environment}'
        sh 'sudo docker push ${repository_name}/${name_project}:latest-${environment}'
        sh 'sudo docker tag ${repository_name}/${name_project}:latest-${environment} ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment}'
        sh 'sudo docker push ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment}'
        echo "Finishing Build"
    }
    stage('Teste') {
        echo "Starting Automatic Test"
        sh 'sudo docker run ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment} -e "MIX_ENV=test" mix test'
        echo "Finishing Automatic Test"
    }
    stage('Deployment'){
        echo "Staging Kubernetes Deployment"
        sh 'cp -R ./.kube/ ~/.kube/'
        sh 'kubectl --record deployment.apps/${name_project} set image deployment.v1.apps/${name_project} ${name_project}=${repository_name}/${name_project}:${BUILD_NUMBER}-${environment} '
        echo "Finishing Kubernetes Deployment"
    }
    stage('Clean') {
        echo "Starting Cleaning"
        sh 'docker rmi -f ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment}'
        echo "Finishing Cleaning"
    }
}