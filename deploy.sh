docker build -t haassie/multi-client:latest -t haassie/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t haassie/multi-server:latest -t haassie/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t haassie/multi-worker:latest -t haassie/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push haassie/multi-client:latest
docker push haassie/multi-server:latest
docker push haassie/multi-worker:latest

docker push haassie/multi-client:$SHA
docker push haassie/multi-server:$SHA
docker push haassie/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=haassie/multi-server:$SHA
kubectl set image deployments/client-deployment server=haassie/multi-client:$SHA
kubectl set image deployments/worker-deployment server=haassie/multi-worker:$SHA