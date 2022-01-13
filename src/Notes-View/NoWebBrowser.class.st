Class {
	#name : #NoWebBrowser,
	#superclass : #Object,
	#category : #'Notes-View-WebBrowser'
}

{ #category : #examples }
NoWebBrowser class >> example [

	self openOn: 'http://pharo.org'
]

{ #category : #testing }
NoWebBrowser class >> isForCurrentSystem [

	^self subclassResponsibility 
]

{ #category : #testing }
NoWebBrowser class >> isUsed [
	"all my subclasses are used by me"
	
	^self name = #WebBrowser
		ifTrue: [ super isUsed ]
		ifFalse: [ true ]
]

{ #category : #private }
NoWebBrowser class >> openNativeWebBrowserOn: aURLString [

	self subclassResponsibility
]

{ #category : #'instance creation' }
NoWebBrowser class >> openOn: anURLOrString [
	"Open the webbrowser on the given URL or String"
	
	^self webbrowserClassForPlatform 
				openNativeWebBrowserOn: anURLOrString asString

]

{ #category : #'private - accessing' }
NoWebBrowser class >> webbrowserClassForPlatform [

  ^ self allSubclasses 
				detect: #isForCurrentSystem 
				ifNone: [ self error: 'No web browser subclass for platform provided' ]
]
