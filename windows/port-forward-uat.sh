@echo off

:: Define the label selectors for each service
set recipe_selector=app=recipe-service-v2
set ims_internal_selector=app=ims-internal-api
set ims_inventory_order_selector=app=ims-inventory-order-service
set restaurant_selector=app=restaurant-service-v2
set cis_selector=app=hdr-inventory-service
set kos_selector=app=kitchen-order-service
set kms_selector=app=kitchen-management-service

:: Define the namespace and port numbers for each service
set recipe_namespace=uat-master-data
set recipe_port=8092
set ims_internal_namespace=uat-ship
set ims_internal_port=8094
set ims_inventory_order_namespace=uat-ship
set ims_inventory_order_port=8099
set restaurant_namespace=uat-consumer
set restaurant_port=8093
set cis_namespace=uat-inventory
set cis_port=8088

set kos_namespace=uat-hdr
set kos_port=8090
set kms_namespace=uat-hdr
set kms_port=8091

:: Use kubectl context
kubectl config use-context FTIUatAKSClusterV2

:: Port forward the pods for each service
start "" kubectl port-forward $(kubectl get pods -n %recipe_namespace% -l %recipe_selector% -o jsonpath='{.items[0].metadata.name}') %recipe_port%:8443 -n %recipe_namespace%

start "" kubectl port-forward $(kubectl get pods -n %ims_internal_namespace% -l %ims_internal_selector% -o jsonpath='{.items[0].metadata.name}') %ims_internal_port%:8080 -n %ims_internal_namespace%

start "" kubectl port-forward $(kubectl get pods -n %ims_inventory_order_namespace% -l %ims_inventory_order_selector% -o jsonpath='{.items[0].metadata.name}') %ims_inventory_order_port%:8443 -n %ims_inventory_order_namespace%

start "" kubectl port-forward $(kubectl get pods -n %restaurant_namespace% -l %restaurant_selector% -o jsonpath='{.items[0].metadata.name}') %restaurant_port%:8443 -n %restaurant_namespace%

start "" kubectl port-forward $(kubectl get pods -n %cis_namespace% -l %cis_selector% -o jsonpath='{.items[0].metadata.name}') %cis_port%:8443 -n %cis_namespace%

start "" kubectl port-forward $(kubectl get pods -n %kos_namespace% -l %kos_selector% -o jsonpath='{.items[0].metadata.name}') %kos_port%:8443 -n %kos_namespace%

start "" kubectl port-forward $(kubectl get pods -n %kms_namespace% -l %kms_selector% -o jsonpath='{.items[0].metadata.name}') %kms_port%:8443 -n %kms_namespace%

:: Wait for all port forwarding to complete
pause