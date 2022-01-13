Class {
	#name : #NmModelApplication,
	#superclass : #Object,
	#instVars : [
		'repository',
		'paths',
		'activeBook'
	],
	#classVars : [
		'Current',
		'Development'
	],
	#category : #'Notes-Model'
}

{ #category : #accessing }
NmModelApplication class >> beDevelopment [
	<script>

	Development := true
]

{ #category : #accessing }
NmModelApplication class >> beProduction [
	<script>

	Development := false
]

{ #category : #'instance creation' }
NmModelApplication class >> current [

	^ Current ifNil: [ Current := super new ]
]

{ #category : #'class initialization' }
NmModelApplication class >> initialize [

	self beDevelopment
]

{ #category : #testing }
NmModelApplication class >> isDevelopment [

	^ Development and: [ (Smalltalk classNamed: #IceRepository) notNil ]
]

{ #category : #'instance creation' }
NmModelApplication class >> new [

	self error: 'Use #current'
]

{ #category : #initialization }
NmModelApplication class >> reset [

	Current := nil
]

{ #category : #accessing }
NmModelApplication >> activateBook: aBook [

	activeBook := aBook	
]

{ #category : #accessing }
NmModelApplication >> activateRepository [
	| reference |
	
	repository ifNotNil: [ repository close ].
	reference := self paths repositoryReference.
	repository := VoEJDBRepository on: reference
]

{ #category : #accessing }
NmModelApplication >> activeBook [

	^ activeBook ifNil: [ activeBook := self defaultBook ]
]

{ #category : #accessing }
NmModelApplication >> allBooks [
	| books |

	books := self repository selectAll: NmBook.
	books ifEmpty: [ 
		self ensureDefaultBook.
		^ self allBooks ].
	^ books
]

{ #category : #accessing }
NmModelApplication >> defaultBook [

	^ self allBooks detect: [ :each | each isDefault ]
]

{ #category : #private }
NmModelApplication >> ensureDefaultBook [

	NmBook newDefault save
]

{ #category : #initialization }
NmModelApplication >> initialize [

	super initialize.
	paths := NmResourcePaths newActive
]

{ #category : #accessing }
NmModelApplication >> paths [

	^ paths
]

{ #category : #accessing }
NmModelApplication >> repository [

	^ repository ifNil: [ 
		self activateRepository.
		repository ]
]

{ #category : #'system startup' }
NmModelApplication >> shutDown [

	repository ifNil: [ ^ self ].
	repository close
]

{ #category : #'system startup' }
NmModelApplication >> startUp [

	self initialize
]
