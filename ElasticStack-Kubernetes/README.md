# Deploy Elastic Stack on Kubernetes Cluster
  
This guide will helps you deploy Elastic Stack 7.1 on each Kubernetes cluster: eks, gke, rancher and kops.

Here is an image of the architecture of the elastic stack:
![ElasticStack](https://github.com/OryanOmer/ElasticStack/blob/master/ElasticStack-Kubernetes/Elastic-Stack-Kubernetes.png)

### Quick brief about the architecture:
* Master Nodes - responsible for managing the cluster state and health.
* Data Nodes- responsible keeps the data and perform data related operations such as CRUD, search, and aggregations.
* Client Nodes- Also called “coordinating node”, responsible for client requests and query data from the cluster.
* Kibana -Kibana lets you visualize your Elasticsearch data and navigate the Elastic Stack.

  One of the main changes at this relase is security, at this version you have the option to manage users rbac in diffrent spaces.
  After you will bring up your Elastic stack environment and connect to the kibana, you have to provide username and password to login to the kibana, for make things easy the default username and password is elastic:password.

### Prerequisites:
 * Kuberntes up and running, supported at 1.13+.

 * Clone the repository to your server.
  ``` bash
    git clone https://github.com/OryanOmer/ElasticStack.git && cd ./ElasticStack/ElasticStack-Kubernetes
  ```


### Instructions:
* First, we will deploy isolated namespace for our Elastic     Stack using the command:
    ``` bash
    kubectl apply -f es-namespace/namespace.yaml
    ```

* Second, we will deploy configMap for our Elastic Stack       environment (If you want to change params for the elastic,   for example, JVM OPS, Elastic data-path..etc) you can do     that there, but be careful and keep on alignment cross the   nodes.

  After finishing edit the configMap.yaml, deploy the        configMap by the command:

    ``` bash
    kubectl apply -f es-configs/es-configMap.yaml
    ```

* Third, now we will deploy the elastic master containers by   the command:
    ``` bash
    kubectl apply -f es-master/es-master.yaml
    ```
  the master containers are statefulSet with headless-service.

* Four,we will deploy the elastic data containers, There are 2 options for deploy data nodes:
  1. data nodes without pvc.
  2. data nodes with pvc.

  For option one press the command:   
   ``` bash
    kubectl apply -f es-data/es-data.yaml
    ```
  
  For option 2, you should edit the ./es-data/es-data-pvs.yaml file and change < StorageClass > to your StorageClass.
  After that press the command:
  ``` bash
     kubectl apply -f es-data/es-data-pvs.yaml
  ```
  In addition, i added an example of *Storage Class* yaml for your convenience

  the data containers are statefulSet with headless-service.

* Five, we will deploy the elastic proxy containers(coordinating node) to         listen for client requests by the command:
   ``` bash
    kubectl apply -f es-client/es-client.yaml
    kubectl apply -f es-client/es-client-service.yaml
    ```
  the proxy containers are done by replicaSet of 3 containers with NodePort service for client access.

* Also, there is an option to deploy HPA(Horizontal Pod      AutoScaler) for the clients nodes, the default metric is   for CPU Utilization over  80%.
  For deploy HPA on elastic client nodes press the command:
  ``` bash
    kubectl apply -f es-client/es-client-hpo.yaml
  ```

* At the end, we will deploy the kibana to access the elastic cluster via UI.
  You can edit the kibana.yaml in the kibana-configMap.yaml as you want.
  ``` bash
    kubectl apply -f kibana/kibana-configMap.yaml
    kubectl apply -f kibana/kibana.yaml
    kubectl apply -f kibana/kibana-service.yaml
    kubectl apply -f kibana/kibana-ingress.yaml
  ```
  The kibana containers are done by replicaSet of 3 containers with NodePort Service.

  

### Purge the cluster by the command:
  ``` bash
    kubectl delete -f kibana/kibana-service.yaml
    kubectl delete -f kibana/kibana.yaml
    kubectl delete -f kibana/kibana-configMap.yaml
    kubectl delete -f es-client/es-client-service.yaml
    kubectl delete -f es-client/es-client.yaml
    kubectl delete -f es-data/es-data.yaml
    kubectl delete -f es-master/es-master.yaml
    kubectl delete -f es-configs/es-configMap.yaml
    kubectl delete -f es-namespace/namespace.yaml
  ``` 

![E&K](https://anchormen.nl/wp-content/uploads/2017/12/elasticsearch-on-kubernetes.jpg)


