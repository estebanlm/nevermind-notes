Class {
	#name : #NmDocumentOpener,
	#superclass : #Object,
	#category : #'Notes-View-Utils'
}

{ #category : #opening }
NmDocumentOpener >> open: aName [		

	NoWebBrowser openOn: aName
]
