docker build -f ./client/Dockerfile ./client \
             -t mcrawford/multi-client:latest \
             -t mcrawford/multi-client:$SHA
docker build -f ./server/Dockerfile ./server \
             -t mcrawford/multi-server:latest \
             -t mcrawford/multi-server:$SHA 
docker build -f ./worker/Dockerfile ./worker \
             -t mcrawford/multi-worker:latest \
             -t mcrawford/multi-worker:$SHA
             
docker push mcrawford/multi-client:latest
docker push mcrawford/multi-client:$SHA

docker push mcrawford/multi-server:latest
docker push mcrawford/multi-server:$SHA

docker push mcrawford/multi-worker:latest
docker push mcrawford/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=mcrawford/multi-client:$SHA
kubectl set image deployments/server-deployment server=mcrawford/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mcrawford/multi-worker:$SHA
