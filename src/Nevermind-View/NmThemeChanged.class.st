Class {
	#name : #NmThemeChanged,
	#superclass : #NmNotification,
	#category : #'Nevermind-View-Application'
}

{ #category : #accessing }
NmThemeChanged class >> receiverSelector [

	^ #noteThemeChanged:
]
