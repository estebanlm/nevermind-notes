Class {
	#name : #NmNoteMovedNotification,
	#superclass : #NmNotification,
	#instVars : [
		'note',
		'book'
	],
	#category : #'Nevermind-View-Application'
}

{ #category : #'instance creation' }
NmNoteMovedNotification class >> newNote: aNote book: aBook [

	^ self new 
		note: aNote;
		book: aBook;
		yourself
]

{ #category : #accessing }
NmNoteMovedNotification class >> receiverSelector [

	^ #noteNoteMoved:
]

{ #category : #accessing }
NmNoteMovedNotification >> book [

	^ book
]

{ #category : #accessing }
NmNoteMovedNotification >> book: anObject [

	book := anObject
]

{ #category : #accessing }
NmNoteMovedNotification >> note [
	^ note
]

{ #category : #accessing }
NmNoteMovedNotification >> note: anObject [
	note := anObject
]
