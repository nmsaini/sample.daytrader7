# 1. Install openshift-pipelines operator

# 2. create the namespace
`oc new-project mynamespace`

# 3. create pvc
`oc apply -f https://raw.githubusercontent.com/nmsaini/sample.daytrader7/master/tekton/build-pvc.yaml`

# 4. create pipeline
`oc apply -f https://raw.githubusercontent.com/nmsaini/sample.daytrader7/master/tekton/pipeline.yaml`

# 5. start the pipeline
```
tkn pipeline start daytrader-build-deploy-pipeline \
	--param image-ns=$(oc project -q) \
	--param git-url=https://github.com/nmsaini/sample.daytrader7.git \
	--param dockerfile-name=maven-using-liberty.dockerfile \
	--param image-name=daytrader7app \
	--param image-port=9080 \
  	--workspace name=workspace,claimName=daytrader-build-pvc
```

# 6. launch in browser
`echo http://$(oc get routes daytrader7app -o jsonpath='{.spec.host}{"\n"}')/daytrader`
