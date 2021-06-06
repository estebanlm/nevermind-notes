Class {
	#name : #NmActivateBookCommand,
	#superclass : #NmBookCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmActivateBookCommand class >> defaultDescription [

	^ 'Activate selected book.'
]

{ #category : #initialization }
NmActivateBookCommand class >> defaultIconName [

	^ 'document-open'
]

{ #category : #accessing }
NmActivateBookCommand class >> defaultName [

	^ 'Activate Book'
]

{ #category : #executing }
NmActivateBookCommand >> execute [
	
	context doActivateSelectedBook
]
