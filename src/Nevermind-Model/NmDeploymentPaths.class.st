Class {
	#name : #NmDeploymentPaths,
	#superclass : #NmResourcePaths,
	#category : #'Nevermind-Model'
}

{ #category : #testing }
NmDeploymentPaths class >> isActive [

	^ CrModelApplication isDevelopment not
]
