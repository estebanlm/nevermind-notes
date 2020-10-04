Class {
	#name : #NmModelApplication,
	#superclass : #Object,
	#instVars : [
		'repository',
		'paths'
	],
	#classVars : [
		'Current',
		'Development'
	],
	#category : #'Nevermind-Model'
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

	^ Development
]

{ #category : #'instance creation' }
NmModelApplication class >> new [

	self error: 'Use #current'
]

{ #category : #initialization }
NmModelApplication class >> reset [

	Current := nil
]

{ #category : #initialization }
NmModelApplication >> initialize [

	super initialize.
	paths := NmResourcePaths newActive.
	self initializeRepository
]

{ #category : #initialization }
NmModelApplication >> initializeRepository [
	| reference |

	reference := self paths repositoryReference.
	repository := VoEJDBRepository on: reference
]

{ #category : #accessing }
NmModelApplication >> paths [

	^ paths
]

{ #category : #accessing }
NmModelApplication >> repository [

	^ repository
]
