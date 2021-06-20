Class {
	#name : #NmCommandGroup,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Nevermind-View-Commands'
}

{ #category : #accessing }
NmCommandGroup class >> book [

	^ NmCommandBookGroup uniqueInstance
]

{ #category : #accessing }
NmCommandGroup class >> general [

	^ NmCommandGeneralGroup uniqueInstance
]

{ #category : #accessing }
NmCommandGroup class >> note [

	^ NmCommandNoteGroup uniqueInstance
]

{ #category : #accessing }
NmCommandGroup class >> uniqueInstance [

	self = NmCommandGroup 
		ifTrue: [ self error: 'I''m abstract, use one of my children instead' ].
	^ uniqueInstance ifNil: [ 
		uniqueInstance := self basicNew initialize ]
]

{ #category : #accessing }
NmCommandGroup >> name [

	^ self subclassResponsibility
]

{ #category : #accessing }
NmCommandGroup >> order [

	^ self subclassResponsibility
]
