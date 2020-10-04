Class {
	#name : #NmApplication,
	#superclass : #SpApplication,
	#instVars : [
		'notificationCenter'
	],
	#category : #'Nevermind-View-Application'
}

{ #category : #activation }
NmApplication class >> applicationName [

	^ 'notes'
]

{ #category : #'accessing icons' }
NmApplication >> buttonIconNamed: aString [

	^ GtkImage newIconForButtonNamed: aString
]

{ #category : #accessing }
NmApplication >> defaultMainWindowExtent [

	self flag: #TODO. "Take from configuration".
	^ 800@800
]

{ #category : #'accessing icons' }
NmApplication >> iconNamed: aString [

	^ self buttonIconNamed: aString
]

{ #category : #initialization }
NmApplication >> initialize [

	super initialize.
	self useBackend: #Gtk with: NmGtkConfiguration new.
	self initializeModel
]

{ #category : #initialization }
NmApplication >> initializeModel [
	
	NmModelApplication reset
]

{ #category : #'accessing icons' }
NmApplication >> menuIconNamed: aString [

	^ GtkImage newIconForMenuNamed: aString
]

{ #category : #accessing }
NmApplication >> notificationCenter [

	^ notificationCenter ifNil: [ 
		notificationCenter := NmNotificationCenter new ]
]

{ #category : #running }
NmApplication >> start [

	(self new: NmNotebookPresenter) openWithSpec
]
