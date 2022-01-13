Class {
	#name : #NmThemeChanged,
	#superclass : #NmNotification,
	#category : #'Notes-View-Application'
}

{ #category : #accessing }
NmThemeChanged class >> receiverSelector [

	^ #noteThemeChanged:
]
