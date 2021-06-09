Class {
	#name : #NmBookRenamedNotification,
	#superclass : #NmNotification,
	#instVars : [
		'book'
	],
	#category : #'Nevermind-View-Book'
}

{ #category : #'instance creation' }
NmBookRenamedNotification class >> newBook: aBook [

	^ self new 
		book: aBook;
		yourself
]

{ #category : #accessing }
NmBookRenamedNotification class >> receiverSelector [

	^ #noteBookRenamed:
]

{ #category : #accessing }
NmBookRenamedNotification >> book [

	^ book
]

{ #category : #accessing }
NmBookRenamedNotification >> book: anObject [

	book := anObject
]
