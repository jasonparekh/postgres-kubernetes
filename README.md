Postgres on Kubernetes
======================

Extends the original postgres docker image to read the credentials from /etc/postgres-credentials.

Image Name: msiegenthaler/postgres-kubernetes@9.5



Usage
=====

## Replication controller

    kind: ReplicationController
    apiVersion: v1
    metadata:
      name: postgres-master
    spec:
      replicas: 1  #only one is allowed
      template: 
        metadata:
          labels:
            name: postgres
            role: master
        spec:
          containers:
            - name: postgres
              image: msiegenthaler/postgres-kubernetes@9.5
              ports:
                - name: transport
                  containerPort: 5432
              volumeMounts:
                - name: data-storage
                  mountPath: /var/lib/postgresql/data
                - name: credentials
                  mountPath: /etc/postgres-credentials
              env:
                - name: PGDATA
                  value: /var/lib/postgresql/data/pgdata
          volumes:
            - name: data-storage
              persistentVolumeClaim: #Or whatever suits you best
                claimName: postgres-master-storage
            - name: credentials
              secret:
                secretName: postgres-credentials

## Secret

    apiVersion: v1
    kind: Secret
    metadata:
      name: postgres-credentials
    data:
      #User: postgres, Password: ...
      user: cG9zdGdyZXMK
      password: <base64 encoded secret>
