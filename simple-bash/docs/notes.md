# Setting image change triggers

```
oc import-image simple-bash --from quay.io/rh_ee_dagrant/simple-bash:latest --confirm
oc get deployment simple-bash -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
oc set triggers deployment/simple-bash -c simple-bash --from-image simple-bash:latest
oc get deployment simple-bash -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
```

To trigger a new deployment, simply push a new image to quay.io/rh_ee_dagrant/simple-bash:latest 
Then:
```
oc import-image simple-bash --from quay.io/rh_ee_dagrant/simple-bash:latest
```
