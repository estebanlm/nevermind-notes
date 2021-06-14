Class {
	#name : #NmFileChooserChoice,
	#superclass : #Object,
	#instVars : [
		'label',
		'id'
	],
	#category : #'Nevermind-View-Utils'
}

{ #category : #adding }
NmFileChooserChoice >> addTo: dialog [
	
	self subclassResponsibility
]

{ #category : #adding }
NmFileChooserChoice >> getFrom: dialog [

	self subclassResponsibility
]

{ #category : #accessing }
NmFileChooserChoice >> id [

	^ id
]

{ #category : #accessing }
NmFileChooserChoice >> id: anObject [

	id := anObject
]

{ #category : #accessing }
NmFileChooserChoice >> label [

	^ label
]

{ #category : #accessing }
NmFileChooserChoice >> label: anObject [

	label := anObject
]
