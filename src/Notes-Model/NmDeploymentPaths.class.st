Class {
	#name : #NmDeploymentPaths,
	#superclass : #NmResourcePaths,
	#category : #'Notes-Model'
}

{ #category : #testing }
NmDeploymentPaths class >> isActive [

	^ NmModelApplication isDevelopment not
]
