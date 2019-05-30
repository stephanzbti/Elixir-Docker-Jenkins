node("docker") {
    checkout scm

    def image
    stage('build') {
        echo "Starting Build"
        image = docker.build("stephanzbti/elixir-basic-api")
        echo "Finishing Build"
    }
    stage('RepositoryImage') {
        echo "Starting Login Repository"
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            echo "Starting Push Image"
            image.push("${env.BUILD_NUMBER}")
            image.push("latest")
            echo "Finishing Push Image"
        }
        echo "Finishing Login Repository"
    }
}