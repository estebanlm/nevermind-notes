Class {
	#name : #NmNote,
	#superclass : #Object,
	#instVars : [
		'bookId',
		'contents',
		'lastEditionDate'
	],
	#category : #'Nevermind-Model'
}

{ #category : #accessing }
NmNote class >> emptyTitle [

	^ '(Untitled)'
]

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
NmNote class >> voyageBookId [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: #bookId;
		accessor: (MAPluggableAccessor 
			read: [ :aNote | aNote bookId ]
			write: [ :aTask :id | aTask bookId: id ]);
		yourself
]

{ #category : #persistence }
NmNote class >> voyageCollectionName [
	
	^ 'notes'
]

{ #category : #persistence }
NmNote class >> voyageContents [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: #contents;
		accessor: (MAPluggableAccessor 
			read: [ :aNote | aNote contents ]
			write: [ :aTask :contents | aTask setContents: contents ]);
		yourself
]

{ #category : #persistence }
NmNote class >> voyageLastEditionDate [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: #lastEditionDate;
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
NmNote >> bookId [

	^ bookId 
]

{ #category : #accessing }
NmNote >> bookId: anId [

	bookId := anId
]

{ #category : #private }
NmNote >> cleanFirstLine: aString [
	| cleanLine |

	cleanLine := aString.
	[ cleanLine isNotEmpty and: [ cleanLine first isAlphaNumeric not ] ] 
	whileTrue: [ cleanLine := cleanLine allButFirst ].
	
	^ cleanLine
]

{ #category : #accessing }
NmNote >> contents [

	^ contents ifNil: [ '' ]
]

{ #category : #accessing }
NmNote >> contents: aString [
	
	"Do not do anything if content has not changed"
	contents = aString ifTrue: [ ^ self ].
	
	self setContents: aString.
	self updateLastEditionDate.
	NmNoteCommiter uniqueInstance queue: self
]

{ #category : #accessing }
NmNote >> firstLine [ 

	^ self rawFirstLine ifEmpty: [ self class emptyTitle ]
]

{ #category : #accessing }
NmNote >> humanReadableLastEditionDate [

	^ (self lastEditionDate asDateAndTime + DateAndTime localTimeZone offset) epiceaBrowsersAsString 
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
NmNote >> rawFirstLine [ 

	self contents readStreamDo: [ :stream | 
		| line |
		[ stream atEnd not and: [ (line := stream nextLine trimmed) isEmpty ] ] whileTrue.
		line isEmptyOrNil 
			ifFalse: [ ^ self cleanFirstLine: line ] ].

	^ ''
]

{ #category : #private }
NmNote >> setContents: aString [

	contents := aString
]

{ #category : #private }
NmNote >> setLastEditionDateFromString: aString [ 
	
	aString isString ifFalse: [ ^ self ].
	lastEditionDate := (aString ifNotNil: [ ZTimestamp fromString: aString ])
]

{ #category : #private }
NmNote >> updateLastEditionDate [
	
	lastEditionDate := DateAndTime now asZTimestamp
]
