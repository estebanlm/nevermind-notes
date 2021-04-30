Class {
	#name : #NmRenameBookCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #executing }
NmRenameBookCommand >> execute [
	
	context doRenameSelectedBook
]
