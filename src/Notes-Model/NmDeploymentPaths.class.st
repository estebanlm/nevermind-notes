Class {
	#name : #NmDeploymentPaths,
	#superclass : #NmResourcePaths,
	#category : #'Notes-Model'
}

{ #category : #testing }
NmDeploymentPaths class >> isActive [

	^ NmModelApplication isDevelopment not
]

{ #category : #accessing }
NmDeploymentPaths >> resourcesDirectory [

	^ FileLocator imageDirectory
]
