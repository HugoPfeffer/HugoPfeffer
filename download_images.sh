#!/usr/bin/env bash
# download_images.sh - Download all specified images into the ./download directory
# Usage: bash download_images.sh

set -euo pipefail

DOWNLOAD_DIR="download"
mkdir -p "${DOWNLOAD_DIR}"

# Array of image URLs to download
urls=(
  "https://raw.githubusercontent.com/HugoPfeffer/HugoPfeffer/main/assets/banner-header.png"
  "https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg"
  "https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg"
  "https://raw.githubusercontent.com/devicons/devicon/master/icons/java/java-original.svg"
  "https://raw.githubusercontent.com/devicons/devicon/master/icons/c/c-original.svg"
  "https://raw.githubusercontent.com/devicons/devicon/master/icons/pandas/pandas-original.svg"
  "https://raw.githubusercontent.com/devicons/devicon/master/icons/numpy/numpy-original.svg"
  "https://upload.wikimedia.org/wikipedia/commons/0/05/Scikit_learn_logo_small.svg"
  "https://www.vectorlogo.zone/logos/tensorflow/tensorflow-icon.svg"
  "https://www.vectorlogo.zone/logos/pytorch/pytorch-icon.svg"
  "https://upload.wikimedia.org/wikipedia/commons/8/84/Matplotlib_icon.svg"
  "https://scipy.org/images/logo.svg"
  "https://raw.githubusercontent.com/containers/podman/main/logo/podman-logo.png"
  "https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg"
  "https://www.vectorlogo.zone/logos/kubernetes/kubernetes-icon.svg"
  "https://www.vectorlogo.zone/logos/openshift/openshift-icon.svg"
  "https://raw.githubusercontent.com/cncf/landscape/master/hosted_logos/tekton.svg"
  "https://argo-cd.readthedocs.io/en/stable/assets/logo.png"
  "https://avatars.githubusercontent.com/u/57720972?s=200&v=4"
  "https://raw.githubusercontent.com/cncf/landscape/master/hosted_logos/backstage.svg"
  "https://www.vectorlogo.zone/logos/jenkins/jenkins-icon.svg"
  "https://www.vectorlogo.zone/logos/gitlab/gitlab-icon.svg"
  "https://www.vectorlogo.zone/logos/ansible/ansible-icon.svg"
  "https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg"
  "https://www.vectorlogo.zone/logos/helmsh/helmsh-icon.svg"
  "https://www.vectorlogo.zone/logos/apache_kafka/apache_kafka-icon.svg"
  "https://www.vectorlogo.zone/logos/rabbitmq/rabbitmq-icon.svg"
  "https://www.vectorlogo.zone/logos/3scalenet/3scalenet-ar21.svg"
  "https://raw.githubusercontent.com/cncf/artwork/main/projects/keycloak/stacked/color/keycloak-stacked-color.svg"
  "https://raw.githubusercontent.com/devicons/devicon/master/icons/amazonwebservices/amazonwebservices-original-wordmark.svg"
  "https://www.vectorlogo.zone/logos/microsoft_azure/microsoft_azure-icon.svg"
  "https://www.vectorlogo.zone/logos/google_cloud/google_cloud-icon.svg"
  "https://www.vectorlogo.zone/logos/redhat/redhat-icon.svg"
  "https://www.vectorlogo.zone/logos/centos/centos-icon.svg"
  "https://www.vectorlogo.zone/logos/getfedora/getfedora-icon.svg"
  "https://www.vectorlogo.zone/logos/debian/debian-icon.svg"
)

failed=()

for url in "${urls[@]}"; do
  # Extract filename, stripping any query parameters
  filename=$(basename "${url%%\?*}")
  printf "Downloading %s ...\n" "$filename"

  # Attempt download; on failure, record the URL and continue
  if curl -Ls --fail "$url" -o "${DOWNLOAD_DIR}/$filename"; then
    printf "Saved to %s/%s\n---\n" "$DOWNLOAD_DIR" "$filename"
  else
    printf "Failed to download %s\n---\n" "$url"
    failed+=("$url")
  fi
done

# Summary report
if (( ${#failed[@]} )); then
  echo "\nDownload completed with failures. The following URLs could not be downloaded:" >&2
  for f in "${failed[@]}"; do
    echo "  $f" >&2
  done
  exit 1
else
  echo "\nAll downloads completed successfully."
fi
