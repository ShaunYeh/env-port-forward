@echo off

REM Define the label selectors for each service
set recipe_selector=app=recipe-service-v2
set ims_internal_selector=app=ims-internal-api
set ims_inventory_order_selector=app=ims-inventory-order-service
set restaurant_selector=app=restaurant-service-v2
set cis_selector=app=hdr-inventory-service
set kos_selector=app=kitchen-order-service
set kms_selector=app=kitchen-management-service

REM Define the namespace and port numbers for each service
set recipe_namespace=dev-master-data
set recipe_port=8092
set ims_internal_namespace=dev-ship
set ims_internal_port=8094
set ims_inventory_order_namespace=dev-ship
set ims_inventory_order_port=8099
set restaurant_namespace=dev-consumer
set restaurant_port=8093
set cis_namespace=dev-inventory
set cis_port=8088
set cis_redis_port=6379
set kos_namespace=dev-hdr
set kos_port=8090
set kms_namespace=dev-hdr
set kms_port=8091

kubectl config use-context FTIDevAKSClusterV2

REM Port forward the pods for each service
start "Recipe Service" cmd /c kubectl port-forward $(kubectl get pods -n %recipe_namespace% -l %recipe_selector% -o jsonpath="{.items[0].metadata.name}") %recipe_port:8443 -n %recipe_namespace%

start "IMS Internal API" cmd /c kubectl port-forward $(kubectl get pods -n %ims_internal_namespace% -l %ims_internal_selector% -o jsonpath="{.items[0].metadata.name}") %ims_internal_port:8080 -n %ims_internal_namespace%

start "IMS Inventory Order Service" cmd /c kubectl port-forward $(kubectl get pods -n %ims_inventory_order_namespace% -l %ims_inventory_order_selector% -o jsonpath="{.items[0].metadata.name}") %ims_inventory_order_port:8443 -n %ims_inventory_order_namespace%

start "Restaurant Service" cmd /c kubectl port-forward $(kubectl get pods -n %restaurant_namespace% -l %restaurant_selector% -o jsonpath="{.items[0].metadata.name}") %restaurant_port:8443 -n %restaurant_namespace%

start "CIS Service" cmd /c kubectl port-forward $(kubectl get pods -n %cis_namespace% -l %cis_selector% -o jsonpath="{.items[0].metadata.name}") %cis_port:8443 -n %cis_namespace%

start "KOS Service" cmd /c kubectl port-forward $(kubectl get pods -n %kos_namespace% -l %kos_selector% -o jsonpath="{.items[0].metadata.name}") %kos_port:8443 -n %kos_namespace%

start "KMS Service" cmd /c kubectl port-forward $(kubectl get pods -n %kms_namespace% -l %kms_selector% -o jsonpath="{.items[0].metadata.name}") %kms_port:8443 -n %kms_namespace%

start "CIS Redis" cmd /c kubectl port-forward redis-0 %cis_redis_port%:6379 -n %cis_namespace%