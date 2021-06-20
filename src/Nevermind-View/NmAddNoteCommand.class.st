Class {
	#name : #NmAddNoteCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmAddNoteCommand class >> defaultDescription [

	^ 'Add a new note.'
]

{ #category : #default }
NmAddNoteCommand class >> defaultIconName [

	^ 'document-new'
]

{ #category : #default }
NmAddNoteCommand class >> defaultName [

	^ 'Add Note'
]

{ #category : #default }
NmAddNoteCommand class >> defaultShortcut [

	^ $n platformMeta
]

{ #category : #accessing }
NmAddNoteCommand class >> group [

	^ NmCommandNoteGroup book
]

{ #category : #executing }
NmAddNoteCommand >> execute [
	
	context doAddNote
]
