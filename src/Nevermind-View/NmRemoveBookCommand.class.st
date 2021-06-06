Class {
	#name : #NmRemoveBookCommand,
	#superclass : #NmBookCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmRemoveBookCommand class >> defaultDescription [

	^ 'Remove an existing book and all its notes.'
]

{ #category : #initialization }
NmRemoveBookCommand class >> defaultIconName [

	^ 'delete'
]

{ #category : #accessing }
NmRemoveBookCommand class >> defaultName [

	^ 'Remove Book'
]

{ #category : #initialization }
NmRemoveBookCommand class >> defaultShortcut [

	^ $x platformMeta
]

{ #category : #executing }
NmRemoveBookCommand >> execute [
	
	context doRemoveSelectedBook
]
