docker build -t qanguyen/multi-client -t qanguyen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t qanguyen/multi-server -t qanguyen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t qanguyen/multi-worker -t qanguyen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push qanguyen/multi-client:latest
docker push qanguyen/multi-server:latest
docker push qanguyen/multi-worker:latest

docker push qanguyen/multi-client:$SHA
docker push qanguyen/multi-server:$SHA
docker push qanguyen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=qanguyen/multi-server:$SHA
kubectl set image deployments/client-deployment client=qanguyen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=qanguyen/multi-worker:$SHA