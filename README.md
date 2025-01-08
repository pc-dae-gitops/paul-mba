# Template for deploying K8s Cluster

This repository contains the template for deploying a K8s cluster on a MacBook or Linux workstation. Use this repository template to create a new repository and follow the instructions below to deploy a K8s cluster.

On a MacBook it is designed to use the Docker Kubernetes deployed from Docker Dashboard but can be used with any Kubernetes cluster. On Linux it will create a Kind cluster.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (required for local cluster)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (required by various scripts)
- [Flux](https://fluxcd.io/docs/installation/) (required by various scripts)
- [vault cli](https://www.vaultproject.io/docs/install) (required by various scripts)
- [jq](https://stedolan.github.io/jq/download/) (required by various scripts)
- [yq](https://mikefarah.gitbook.io/yq/) (required by various scripts)
- [openssl](https://www.openssl.org/source/) (required to generate cluster certificate)

## Optional

- [gitops](https://docs.gitops.weave.works/docs/next/installation/weave-gitops/#install-the-gitops-cli) (optional only required for GitOps CLI deployments)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/) (optional, only for Linux and local Kind deployments)
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (optional, only for AWS deployments)
- [custerctl](https://cluster-api-aws.sigs.k8s.io/getting-started.html#install-clusterctl) (optional, only for Cluster API deployments)
- [clusterawsadm](https://cluster-api-aws.sigs.k8s.io/getting-started.html#install-clusterawsadm) (optional, only for Cluster API  AWS deployments)
- [terraform](https://www.terraform.io/downloads.html) (optional, only for AWS deployments)
- [direnv](https://direnv.net/docs/installation.html) (optional)
- [multipass](https://multipass.run/) (optional, only for multipass deployments)
- htpasswd - required for generating prometheus password, optional.

## Setup

Once you have created your own repository using this template, you will need to update the `.envrc` file with the correct values for your environment.

If you are using a MacBook start or reset the Kubernetes cluster using the Docker Dashboard. If you are using Linux the `setup.sh` script will create a Kind cluster.

Copy the `resources/github-secrets.sh.sample` file to `resources/github-secrets.sh` and update the values for your GitHub organization.

## Deploy

Once Flux has deployed the cluster

## Destroy

To destroy the cluster run the `reset.sh` script. This will destroy the K8s cluster.
