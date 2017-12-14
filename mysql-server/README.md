# Simple example to run and use mysql-server containers with Nomad

Running the example requires make, wget, and unzip, as well as a working docker
installation on your machine.


To download binaries:
```
make
```

Start consul:
```
consul agent -server -client 127.0.0.1 -advertise 127.0.0.1 -data-dir /tmp/consul -ui -bootstrap
```

Start nomad:
```
nomad agent -config nomad.conf
```

Run jobs:
```
make run_jobs

```

This example is explained in detail on the [MySQL Release Engineering
Blog](https://mysqlrelease.com/)
