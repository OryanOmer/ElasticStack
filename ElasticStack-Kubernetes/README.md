# Deploy Elasic Stack on Kubernetes Cluster

# Inststruction:
* First, we will deploy isolated namespace for our Elastic     Stack using the command:
    ``` bash
    kubectl apply -f es-namespace\namespace.yaml
    ```

* Second, we wiil deploy configMap for our Elastic Stack       environment(If you want to change params for the elastic,    for example: JVM OPS,elastic data path..etc) you can do      that there, but be careful and keep on alliigemnt cross al   the nodes.

  After finishing edit the configMap.yaml, deploy the        configMap by the command:

    ``` bash
    kubectl apply -f es-configs\es-configMap.yaml
    ```

* Third, now we wiil deploy the elastic master containers by   the command:
    ``` bash
    kubectl apply -f es-master\es-master.yaml
    ```
  the master containers are statefulSet with headless-service.

* Four, we wiil deploy the elastic data containers by the      command:
   ``` bash
    kubectl apply -f es-data\es-data.yaml
    ```
  the data containers are statefulSet with headless-service.

* Five, we wiil deploy the elastic proxy containers to         listen for client requests by the command:
   ``` bash
    kubectl apply -f es-client\es-client.yaml
    ```
  the proxy conatiners is done by replicaSet of 3 containers.
