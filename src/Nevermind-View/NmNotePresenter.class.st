Class {
	#name : #NmNotePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'sourceView',
		'note'
	],
	#category : #'Nevermind-View-Notebook'
}

{ #category : #initialization }
NmNotePresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical
		add: (self newGtkWidget
			widget: self newSourceView;
			yourself);
		yourself)
]

{ #category : #initialization }
NmNotePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Note';
		initialExtent: self application defaultMainWindowExtent
]

{ #category : #private }
NmNotePresenter >> loadNote [

	GtkRunLoop defer: [ 
		| buffer |
		buffer := GtkSourceBuffer new 
			language: GtkSourceLanguageManager markdown;
			text: self note contents;
			yourself.
		buffer connectChanged: [ self textChanged ].
		sourceView textBuffer: buffer ]
]

{ #category : #initialization }
NmNotePresenter >> newSourceView [
		
	sourceView := GtkSourceView new
		"marginStart: 10;
		marginEnd: 10;"
		tabWidth: 4;
		beWrapWord;
		yourself.

	^ GtkScrolledWindow new
		add: sourceView;
		showAll
]

{ #category : #accessing }
NmNotePresenter >> note [

	^ note
]

{ #category : #accessing }
NmNotePresenter >> note: aNote [

	note := aNote.
	self loadNote
]

{ #category : #'accessing model' }
NmNotePresenter >> setModelBeforeInitialization: aNote [ 

	note := aNote
]

{ #category : #private }
NmNotePresenter >> textChanged [
	| newText |
	
	newText := sourceView text.
	[
		"I put this outside to leave the callback (then it does not interfere with the UI"
		self note contents: newText.
		self application notificationCenter notify: (NmNoteChangedNotification newNote: self note)
	] schedule

]

{ #category : #initialization }
NmNotePresenter >> updatePresenter [

	self note ifNil: [ ^ self ].
	self loadNote
]
