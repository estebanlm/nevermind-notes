Class {
	#name : #NmBook,
	#superclass : #Object,
	#instVars : [
		'databaseName'
	],
	#category : #'Nevermind-Model'
}

{ #category : #accessing }
NmBook class >> defaultFileName [

	^ '_notes'
]

{ #category : #accessing }
NmBook class >> defaultName [

	^ 'Notes'
]

{ #category : #accessing }
NmBook class >> extension [

	^ '.edb'
]

{ #category : #'instance creation' }
NmBook class >> newDefault [

	^ self newName: self defaultFileName
]

{ #category : #'instance creation' }
NmBook class >> newName: aString [

	^ self new 
		name: aString;
		yourself
]

{ #category : #'instance creation' }
NmBook class >> readAllFrom: aDirectory [

	^ (aDirectory childrenMatching: ('*', self extension)) 
		collect: [ :each | 
			self new 
				databaseName: each base;
				yourself ]
]

{ #category : #accessing }
NmBook >> databaseName [

	^ databaseName
]

{ #category : #accessing }
NmBook >> databaseName: aString [

	databaseName := aString
]

{ #category : #testing }
NmBook >> isDefault [

	^ self databaseName = (self class defaultFileName, self class extension)
]

{ #category : #accessing }
NmBook >> name [

	^ self isDefault 
		ifTrue: [ self class defaultName ]
		ifFalse: [ self databaseName allButLast: self class extension size	]
	
]

{ #category : #accessing }
NmBook >> name: aString [

	databaseName := aString, self class extension
]
