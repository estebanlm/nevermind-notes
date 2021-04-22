Class {
	#name : #NmOpenBookCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmOpenBookCommand class >> defaultDescription [

	^ 'Open a book.'
]

{ #category : #default }
NmOpenBookCommand class >> defaultIconName [

	^ 'document-open'
]

{ #category : #default }
NmOpenBookCommand class >> defaultName [

	^ 'Open Book'
]

{ #category : #default }
NmOpenBookCommand class >> defaultShortcut [

	^ $n platformMeta
]

{ #category : #executing }
NmOpenBookCommand >> execute [
	
	context doOpenBook
]
