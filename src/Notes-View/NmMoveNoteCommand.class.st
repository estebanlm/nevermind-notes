Class {
	#name : #NmMoveNoteCommand,
	#superclass : #NmCommand,
	#category : #'Notes-View-Commands'
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

{ #category : #accessing }
NmMoveNoteCommand class >> group [

	^ NmCommandNoteGroup note
]

{ #category : #executing }
NmMoveNoteCommand >> execute [
	
	context doMoveNote
]
