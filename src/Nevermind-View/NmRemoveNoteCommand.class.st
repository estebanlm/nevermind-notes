Class {
	#name : #NmRemoveNoteCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmRemoveNoteCommand class >> defaultDescription [

	^ 'Remove this note.'
]

{ #category : #default }
NmRemoveNoteCommand class >> defaultIconName [

	^ 'delete'
]

{ #category : #default }
NmRemoveNoteCommand class >> defaultName [

	^ 'Remove Note'
]

{ #category : #default }
NmRemoveNoteCommand class >> defaultShortcut [

	^ $x platformMeta
]

{ #category : #accessing }
NmRemoveNoteCommand class >> group [

	^ NmCommandNoteGroup note
]

{ #category : #testing }
NmRemoveNoteCommand >> canBeExecuted [

	^ context hasSelectedNote 
]

{ #category : #executing }
NmRemoveNoteCommand >> execute [
	
	context doRemoveSelected
]
