Class {
	#name : #NmOpenBookCommand,
	#superclass : #NmCommand,
	#category : #'Notes-View-Commands'
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

	^ $o platformMeta
]

{ #category : #accessing }
NmOpenBookCommand class >> group [

	^ NmCommandNoteGroup book
]

{ #category : #executing }
NmOpenBookCommand >> execute [
	
	context doOpenBook
]
