Class {
	#name : #NmNotebookPresenter,
	#superclass : #NmPresenter,
	#instVars : [
		'noteList',
		'noteContent',
		'noteListHeader',
		'noteActionBar',
		'updatingListFromNotification',
		'notePanel'
	],
	#category : #'Notes-View-Notebook'
}

{ #category : #accessing }
NmNotebookPresenter class >> defaultExtent [

	^ 900@750
]

{ #category : #accessing }
NmNotebookPresenter class >> defaultTitle [

	^ NmApplication applicationName
]

{ #category : #accessing }
NmNotebookPresenter class >> emptyMessage [

	"^ 'There are no notes to list.'"
	^ ''
]

{ #category : #accessing }
NmNotebookPresenter class >> unselectedMessage [

	"^ 'Select a note to edit it.'"
	^ ''
]

{ #category : #private }
NmNotebookPresenter >> activateNote: aNotePresenter [
	
	aNotePresenter ifNil: [ ^ self ].
	noteContent takeKeyboardFocus
]

{ #category : #initialization }
NmNotebookPresenter >> addGlobalShortcutsTo: aWindowPresenter [

	aWindowPresenter 
		bindKeyCombination: NmShowShortcutsCommand defaultShortcut 
			toAction: [ (NmShowShortcutsCommand forContext: self) execute ];		
		bindKeyCombination: NmOpenBookCommand defaultShortcut 
			toAction: [ (NmOpenBookCommand forContext: self) execute ];		
		bindKeyCombination: NmAddNoteCommand defaultShortcut 
			toAction: [ (NmAddNoteCommand forContext: self) execute ];
		bindKeyCombination: NmMoveNoteCommand defaultShortcut 
			toAction: [ (NmMoveNoteCommand forContext: self) execute ]
]

{ #category : #accessing }
NmNotebookPresenter >> applicationModel [

	^ self application  model
]

{ #category : #'api-focus' }
NmNotebookPresenter >> defaultKeyboardFocus [

	^ noteList
]

{ #category : #actions }
NmNotebookPresenter >> doAddNote [
	
	self applicationModel activeBook addNote: NmNote new.
	self updatePresenter.
	noteList selectFirst.
	noteContent takeKeyboardFocus
]

{ #category : #actions }
NmNotebookPresenter >> doMoveNote [
	
	noteContent showingPresenter doMoveNote
]

{ #category : #actions }
NmNotebookPresenter >> doOpenBook [
	
	(NmBookManagerPresenter newApplication: self application)
		openModalWithParent: self window
]

{ #category : #actions }
NmNotebookPresenter >> doOpenPlayground [
	"| app |
	
	app := self application 
		propertyAt: #pharo
		ifAbsentPut: [ StPharoApplication new useGtk ].
	(StPlayground newApplication: app) openWithSpec"
]

{ #category : #actions }
NmNotebookPresenter >> doRemoveSelected [
	| ok selectedNote |
	
	selectedNote := self selectedNote.
	selectedNote ifNil: [ ^ self ].

	ok := self application newConfirm 
		title: 'Delete Note';
		label: ('You are about to delete "{1}".' format: { selectedNote firstLine });
		acceptLabel: 'Delete';
		openModalWithParent: self window.
	ok ifFalse: [ ^ self ].
	
	self selectedNote remove.
	self updatePresenter
]

{ #category : #actions }
NmNotebookPresenter >> doShowShortcuts [
	
	NmShorcutsDialog new 
		parentWindow: self window;
		open
]

{ #category : #testing }
NmNotebookPresenter >> hasSelectedNote [

	^ self selectedNote notNil
]

{ #category : #initialization }
NmNotebookPresenter >> initialize [

	updatingListFromNotification := false.
	super initialize.
	self initializeSubscribers
]

{ #category : #initialization }
NmNotebookPresenter >> initializePresenters [

	self layout: (SpPanedLayout newHorizontal
		positionOfSlider: 30 percent;
		add: (notePanel := self newPresenter 
			layout: (SpBoxLayout newVertical
				add: (noteActionBar := self newActionBar) expand: false;
				add: (noteList := self newComponentList);
				yourself);
			yourself);
		add: (noteContent := self newPresenterSelector);
		yourself).

	noteActionBar	
		"add: (self newButton
			icon: (self application buttonIconNamed: 'edit-find');
			action: [ self doFindNote ];
			yourself);"
		add: (NmOpenBookCommand forSpecContext: self) asActionButtonPresenter;
		add: (NmAddNoteCommand forSpecContext: self) asActionButtonPresenter";
		add: (NmOpenPlaygroundCommand forSpecContext: self) asActionButtonPresenter".
		
	noteList
		contextMenu: [ self noteListMenu ];
		contextKeyBindings: self noteListKeyBindings;
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | self activateNote: selection selectedItem ].
			
	noteContent
		when: [ :aNote | aNote notNil ] show: [ :aNote | self newNotePresenter: aNote ];
		when: [ :aNote | aNote isNil ] show: [ self newEmptyMesssage ].
	
	noteList 
		transmitDo: [ :aNote | self updateNote: aNote ] 
		transform: [ :aPresenter | aPresenter ifNotNil: #note ]
]

{ #category : #initialization }
NmNotebookPresenter >> initializeSubscribers [

	self notificationCenter
		subscribe: self to: NmThemeChanged;
		subscribe: self to: NmBookActivatedNotification; 
		subscribe: self to: NmNoteChangedNotification;
		subscribe: self to: NmNoteMovedNotification
]

{ #category : #initialization }
NmNotebookPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		title: self class defaultTitle;
		initialExtent: self class defaultExtent;
		whenOpenedDo: [ noteList takeKeyboardFocus ]
]

{ #category : #initialization }
NmNotebookPresenter >> newEmptyMesssage [

	^ noteList items
		ifNotEmpty: [ self class unselectedMessage asPresenter ]
		ifEmpty: [ self class emptyMessage asPresenter ]
]

{ #category : #initialization }
NmNotebookPresenter >> newNotePresenter: aNote [

	^ (self instantiate: NmNotePresenter on: aNote)
		whenToggleNotePanelDo: [ 
			notePanel isVisible 
				ifTrue: [ notePanel hide ]
				ifFalse: [ notePanel show ].
			notePanel isVisible ];
		yourself
]

{ #category : #'notification handling' }
NmNotebookPresenter >> noteBookActivated: aNotification [

	notePanel show.
	self updatePresenter.
	noteList items ifNotEmpty: [ 
		noteList selectFirst.
		noteContent takeKeyboardFocus]
]

{ #category : #initialization }
NmNotebookPresenter >> noteListActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (NmMoveNoteCommand forSpecContext: self);
		register: ((CmCommandGroup named: 'Critical') asSpecGroup
			beDisplayedAsGroup;
			register: (NmRemoveNoteCommand forSpecContext: self);
			yourself);
		yourself
]

{ #category : #initialization }
NmNotebookPresenter >> noteListKeyBindings [
		
	^ self noteListActions asKMCategory
]

{ #category : #initialization }
NmNotebookPresenter >> noteListMenu [
		
	^ self noteListActions 
		prepareForContextMenu;
		asMenuPresenter
]

{ #category : #'notification handling' }
NmNotebookPresenter >> noteNoteChanged: aNotification [

	"Veerify I need a resort"
	noteList selection selectedIndex = 1 
		ifFalse: [ 
			self updateNoteListFromNoteChanged: aNotification note.
			^ self ].	

	noteList presenters 
		detect: [ :each | each note = aNotification note ]
		ifFound: [ :aPresenter | aPresenter updatePresenter ]
]

{ #category : #'notification handling' }
NmNotebookPresenter >> noteNoteMoved: aNotification [

	aNotification book = self applicationModel activeBook 
		ifFalse: [ self application activateBook: aNotification book ].
	self updateNoteListFromNoteChanged: aNotification note
]

{ #category : #'notification handling' }
NmNotebookPresenter >> noteThemeChanged: aNotification [

	noteContent showingPresenter themeChanged
]

{ #category : #accessing }
NmNotebookPresenter >> notes [
	
	^ self applicationModel activeBook notesSortedByEditionDate
]

{ #category : #private }
NmNotebookPresenter >> notesAsPresenters [

	^ self notes collect: [ :each | 
		self 
			instantiate: NmNoteSummaryPresenter
			on: each  ]
]

{ #category : #accessing }
NmNotebookPresenter >> selectNote: aNote [

	noteList presenters 
		detect: [ :each | each note = aNote ]
		ifFound: [ :aPresenter | 
			noteList selectItem: aPresenter ]
]

{ #category : #accessing }
NmNotebookPresenter >> selectedNote [

	^ noteList selectedItem ifNotNil: #note
]

{ #category : #private }
NmNotebookPresenter >> updateNote: aNote [ 

	updatingListFromNotification ifTrue: [ ^ self ].
	noteContent setModel: aNote
]

{ #category : #private }
NmNotebookPresenter >> updateNoteListFromNoteChanged: aNote [

	updatingListFromNotification := true.
	[ 
		self updatePresenter.
		self selectNote: aNote ]
	ensure: [
		updatingListFromNotification := false ].
]

{ #category : #initialization }
NmNotebookPresenter >> updatePresenter [

	noteList presenters: self notesAsPresenters
]
