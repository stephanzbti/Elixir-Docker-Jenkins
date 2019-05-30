node("docker") {
    checkout scm

    def image
    stage('build') {
        echo "Starting Build"
        docker build -t stephanzbti/elixir-basic-api:latest .
        echo "Finishing Build"
    }
    stage('RepositoryImage') {
        echo "Starting Login Repository"
        docker login -u ${docker_login} -p ${docker_password}
        docker push stephanzbti/elixir-basic-api:latest
        docker tag stephanzbti/elixir-basic-api:latest stephanzbti/elixir-basic-api:${env.BUILD_NUMBER}
        docker push stephanzbti/elixir-basic-api:${env.BUILD_NUMBER}
        echo "Finishing Login Repository"
    }
}