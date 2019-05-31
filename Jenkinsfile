node("docker") {
    checkout scm

    stage('build') {
        echo "Starting Build"
        sh 'sudo docker build -t elixir-basic-api:latest .'
        echo "Finishing Build"
    }
    stage('RepositoryImage') {
        echo "Starting Login Repository"
        sh 'sudo docker login -u ${docker_login} -p ${docker_password}'
        sh 'sudo docker tag elixir-basic-api:latest stephanzbti/elixir-basic-api:latest'
        sh 'sudo docker push stephanzbti/elixir-basic-api:latest'
        sh 'sudo docker tag stephanzbti/elixir-basic-api:latest stephanzbti/elixir-basic-api:${env.BUILD_NUMBER}'
        sh 'sudo docker push stephanzbti/elixir-basic-api:${env.BUILD_NUMBER}'
        echo "Finishing Login Repository"
    }
}