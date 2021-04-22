Class {
	#name : #NmResourcePaths,
	#superclass : #Object,
	#category : #'Nevermind-Model'
}

{ #category : #testing }
NmResourcePaths class >> isActive [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
NmResourcePaths class >> newActive [

	^ (self allSubclasses detect: #isActive) new
		
]

{ #category : #accessing }
NmResourcePaths >> bookDirectory [

	^ (FileLocator imageDirectory / 'books') ensureCreateDirectory
]

{ #category : #accessing }
NmResourcePaths >> databaseName [

	^ 'notes.edb'
]

{ #category : #accessing }
NmResourcePaths >> iconsDirectory [

	^ self resourcesDirectory / 'icons' / '16'
]

{ #category : #accessing }
NmResourcePaths >> repositoryReference [

	^ FileLocator imageDirectory / self databaseName
]

{ #category : #accessing }
NmResourcePaths >> resourcesDirectory [

	^ FileLocator imageDirectory
]
