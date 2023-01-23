# K8s
In this project I deployed a Kubernetes cluster with kubeadm and Third VM for Jenkins CI/CD Server.  
The Cluster contain 2 Nodes
  1. Master  - 192.168.56.104
  2. Worker1 - 192.168.56.105

Jenkins Pipeline:
 include 3 stages
  1. Build-   Build with docker the image of my web application.
  2. Push-    Push the built image to my Docker Hub Repository.
  3. Deploy-  Run the deploy.sh script.
  
Deploy.sh:
 include 3 functions
  1. docker_run- Make ssh connection to Master node and run the web-app container.
  2. copy_to_remote_machine- Make scp connection to Master node and send the Helm-yossi-ingress folder.
  3. run_helm_yossi_ingress- First uninstall and delete older helm and namespace that I gonna use.
                             Second install and create helm and namespace "mission".

Check for deployment of namespace and ruuning pods:
master@master:~$ kubectl get all -n mission
NAME                                READY   STATUS    RESTARTS   AGE
pod/web-deployment-bfcfdfdd-prflv   1/1     Running   0          125m
pod/web-deployment-bfcfdfdd-s9h2q   1/1     Running   0          125m

NAME                         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/my-web-app-service   LoadBalancer   10.99.29.231   <pending>     80:30010/TCP   125m

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/web-deployment   2/2     2            2           125m

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/web-deployment-bfcfdfdd   2         2         2       125m


For display the website enter in the browser htttp:// then the Worker1 IP & the Load Balancer PORT 30010  
http://192.168.56.105:30010
![image](https://user-images.githubusercontent.com/82327346/214042227-3816fa33-f6cf-43fc-8b36-b261312549e6.png)

