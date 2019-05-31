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
        echo "Starting Login Repository"
        echo "Finishing Login Repository"
    }
    stage('Deployment'){
        echo "Staging Kubernetes Deployment"
        sh 'kubectl --kubeconfig $(pwd)/.kube/config'
        sh 'kubectl run ${name_project} --image ${repository_name}/${name_project}:${BUILD_NUMBER}-${environment} --port 80'
        sh 'KUBECONFIG=${KUBECONFIG_SAVED}'
        echo "Finishing Kubernetes Deployment"
    }
    stage('Clean') {
        echo "Starting Automatic Test"
        
        echo "Finishing Automatic Test"
    }
}