Class {
	#name : #NmNoteChangedNotification,
	#superclass : #NmNotification,
	#instVars : [
		'note'
	],
	#category : #'Notes-View-Notebook'
}

{ #category : #'instance creation' }
NmNoteChangedNotification class >> newNote: aNote [ 

	^ self new note: aNote
]

{ #category : #accessing }
NmNoteChangedNotification class >> receiverSelector [

	^ #noteNoteChanged:
]

{ #category : #accessing }
NmNoteChangedNotification >> note [
	^ note
]

{ #category : #accessing }
NmNoteChangedNotification >> note: anObject [
	note := anObject
]
