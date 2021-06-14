Class {
	#name : #NmDocumentOpener,
	#superclass : #Object,
	#category : #'Nevermind-View-Utils'
}

{ #category : #opening }
NmDocumentOpener >> open: aName [		

	WebBrowser openOn: aName
]
