Class {
	#name : #NmAddBookCommand,
	#superclass : #NmBookCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmAddBookCommand class >> defaultDescription [

	^ 'Add a new book.'
]

{ #category : #initialization }
NmAddBookCommand class >> defaultIconName [

	^ 'document-new'
]

{ #category : #accessing }
NmAddBookCommand class >> defaultName [

	^ 'Add Book'
]

{ #category : #initialization }
NmAddBookCommand class >> defaultShortcut [

	^ $n platformMeta
]

{ #category : #executing }
NmAddBookCommand >> execute [
	
	context doAddBook
]
