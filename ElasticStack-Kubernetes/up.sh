kubectl apply -f es-namespace/namespace.yaml
sleep 3
kubectl apply -f es-configs/es-configMap.yaml
sleep 3
kubectl apply -f es-master/es-master.yaml
sleep 3
kubectl apply -f es-data/es-data.yaml
sleep 3
kubectl apply -f es-client/es-client.yaml
kubectl apply -f es-client/es-client-service.yaml
sleep 3
kubectl apply -f kibana/kibana-configMap.yaml
kubectl apply -f kibana/kibana.yaml
kubectl apply -f kibana/kibana-service.yaml
