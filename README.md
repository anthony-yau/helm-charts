# helm-charts

## hdfs-ha
```
helm install hdfs-ha ./
```

### Get Cluster Status
```
kubectl exec -it -n {{ .Release.Namespace }} \
    `kubectl get pod -n {{ .Release.Namespace }} \
    -l app.kubernetes.io/component=namenode -o custom-columns=CONTAINER:.metadata.name|tail -n1` \
    -c namenode -- hdfs dfsadmin -report
```