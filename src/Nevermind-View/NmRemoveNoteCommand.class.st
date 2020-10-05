Class {
	#name : #NmRemoveNoteCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Notebook'
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

{ #category : #testing }
NmRemoveNoteCommand >> canBeExecuted [

	^ context hasSelectedNote 
]

{ #category : #executing }
NmRemoveNoteCommand >> execute [
	
	context doRemoveSelected
]
