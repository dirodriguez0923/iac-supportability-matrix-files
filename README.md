# iac-supportability-matrix-files
# Diego Rodriguez - Testing - Adding AWS Source
This repository will contain generic examples of the IaC resources for different IaC files supported by Sysdig.

The objective is to validate what the documentation states in the following link: https://docs.sysdig.com/en/docs/sysdig-secure/integrations-for-sysdig-secure/data-sources/git-integrations/iac-suppportability-matrix/

I will create different folders:

- Terraform AWS Provider to evaluate AWS Resources
- Some YAML Manifests to evaluate supported and unsupported K8s workloads.
- Kustomize folders -> K8s workloads -> Supported and Unsupported.
- Helm Charts -> K8s workloads -> Supported and Unsupported k8s workloads.
- Terraform Kubernetes Provider -> Supported and Unsupported k8s workloads.

The idea is to have clarity on how functional the default GIT zone is when evaluating the default CSPM Policies which includes:

- CIS Amazon Web Services Foundations Benchmark.
- CIS Google Cloud Platform Foundation Benchmark.
- CIS Kubernetes V1.18 Benchmark.
- CIS Microsoft Azure Foundations Benchmark.
- Sysdig Kubernetes.

For example, to me it doesn't make sense to include a CIS Google Cloud Platform Foundation Benchmark as we don't currently support for GCP resources according to the IaC Supportability Matrix information.
 
