docker build -t mcrawford/multi-client:latest -t mcrawford/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mcrawford/multi-server:latest -t mcrawford/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mcrawford/multi-worker:latest -t mcrawford/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mcrawford/multi-client:latest
docker push mcrawford/multi-server:latest
docker push mcrawford/multi-worker:latest

docker push mcrawford/multi-client:$SHA
docker push mcrawford/multi-server:$SHA
docker push mcrawford/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mcrawford/multi-server:$SHA
kubectl set image deployments/client-deployment client=mcrawford/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mcrawford/multi-worker:$SHA
