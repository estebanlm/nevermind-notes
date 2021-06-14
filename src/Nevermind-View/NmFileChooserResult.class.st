Class {
	#name : #NmFileChooserResult,
	#superclass : #Object,
	#instVars : [
		'directory',
		'name',
		'choices'
	],
	#category : #'Nevermind-View-Utils'
}

{ #category : #accessing }
NmFileChooserResult >> choices [

	^ choices
]

{ #category : #accessing }
NmFileChooserResult >> choices: anObject [

	choices := anObject
]

{ #category : #accessing }
NmFileChooserResult >> directory [

	^ directory
]

{ #category : #accessing }
NmFileChooserResult >> directory: anObject [

	directory := anObject
]

{ #category : #accessing }
NmFileChooserResult >> fileReference [

	^ self directory asFileReference / self name
]

{ #category : #accessing }
NmFileChooserResult >> name [

	^ name
]

{ #category : #accessing }
NmFileChooserResult >> name: anObject [

	name := anObject
]
