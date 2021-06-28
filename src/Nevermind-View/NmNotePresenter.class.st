Class {
	#name : #NmNotePresenter,
	#superclass : #SpPresenter,
	#traits : 'NmTApplication',
	#classTraits : 'NmTApplication classTrait',
	#instVars : [
		'note',
		'actionBar',
		'sourcePresenter',
		'notePanelVisible',
		'toggleNotePanelAction',
		'toggleNotePanelButton',
		'searchText',
		'searchPanel',
		'updating'
	],
	#category : #'Nevermind-View-Notebook'
}

{ #category : #'as yet unclassified' }
NmNotePresenter class >> languageNoneLabel [

	^ 'None'
]

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
	| export fileName |
	
	export := self application newFileChooser
		beSave;
		title: ('Export as...'); 
		acceptLabel: 'Export';
		overrideConfirmation: true;
		addChoice: 'Format' 
			options: #('pdf' 'odt' 'docx' 'epub' 'html') 
			selectedIndex: 1; 
		addBooleanChoice: 'Open exported document' default: true;
		currentName: self note fileName;
		openModalWithSpecParent: self window.

	export ifNil: [ ^ self ].
	
	fileName := (export fileReference withExtension: export choices first) fullName.	
	NmPandocExporter new 
		exportNote: self note 
		to: fileName
		format: export choices first.
		
	export choices second ifTrue: [ 
		NmDocumentOpener new open: fileName ]

]

{ #category : #actions }
NmNotePresenter >> doMoveNote [
	| book |

	book := self application newSelect 
		title: 'Move Note';
		label: ('Move {1} too...' format: { self note firstLine });
		items: ((self application model allBooks 
			reject: [ :each | each voyageId = self note bookId ])
			sorted: #name ascending);
		display: [ :aBook | aBook name ];
		openModalWithSpecParent: self window.
	book ifNil: [ ^ self ].
	
	self application 
		moveNote: note 
		toBook: book
]

{ #category : #actions }
NmNotePresenter >> doToggleNotePanel [

	toggleNotePanelAction ifNil: [ ^ self ].
	notePanelVisible := toggleNotePanelAction value
]

{ #category : #accessing }
NmNotePresenter >> fontSize [

	^ 'noteTextSize1'
]

{ #category : #'actions search' }
NmNotePresenter >> highlightSearchText: aBoolean [

	sourcePresenter highlightSearchText: aBoolean
]

{ #category : #initialization }
NmNotePresenter >> initialize [

	updating := false.
	notePanelVisible := true.
	super initialize
]

{ #category : #initialization }
NmNotePresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical
		add: (actionBar := self newActionBar) expand: false;
		add: (SpOverlayLayout new 
			child: (sourcePresenter := self instantiate: SpMarkdownPresenter);
			addOverlay: (searchPanel := self instantiate: NmSearchTextPresenter on: self) 
				withConstraints: [ :c | c vAlignStart; hAlignEnd ];
			yourself);
		yourself).

	sourcePresenter
		addStyle: 'noteText';
		addStyle: self fontSize; 
		languageManager: self application languageManager;
		styleScheme: self application styleScheme;
		textWidth: self application textWidth;
		margin: self application noteMargin;
		whenTextChangedDo: [ :aString | self textChanged: aString ];
		bindKeyCombination: $b control toAction: [ self doToggleNotePanel ];
		bindKeyCombination: $l control toAction: [ self showLanguageMenu ].
	
	"For some reason, hide just works fine once widget is built :("
	self whenBuiltDo: [ searchPanel hide. ].

	actionBar 
		add: (toggleNotePanelButton := (NmToggleNotePanelCommand forSpecContext: self) 
			asToggleButtonPresenter)	;
		addLast: (self newMenuButton 
			icon: (self application buttonIconNamed: 'gtk-spell-check');
			menu: [ self languagesMenu ];
			yourself);
		addLast: (NmExportNoteCommand forSpecContext: self) asActionButtonPresenter
]

{ #category : #initialization }
NmNotePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Note';
		initialExtent: self application defaultMainWindowExtent
]

{ #category : #initialization }
NmNotePresenter >> languagesMenu [
	| menu languagesAvailable |		
	
	languagesAvailable := GtkRunLoop defer: [ GspellLanguage available collect: #name ].
	menu := self newMenu.
	menu addItem: [ :item | 
		item 
			name: self class languageNoneLabel;
			icon: (self application iconNamed: ((self note language isNil) 
				ifTrue: [ 'checkbox-checked-symbolic' ]
				ifFalse: [ 'checkbox-symbolic' ]));
			action: [ self selectLanguage: nil ] ].
	menu addGroup: [ :group |
		languagesAvailable do: [ :each | 
				group addItem: [ :item | 
					item 
						name: each; 
						icon: (self application iconNamed: ((self note language = each) 
							ifTrue: [ 'checkbox-checked-symbolic' ]
							ifFalse: [ 'checkbox-symbolic' ]));
						action: [ self selectLanguage: each ] ] ] ].
	
	^ menu
	
]

{ #category : #private }
NmNotePresenter >> margin [

	^ self application noteMargin
]

{ #category : #accessing }
NmNotePresenter >> note [

	^ note
]

{ #category : #accessing }
NmNotePresenter >> note: aNote [

	note := aNote.
	self updatePresenter
]

{ #category : #'actions search' }
NmNotePresenter >> searchBackward [

	sourcePresenter searchBackward
]

{ #category : #'actions search' }
NmNotePresenter >> searchForward [

	sourcePresenter searchForward
]

{ #category : #'actions search' }
NmNotePresenter >> searchText: aString [

	sourcePresenter searchText: aString
]

{ #category : #private }
NmNotePresenter >> selectLanguage: aName [

	sourcePresenter spellLanguage = aName
		ifTrue: [ ^ self ].
		
	sourcePresenter spellLanguage: aName.
	self application schedule: [ note changeLanguageTo: aName ]
]

{ #category : #'accessing model' }
NmNotePresenter >> setModelBeforeInitialization: aNote [ 

	note := aNote
]

{ #category : #private }
NmNotePresenter >> showLanguageMenu [

	self languagesMenu openWithSpecAtPointer
]

{ #category : #private }
NmNotePresenter >> styleScheme [

	^ self application styleScheme
]

{ #category : #private }
NmNotePresenter >> textChanged: aString [

	updating ifTrue: [ ^ self ].
	aString ifEmpty: [ ^ self ].

	self application schedule: [
		"I put this outside to leave the callback (then it does not interfere with the UI"
		self note contents: aString.
		self notify: (NmNoteChangedNotification newNote: self note)
	]

]

{ #category : #accessing }
NmNotePresenter >> themeChanged [

	sourcePresenter styleScheme: self styleScheme
]

{ #category : #initialization }
NmNotePresenter >> updatePresenter [

	updating := true.
	
	note 
		ifNotNil: [ 
			sourcePresenter enabled: true.
			sourcePresenter text: note contents.
			sourcePresenter spellLanguage: note language ]
		ifNil: [ 
			sourcePresenter enabled: false. 
			sourcePresenter text: '' ].
		
	updating := false
]

{ #category : #events }
NmNotePresenter >> whenToggleNotePanelDo: aBlock [

	toggleNotePanelAction := aBlock
]
