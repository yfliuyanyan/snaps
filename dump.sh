#!/bin/bash

NS=gitpod

resourceList=(
configmaps
endpoints
events
limitranges
persistentvolumeclaims
pods
podtemplates
replicationcontrollers
resourcequotas
secrets
serviceaccounts
services
challenges.acme.cert-manager.io
orders.acme.cert-manager.io
controllerrevisions.apps
daemonsets.apps
deployments.apps
replicasets.apps
statefulsets.apps
horizontalpodautoscalers.autoscaling
cronjobs.batch
jobs.batch
certificaterequests.cert-manager.io
certificates.cert-manager.io
issuers.cert-manager.io
leases.coordination.k8s.io
networkpolicies.crd.projectcalico.org
networksets.crd.projectcalico.org
endpointslices.discovery.k8s.io
events.events.k8s.io
helmchartconfigs.helm.cattle.io
helmcharts.helm.cattle.io
addons.k3s.cattle.io
ingresses.networking.k8s.io
networkpolicies.networking.k8s.io
poddisruptionbudgets.policy
networkpolicies.projectcalico.org
networksets.projectcalico.org
rolebindings.rbac.authorization.k8s.io
roles.rbac.authorization.k8s.io
csistoragecapacities.storage.k8s.io
clusterrolebinding
clusterrole
)

printList(){
	  for aa in ${resourceList[@]};
		    do
			        aList=$(kubectl  -n $NS get $aa |grep -v NAME  |awk '{print $1}')
				    if [ ! "${aList[*]}"x == "x" ];then
					          [ -d ./$aa ] || mkdir ./$aa
						        for i in $aList;
								      do
									              echo $aa $i
										              kubectl -n $NS get $aa $i -o yaml > $aa/$i.yaml
											            done
												        fi
													  done
												  }

											  # create namespaces yaml
											  kubectl  get namespaces $NS -o yaml > namespaces.yaml

											  # create pv yaml
											  pvList=$(kubectl get pv |grep "$NS/" |awk '{print $1}')
											  if [ ! "${pvList[*]}"x == "x" ];then
												    for i in ${pvList[@]}
													      do
														          echo pv $i
															      kubectl get pv $i -o yaml > $i.pv.yaml
															        done
											  fi

											  printList


