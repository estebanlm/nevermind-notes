Class {
	#name : #NmMoveNoteCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmMoveNoteCommand class >> defaultDescription [

	^ 'Move note to another book.'
]

{ #category : #default }
NmMoveNoteCommand class >> defaultIconName [

	^ 'folder-move'
]

{ #category : #default }
NmMoveNoteCommand class >> defaultName [

	^ 'Move Note'
]

{ #category : #default }
NmMoveNoteCommand class >> defaultShortcut [

	^ $m platformMeta
]

{ #category : #executing }
NmMoveNoteCommand >> execute [
	
	context doMoveNote
]
