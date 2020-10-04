Class {
	#name : #NmDevelopmentPaths,
	#superclass : #NmResourcePaths,
	#category : #'Nevermind-Model'
}

{ #category : #testing }
NmDevelopmentPaths class >> isActive [

	^ CrModelApplication isDevelopment
]

{ #category : #accessing }
NmDevelopmentPaths >> repositoryDir [

	^ (IceRepository registry detect: [ :each | each name = 'nevermind' ]) location
]

{ #category : #accessing }
NmDevelopmentPaths >> resourcesDirectory [

	^ self repositoryDir / 'resources'
]
