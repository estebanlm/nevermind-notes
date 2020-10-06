Class {
	#name : #NmApplication,
	#superclass : #SpApplication,
	#instVars : [
		'notificationCenter'
	],
	#classVars : [
		'Current'
	],
	#classInstVars : [
		'session'
	],
	#category : #'Nevermind-View-Application'
}

{ #category : #activation }
NmApplication class >> applicationName [

	^ 'notes'
]

{ #category : #accessing }
NmApplication class >> current [

	self validateSession.
	^ Current ifNil: [ Current := self new ]
]

{ #category : #initialization }
NmApplication class >> reset [
	<script>

	Current ifNil: [ ^ self ].
	Current emergencyShutdown.
	Current := nil
]

{ #category : #private }
NmApplication class >> validateSession [
	
	session == Smalltalk session ifTrue: [ ^ self ].
	Current := nil.
	session := Smalltalk session
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
NmApplication >> run [

	Current := self.
	super run
]

{ #category : #running }
NmApplication >> start [

	(self new: NmNotebookPresenter) openWithSpec
]
