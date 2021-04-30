Class {
	#name : #NmRemoveBookCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #executing }
NmRemoveBookCommand >> execute [
	
	context doRemoveSelectedBook
]
