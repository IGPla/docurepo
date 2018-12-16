# Kubernetes - minikube

Kubernetes is an orchestraction software to scale your app environment through a containerization process (mainly used with docker).

## Deployment

minikube is a development version for kubernetes. It's really useful to deploy a local kubernetes single-node cluster and test your environment.

https://github.com/kubernetes/minikube

## Concepts

- Master: master node, centralized control
- Node: worker machine. Where pods run
- Pod: abstraction that represents a group of one or more application containers and some shared resources (storage, networking...). Pods are atomic in kubernetes
- Kubelet: a process (in the node) responsible for communcation between Master and the Node . It manages the pods and the containers running on a machine
- Deployment configuration: instructs kubernetes how to create/update instances of your application
- Deployment controller (replication controller): continuously monitors application instances. Replaces down instances (on down nodes) with new ones in other nodes (self-healing mechanism)
- Isolation: by default, deployments are isolated in their own private networks, visible only from other pods and services within kubernetes cluster.
- Service: abstraction that defines a logical set of Pods and a policy by which to access them. It enables pods to die, reschedule and recreate them, seamlessly for the client that access to that pods (basically, it gives a public address to the pod/s and, optionally, high availability on pods of the same type). It have different types:
  - ClusterIP(default): exposes the service on an internal ip in the cluster
  - NodePort: exposes the service on the same port of each selected node in the cluster using NAT. Makes a service accessible from outside (NODEIP:NODEPORT)
  - LoadBalancer: Creates an external load balancer in the current cloud and assigns a fixed, external ip to the service.
  - ExternalName: Exposes the service using an aribitrary name 
- Labels: key/value pairs attached to objects, used to designate objects (example: app=MyApp)
- Selectors: select labels to use in another definition (example: s:app=MyApp)
- Scaling: just change the number of replicas in a deployment
- Rolling update: allow deployments update to take place with zero downtime by incrementally updating pods instances with new ones

## Components

- Master
  - kube-apiserver
  - etcd
  - kube-scheduler
  - kube-controller-manager
  - cloud-controller-manager
- Node
  - kubelet
  - kube-proxy
  - runtime (docker usually)
  
## Workflow

- Create cluster
- Create deployment configuration into master
- Master schedules app instances onto invidiual nodes in the cluster


## Useful commands

- minikube 
  - version
  - start: starts minikube
  - ip: get minikube ip
- kubectl <cmd>: interact with kube-apiserver to send commands to the master node
  - version: print kubectl version
  - describe: show detailed information about a resource
    - pods: give detailed information about every pod
  - logs: print the logs from a container in a pod 
  - exec: execute a command on a container in a pod
  - cluster-info: view cluster details
  - get: obtain information about a kubernetes part
    - nodes: View the nodes in the cluster
    - deployments: View the deployments status
    - pods: View pods information
    - services: View services information
  - run: Create a deployment. Usually, it creates one or more pods (--expose create a service)
  - proxy: connect between localhost and kubernetes cluster, and adds a local endpoint to view it.
  - expose: expose a given pod/s outside the cluster (creates a service)
  - label: label a given resource
  - delete: remove a resource
  - scale: scale a deployment
  
  
```
# Start a minikube cluster and check what happened
minikube start
kubectl cluster-info
kubectl get nodes
```

To update an image on a given deployment:
```
kubectl set image deployments/my-deployment my-deployment=<REGISTRY DOCKERIMAGE : TAG>
```

Confirme an update
```
kubectl rollout status deployments/my-deployment
```

Undo the update (rollback)
```
kubectl rollout undo deployments/my-deployment
```

### Command examples

Get pod name. Useful to store them into an env var
```
kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'
```

Get port number for a given service
```
kubectl get <SERVICE_NAME> -o go-template='{{(index .spec.ports 0).nodePort}}
```

Exec a bash shell in a given pod
```
kubectl exec -it <POD_NAME> bash
```

Expose a given deployment, type NodePort, on port 8080
```
kubectl expose <DEPLOYMENT_NAME> --type="NodePort" --port 8080
```

Label a pod
```
kubectl label pod <POD NAME> key=val
```

Scale a deployment
```
kubectl scale <DEPLOYMENT NAME> --replicas=5
```

### Full examples

```
# Start minikube
minikube start
kubectl cluster-info
kubectl get nodes

# Create a deployment
kubectl run kubernetes-test --image=<REGISTRY / IMAGE NAME : TAG> --port=8080

# Add a new service for that deployment
kubectl expose deployment/kubernetes-test --type="NodePort" --port 8080

# List all pods
kubectl get pods

# Run a ls command in a pod
kubectl exec <POD NAME FROM LAST COMMAND> ls -ltrh

# Query pods by label
kubectl get pods -l run=kubernetes-test

# Query services by label
kubectl get services -l run=kubernetes-test

# Label a given pod
kubectl label pod <POD NAME> app=v1

# Delete previously created service (this time, by label instead of name)
kubectl delete service -l run=kubernetes-test

# Scale out
kubectl scale deployments/kubernetes-test --replicas=5
```
## Notes

- Output of kubectl get deployments shows several columns
  - Desired: configured number of replicas
  - Current: replicas running
  - Up to date: number of replicas updated to match the desired state
  - Available: replicas available to user
