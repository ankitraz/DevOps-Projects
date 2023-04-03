def Build(){
    sh "mvn package"
}

def Test(){
    echo "Testing the application..."
}

def Deploy(){
    sh "docker run -d -p 8080:8080 maven-app"
}

return this