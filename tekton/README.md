### 1. Install openshift-pipelines operator

### 2. Install tekton cli
```
dnf copr enable chmouel/tektoncd-cli
dnf install tektoncd-cli
```

### 3. create the namespace
```
oc new-project mynamespace
```

### 4. create pvc
```
oc apply -f https://raw.githubusercontent.com/nmsaini/sample.daytrader7/master/tekton/build-pvc.yaml
```

### 5. create pipeline
```
oc apply -f https://raw.githubusercontent.com/nmsaini/sample.daytrader7/master/tekton/pipeline.yaml
```

### 6. Create a ServiceAccount and assign anyuid SCC as derby database needs to run under a specific user
```
oc create serviceaccount daytrader7app-sa
oc adm policy add-scc-to-user anyuid -z daytrader7app-sa
```

### 7. start the pipeline
```
tkn pipeline start daytrader-build-deploy-pipeline \
	--param image-ns=$(oc project -q) \
	--param git-url=https://github.com/nmsaini/sample.daytrader7.git \
	--param dockerfile-name=maven-using-liberty.dockerfile \
	--param image-name=daytrader7app \
	--param image-port=9080 \
  	--workspace name=workspace,claimName=daytrader-build-pvc
```

### 8. Apply service account to the deployment that was created in step 6.
```
oc set serviceaccount deployment/daytrader7app daytrader7app-sa
```

### 9. launch in browser
```
echo http://$(oc get routes daytrader7app -o jsonpath='{.spec.host}{"\n"}')/daytrader
```
