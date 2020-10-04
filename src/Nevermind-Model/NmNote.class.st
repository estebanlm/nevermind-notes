Class {
	#name : #NmNote,
	#superclass : #Object,
	#instVars : [
		'lastEditionDate',
		'contents'
	],
	#category : #'Nevermind-Model'
}

{ #category : #accessing }
NmNote class >> findAll [

	^ self selectAll
]

{ #category : #accessing }
NmNote class >> findAllSortByEditionDate [

	^ self findAll sorted: #lastEditionDate descending
]

{ #category : #testing }
NmNote class >> isVoyageRoot [

	^ true
]

{ #category : #persistence }
NmNote class >> voyageCollectionName [
	
	^ 'notes'
]

{ #category : #persistence }
NmNote class >> voyageLastEditionDate [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: 'lastEditionDate';
		accessor: (MAPluggableAccessor 
			read: [ :aNote | aNote lastEditionDate ifNotNil: #asString ]
			write: [ :aTask :date | aTask setLastEditionDateFromString: date ]);
		yourself
]

{ #category : #persistence }
NmNote class >> voyageRepository [

	^ NmModelApplication current repository
]

{ #category : #accessing }
NmNote >> contents [

	^ contents ifNil: [ '' ]
]

{ #category : #accessing }
NmNote >> contents: aString [
	
	contents := aString.
	self updateLastEditionDate.
	NmNoteCommiter uniqueInstance queue: self
]

{ #category : #accessing }
NmNote >> humanReadableLastEditionDate [

	^ self lastEditionDate asDateAndTime epiceaBrowsersAsString 
]

{ #category : #initialization }
NmNote >> initialize [

	super initialize.
	self updateLastEditionDate
]

{ #category : #accessing }
NmNote >> lastEditionDate [

	^ lastEditionDate
]

{ #category : #private }
NmNote >> setLastEditionDateFromString: aString [ 
	
	aString isString ifFalse: [ ^ self ].
	lastEditionDate := (aString ifNotNil: [ ZTimestamp fromString: aString ])
]

{ #category : #private }
NmNote >> updateLastEditionDate [
	
	lastEditionDate := ZTimestamp now
]
