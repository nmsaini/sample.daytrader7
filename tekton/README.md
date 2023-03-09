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

### 6. start the pipeline
```
tkn pipeline start daytrader-build-deploy-pipeline \
	--param image-ns=$(oc project -q) \
	--param git-url=https://github.com/nmsaini/sample.daytrader7.git \
	--param dockerfile-name=maven-using-liberty.dockerfile \
	--param image-name=daytrader7app \
	--param image-port=9080 \
  	--workspace name=workspace,claimName=daytrader-build-pvc
```

### 7. launch in browser
```
echo http://$(oc get routes daytrader7app -o jsonpath='{.spec.host}{"\n"}')/daytrader
```
