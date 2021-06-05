Class {
	#name : #NmNotePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'sourceView',
		'note',
		'actionBar',
		'sourcePresenter',
		'notePanelVisible',
		'toggleNotePanelAction',
		'toggleNotePanelButton',
		'searchText',
		'searchPanel'
	],
	#category : #'Nevermind-View-Notebook'
}

{ #category : #private }
NmNotePresenter >> calculateMargin: aRect of: aGtkSourceView [
	| w textWidth margin |
	
	w := aRect width.
	textWidth := self application textWidth.
	margin := w > (textWidth + (self margin width))
		ifTrue: [ | border |
			border := ((w - textWidth) / 2) asInteger. 
			Margin 
				top: self margin top 
				left: border
				bottom: self margin bottom  
				right: border ]
		ifFalse: [ self margin ].
		
	aGtkSourceView
		topMargin: margin top;
		leftMargin: margin left;
		bottomMargin: margin bottom;
		rightMargin: margin right.
		

]

{ #category : #'api-focus' }
NmNotePresenter >> defaultKeyboardFocus [

	^ sourcePresenter
]

{ #category : #actions }
NmNotePresenter >> doExport [
	
	self flag: #TODO.
]

{ #category : #actions }
NmNotePresenter >> doToggleNotePanel [

	toggleNotePanelAction ifNil: [ ^ self ].
	notePanelVisible := toggleNotePanelAction value
]

{ #category : #'actions search' }
NmNotePresenter >> highlightSearchText: aBoolean [

	GtkRunLoop defer: [
		sourceView textBuffer searchContext highlight: aBoolean ]
]

{ #category : #initialization }
NmNotePresenter >> initialize [

	notePanelVisible := true.
	super initialize
]

{ #category : #initialization }
NmNotePresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical
		add: (actionBar := self newActionBar) expand: false;
		add: (SpOverlayLayout new 
			child: ((sourcePresenter := self newGtkWidget)
				widget: self newSourceView;
				yourself);
			addOverlay: (searchPanel := self instantiate: NmSearchTextPresenter on: self) 
				withConstraints: [ :c | c vAlignStart; hAlignEnd ];
			yourself);
		yourself).

	"For some reason, hide just works fine once widget is built :("
	self whenBuiltDo: [ searchPanel hide. ].

	actionBar 
		add: ((toggleNotePanelButton := self newToggleButton) 
			icon: (self application buttonIconNamed: 'sidebar');
			state: true;
			whenActivatedDo: [ self doToggleNotePanel ];
			whenDeactivatedDo: [ self doToggleNotePanel ];
			yourself)	;
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
NmNotePresenter >> languageMarkdown [
	
	^ self application languageMarkdown
]

{ #category : #private }
NmNotePresenter >> loadNote [

	GtkRunLoop defer: [ 
		sourceView textBuffer text: self note contents ]
]

{ #category : #private }
NmNotePresenter >> margin [

	^ self application noteMargin
]

{ #category : #initialization }
NmNotePresenter >> newSourceView [
	| scrolledWindow |

	sourceView := GtkSourceView new
		addClass: 'noteText';
		connectSizeAllocate: [ :aRect | self calculateMargin: aRect of: sourceView ];
		tabWidth: 4;
		beWrapWord;
		yourself.

	sourceView textBuffer: (GtkSourceBuffer new 
		language: self languageMarkdown;
		styleScheme: self styleScheme;
		text: self note contents;
		connectChanged: [ self textChanged ];
		yourself).

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

{ #category : #'actions search' }
NmNotePresenter >> searchBackward [

	GtkRunLoop defer: [
		| buffer |
		buffer := sourceView textBuffer.
		buffer searchContext 
			backwardThenDo: [ :start :end :wrappedAround | 
				buffer
					selectRangeInsert: start 
					bound: end ] ]
]

{ #category : #'actions search' }
NmNotePresenter >> searchForward [

	GtkRunLoop defer: [
		| buffer |
		buffer := sourceView textBuffer.
		buffer searchContext 
			forwardThenDo: [ :start :end :wrappedAround | 
				buffer
					selectRangeInsert: start 
					bound: end ] ]
]

{ #category : #'actions search' }
NmNotePresenter >> searchText: aString [

	GtkRunLoop defer: [
		sourceView textBuffer searchContext searchText: aString ]
]

{ #category : #'accessing model' }
NmNotePresenter >> setModelBeforeInitialization: aNote [ 

	note := aNote
]

{ #category : #private }
NmNotePresenter >> styleScheme [

	^ self application styleScheme
]

{ #category : #private }
NmNotePresenter >> textChanged [
	| newText |
	
	newText := sourceView text.
	newText ifEmpty: [ ^ self ].

	[
		"I put this outside to leave the callback (then it does not interfere with the UI"
		self note contents: newText.
		self application notificationCenter notify: (NmNoteChangedNotification newNote: self note)
	] schedule

]

{ #category : #accessing }
NmNotePresenter >> themeChanged [

	GtkRunLoop defer: [ 
		sourceView textBuffer styleScheme: self styleScheme ]
]

{ #category : #events }
NmNotePresenter >> whenToggleNotePanelDo: aBlock [

	toggleNotePanelAction := aBlock
]
