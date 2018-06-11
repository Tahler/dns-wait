# dns-wait

Small Docker image to wait for a list of hosts to be ready before completing.

## Usage

This image is intended to be run as an [init
container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
in a Kubernetes deployment, forcing the deployments other containers to wait
for certain DNS hosts to be present before starting.
