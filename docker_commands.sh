cd backend/

## build the image
docker build -t backend:1.0 .
docker build -t frontend:1.0 .
docker build -t mysql:1.0 .


## image with the tags to push the docker hub 
docker build -t joindevops/mysql:v1.0 ./mysql
docker build -t joindevops/backend:v1.0 ./backend
docker build -t joindevops/frontend:v1.0 ./frontend


## run the container
docker run -d --name frontend -p 80:80 --network expense frontend:1.0




docker network create expense
docker volume create mysql
docker run -d --name mysql --network expense -v mysql:/var/lib/mysql joindevops/mysql:v1.0
docker run -d --name backend --network expense --depends-on mysql joindevops/backend:v1.0 sh -c "sleep 20 && node /opt/server/index.js"
docker run -d --name frontend --network expense --depends-on backend -p 80:80 joindevops/frontend:v1.0