#!/bin/bash

for pod in mongo comment post ui ;
 do
  kubectl apply -f  ../reddit/$pod-deployment.yml
 done

for pod in mongo comment post ui;
do
  kubectl apply -f  ../reddit/$pod-service.yml
done
