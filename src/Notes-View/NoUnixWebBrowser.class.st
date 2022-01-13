Class {
	#name : #NoUnixWebBrowser,
	#superclass : #NoWebBrowser,
	#category : #'Notes-View-WebBrowser'
}

{ #category : #testing }
NoUnixWebBrowser class >> isForCurrentSystem [

	^Smalltalk os isUnix  
]

{ #category : #private }
NoUnixWebBrowser class >> openNativeWebBrowserOn: anURLString [

	| openCommand |
	openCommand := 'xdg-open ''{1}'' &' format: { anURLString }.
	self system: openCommand
]

{ #category : #'private - uffi' }
NoUnixWebBrowser class >> system: command [

	^LibC system: command 
]
