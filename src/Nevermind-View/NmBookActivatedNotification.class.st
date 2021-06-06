Class {
	#name : #NmBookActivatedNotification,
	#superclass : #NmNotification,
	#instVars : [
		'book'
	],
	#category : #'Nevermind-View-Book'
}

{ #category : #'instance creation' }
NmBookActivatedNotification class >> newBook: aBook [

	^ self new 
		book: aBook;
		yourself
]

{ #category : #accessing }
NmBookActivatedNotification class >> receiverSelector [

	^ #noteBookActivated:
]

{ #category : #accessing }
NmBookActivatedNotification >> book [

	^ book
]

{ #category : #accessing }
NmBookActivatedNotification >> book: anObject [

	book := anObject
]
