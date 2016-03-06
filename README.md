Docker Swarm XKE
=================

# Hands'on

<a href="http://xebia-france.github.io/docker-swarm/">Hands'on walkthrough !</a>

# Preparation

We need a discovery backend on the cluster, we'll deploy it on
the manager node, which will not be in the Swarm cluster.

There's a dedicated infrastructure node in the TF state, connect on it
and run the following :

```bash
docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap
```
