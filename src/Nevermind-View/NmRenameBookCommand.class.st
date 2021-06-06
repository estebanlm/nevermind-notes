Class {
	#name : #NmRenameBookCommand,
	#superclass : #NmBookCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmRenameBookCommand class >> defaultDescription [

	^ 'Rename a book.'
]

{ #category : #accessing }
NmRenameBookCommand class >> defaultName [

	^ 'Rename Book'
]

{ #category : #initialization }
NmRenameBookCommand class >> defaultShortcut [

	^ $r platformMeta
]

{ #category : #executing }
NmRenameBookCommand >> execute [
	
	context doRenameSelectedBook
]
