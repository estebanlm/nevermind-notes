Class {
	#name : #NmDevelopmentPaths,
	#superclass : #NmResourcePaths,
	#category : #'Notes-Model'
}

{ #category : #testing }
NmDevelopmentPaths class >> isActive [

	^ NmModelApplication isDevelopment
]

{ #category : #accessing }
NmDevelopmentPaths >> repositoryDir [

	^ ((Smalltalk classNamed: #IceRepository) registry 
		detect: [ :each | each name = 'nevermind-notes' ]) 
		location
]

{ #category : #accessing }
NmDevelopmentPaths >> resourcesDirectory [

	^ self repositoryDir / 'resources'
]
