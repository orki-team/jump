# jump

## Kubernetes deployment example 

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jump  
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: jump
  template:
    metadata:
      labels:
        app.kubernetes.io/name: jump
    spec:
      containers:
        - name: jump
          image: willguitaradmfar/jump:latest
          ports:
            - name: ssh
              containerPort: 2222
              protocol: TCP
            - name: service
              containerPort: 3000
              protocol: TCP          
          imagePullPolicy: Always          
      restartPolicy: Always            
  
```

## Kubernetes service example 

```yaml
apiVersion: v1
kind: Service
metadata:
  name: jump  
spec:
  ports:
    - name: service
      protocol: TCP
      port: 80
      targetPort: service
  selector:
    app.kubernetes.io/name: jump
  type: ClusterIP

---


apiVersion: v1
kind: Service
metadata:
  name: jump-ssh
spec:
  ports:
    - name: ssh
      protocol: TCP
      port: 2222
      targetPort: ssh
  selector:
    app.kubernetes.io/name: jump
  type: ClusterIP
```

## Create a port-forward to the service

```bash
kubectl port-forward svc/jump-ssh 2222:2222 
```

## Create a jump
    
```bash
ssh dev@localhost -p 2222 -R 0.0.0.0:3000:localhost:<port-your-local-service>
# password: dev
```