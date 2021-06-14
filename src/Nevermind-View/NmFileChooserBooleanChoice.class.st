Class {
	#name : #NmFileChooserBooleanChoice,
	#superclass : #NmFileChooserChoice,
	#instVars : [
		'selected'
	],
	#category : #'Nevermind-View-Utils'
}

{ #category : #adding }
NmFileChooserBooleanChoice >> addTo: dialog [
	
	id := dialog addBooleanChoice: self label.
	self isSelected ifTrue: [ 
		dialog choiceAt: id option: 'true' ]
]

{ #category : #adding }
NmFileChooserBooleanChoice >> getFrom: dialog [

	^ (dialog choiceAt: id) = 'true'
]

{ #category : #testing }
NmFileChooserBooleanChoice >> isSelected [

	^ selected
]

{ #category : #accessing }
NmFileChooserBooleanChoice >> selected: aBoolean [

	selected := aBoolean
]
