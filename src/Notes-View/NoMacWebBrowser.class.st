Class {
	#name : #NoMacWebBrowser,
	#superclass : #NoWebBrowser,
	#category : #'Notes-View-WebBrowser'
}

{ #category : #testing }
NoMacWebBrowser class >> isForCurrentSystem [

	^Smalltalk os isMacOS 
]

{ #category : #private }
NoMacWebBrowser class >> openNativeWebBrowserOn: anURLString [

	| openCommand |
	openCommand := 'open "{1}"' format: { anURLString }.
	self system: openCommand
]

{ #category : #'private - uffi' }
NoMacWebBrowser class >> system: command [

	^LibC system: command 
]
