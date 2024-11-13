kubernetes commands
- kubectl create
- kubectl create -f 
- kubectl get pods 
- kubectl get pods -o wide 
- kubectl describe <object-name>
- kubectl delete pod <pod-name>

kubectl api-resources | grep replicaset #check for apiVersion of replicaset
kubectl explain replicaset | grep VERSION and correct the apiVersion for ReplicaSet.


add the | 4 components of a yaml | and create a table with the objects (Pod, Replicaset,etc) and their versions and potentially spec components (since metadata may be same). insert it in markdown as a table 

| Version  | Kind               | Spec component1 |Spec component2 |
|----------|--------------------|-----------------|----------------|
| v1       | Pods               | Spec component1 |Spec component2 |
| v1       | Replicacontroller  | Spec component1 |Spec component2 |
| apps/v1  | Replicaset         | Spec component1 |Spec component2 |   


kubectl run redis --image=redis123 --dry-run=client -o yaml > redis-definition.yml

kubectl run redis: This command uses kubectl (the Kubernetes command-line tool) to create a new resource, in this case, a "Pod" named redis.

--image=redis123: Specifies the Docker image (redis123) to use for the Pod. This means that Kubernetes will pull this image to create the container for the redis Pod.

--dry-run=client: This flag means "don't actually create the resource," just generate the configuration. The client option specifies that the command should be processed on the client side only, not sent to the server.

-o yaml: This flag tells kubectl to output the configuration in YAML format.

> redis-definition.yml: This part saves the generated YAML configuration to a file named redis-definition.yml.

kubectl apply

kubectl delete
kubectl edit 
kubectl scale