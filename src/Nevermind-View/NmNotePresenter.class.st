Class {
	#name : #NmNotePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'sourceView',
		'note',
		'actionBar'
	],
	#category : #'Nevermind-View-Notebook'
}

{ #category : #actions }
NmNotePresenter >> doExport [
	
	self flag: #TODO.
]

{ #category : #initialization }
NmNotePresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical
		add: (actionBar := self newActionBar) expand: false;
		add: (self newGtkWidget
			widget: self newSourceView;
			yourself);
		yourself).
		
	actionBar 
		addLast: (self newButton 
			icon: (self application buttonIconNamed: 'document-export');
			action: [ self doExport ];
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
		sourceView textBuffer text: self note contents ]
]

{ #category : #private }
NmNotePresenter >> margin [

	^ 5
]

{ #category : #initialization }
NmNotePresenter >> newSourceView [
	| scrolledWindow sourceBuffer margin |

	margin := self margin.
	sourceView := GtkSourceView new
		marginStart: margin;
		marginEnd: margin;
		tabWidth: 4;
		beWrapWord;
		yourself.

	sourceBuffer := GtkSourceBuffer new 
		language: GtkSourceLanguageManager markdown;
		text: self note contents;
		yourself.
	sourceBuffer connectChanged: [ self textChanged ].
	sourceView textBuffer: sourceBuffer.

	scrolledWindow := GtkScrolledWindow newWidget: sourceView.
	scrolledWindow addClass: 'note'.
		
	^ scrolledWindow showAll
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
