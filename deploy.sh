docker build -t biplabsamu/multi-client:letest -t biplabsamu/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t biplabsamu/multi-server:letest -t biplabsamu/multi-server:$SHA -f  ./server/Dockerfile ./server
docker build -t biplabsamu/multi-worker:letest -t biplabsamu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push biplabsamu/multi-client:letest
docker push biplabsamu/multi-server:letest
docker push biplabsamu/multi-worker:letest

docker push biplabsamu/multi-client:$SHA
docker push biplabsamu/multi-server:$SHA
docker push biplabsamu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=biplabsamu/multi-server:$SHA
kubectl set image deployment/client-deployment client=biplabsamu/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=biplabsamu/multi-worker:$SHA