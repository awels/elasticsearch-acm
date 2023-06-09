#!/usr/bin/env bash
set -e

if [ "$1" = "primary" ]; then
  oc apply -f proxy_primary.yaml
elif [ "$1" = "secondary" ]; then
  oc apply -f proxy_secondary.yaml
else
  echo "invalid argument, use primary or secondary"
  exit 1
fi

pods=$(oc get pods -n elasticsearch-demo-app --no-headers=true | cut -d' ' -f 1)
for pod in $pods; do
  echo "deleting pod $pod"
  oc delete pod -n elasticsearch-demo-app $pod
done

