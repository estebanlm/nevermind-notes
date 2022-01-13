Class {
	#name : #NmBook,
	#superclass : #Object,
	#instVars : [
		'name',
		'default'
	],
	#category : #'Notes-Model'
}

{ #category : #accessing }
NmBook class >> defaultBookName [

	^ 'Default'
]

{ #category : #accessing }
NmBook class >> findAll [

	^ self selectAll
]

{ #category : #testing }
NmBook class >> isVoyageRoot [

	^ true
]

{ #category : #'instance creation' }
NmBook class >> newDefault [

	^ self newName: self defaultBookName
]

{ #category : #'instance creation' }
NmBook class >> newName: aString [

	^ self new 
		name: aString;
		yourself
]

{ #category : #persistence }
NmBook class >> voyageCollectionName [
	
	^ 'books'
]

{ #category : #persistence }
NmBook class >> voyageRepository [

	^ NmModelApplication current repository
]

{ #category : #accessing }
NmBook >> addNote: aNote [

	aNote bookId: self voyageId.
	aNote save
]

{ #category : #accessing }
NmBook >> beDefault [

	default := true
]

{ #category : #initialization }
NmBook >> initialize [

	super initialize.
	default := false
]

{ #category : #testing }
NmBook >> isDefault [

	^ default
]

{ #category : #accessing }
NmBook >> name [

	^ name
]

{ #category : #accessing }
NmBook >> name: aString [

	name := aString
]

{ #category : #accessing }
NmBook >> notes [
	| id |

	id := self voyageId.
	^ self class voyageRepository 
		selectMany: NmNote 
		where: [ :each | each bookId = id ]
]

{ #category : #accessing }
NmBook >> notesSortedByEditionDate [

	^ self notes sorted: #lastEditionDate descending
]

{ #category : #printing }
NmBook >> printOn: stream [

	super printOn: stream.
	stream << '(' << (self name ifNil: [ 'Noname' ]) << ')'
]

{ #category : #accessing }
NmBook >> priority [

	^ self isDefault 
		ifTrue: [ 0 ]
		ifFalse: [ 1 ]
]

{ #category : #accessing }
NmBook >> removeNote: aNote [

	aNote remove
]
