#!/bin/bash
rm -Rf /home/k8suser/.kube/
mkdir -p /home/k8suser/.kube/
cp -i /etc/kubernetes/admin.conf /home/k8suser/.kube/config
sudo chown k8suser:k8suser /home/k8suser/.kube/config
