Class {
	#name : #NmFileChooserOptionsChoice,
	#superclass : #NmFileChooserChoice,
	#instVars : [
		'options',
		'selectedIndex'
	],
	#category : #'Nevermind-View-Utils'
}

{ #category : #adding }
NmFileChooserOptionsChoice >> addTo: dialog [
	
	id := dialog addChoice: self label options: self options.
	self selectedIndex ifNotNil: [ :index |
		dialog choiceAt: id option: index ]
]

{ #category : #adding }
NmFileChooserOptionsChoice >> getFrom: dialog [
	| choosen |
	
	choosen := dialog choiceAt: id.
	^ choosen ifNotNil: [ self options at: choosen asNumber ]
]

{ #category : #accessing }
NmFileChooserOptionsChoice >> options [

	^ options
]

{ #category : #accessing }
NmFileChooserOptionsChoice >> options: anObject [

	options := anObject
]

{ #category : #accessing }
NmFileChooserOptionsChoice >> selectedIndex [

	^ selectedIndex
]

{ #category : #accessing }
NmFileChooserOptionsChoice >> selectedIndex: anObject [

	selectedIndex := anObject
]
