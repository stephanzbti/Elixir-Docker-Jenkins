node("docker") {
    checkout scm

    stage('build') {
        echo "Starting Build"
        sh 'docker build -t elixir-basic-api:latest .'
        echo "Finishing Build"
    }
    stage('RepositoryImage') {
        echo "Starting Login Repository"
        sh 'docker login -u ${docker_login} -p ${docker_password}'
        sh 'docker tag elixir-basic-api:latest stephanzbti/elixir-basic-api:latest'
        sh 'docker push stephanzbti/elixir-basic-api:latest'
        sh 'docker tag stephanzbti/elixir-basic-api:latest stephanzbti/elixir-basic-api:${env.BUILD_NUMBER}'
        sh 'docker push stephanzbti/elixir-basic-api:${env.BUILD_NUMBER}'
        echo "Finishing Login Repository"
    }
}