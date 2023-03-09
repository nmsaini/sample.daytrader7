# 1. Install openshift-pipelines operator

# 2. create the namespace
`oc new-project mynamespace`

# 3. create pvc
`oc apply -f https://raw.githubusercontent.com/nmsaini/sample.daytrader7/master/tekton/build-pvc.yaml`

# 4. create pipeline
`oc apply -f https://raw.githubusercontent.com/nmsaini/sample.daytrader7/master/tekton/pipeline.yaml`

# 5. start the pipeline
