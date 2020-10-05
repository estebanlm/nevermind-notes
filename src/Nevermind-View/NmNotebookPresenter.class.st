Class {
	#name : #NmNotebookPresenter,
	#superclass : #StPresenter,
	#instVars : [
		'noteList',
		'noteContent',
		'noteListHeader',
		'noteActionBar'
	],
	#category : #'Nevermind-View-Notebook'
}

{ #category : #accessing }
NmNotebookPresenter class >> defaultExtent [

	^ 900@750
]

{ #category : #specs }
NmNotebookPresenter class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		position: 30 percent;
		add: (SpBoxLayout newVertical
			add: #noteActionBar expand: false;
			add: #noteList;
			yourself);
		add: #noteContent;
		yourself
]

{ #category : #accessing }
NmNotebookPresenter class >> defaultTitle [

	^ 'Notes'
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

{ #category : #actions }
NmNotebookPresenter >> doAddNote [
	
	NmNote new save.
	self updatePresenter.
	noteList selectFirst
]

{ #category : #actions }
NmNotebookPresenter >> doRemoveSelected [
	
	self selectedNote remove.
	self updatePresenter
]

{ #category : #testing }
NmNotebookPresenter >> hasSelectedNote [

	^ self selectedNote notNil
]

{ #category : #initialization }
NmNotebookPresenter >> initialize [

	super initialize.
	self initializeSubscribers
]

{ #category : #initialization }
NmNotebookPresenter >> initializePresenters [

	noteActionBar := self newActionBar
		add: (self newButton
			icon: (self application buttonIconNamed: 'edit-find');
			action: [ self doFindNote ];
			yourself);
		add: (self newButton
			icon: (self application buttonIconNamed: 'document-new');
			action: [ self doAddNote ];
			yourself);
		yourself.
	noteList := self newComponentList
		contextMenu: [ self noteListMenu ];
		contextKeyBindings: self noteListKeyBindings;
		yourself.
		
	noteContent := self newPresenterSelector
			when: [ :aNote | aNote notNil ] show: [ :aNote | 
				self instantiate: NmNotePresenter on: aNote ];
			when: [ :aNote | aNote isNil ] show: [ 
				noteList items
					ifNotEmpty: [ self class unselectedMessage asPresenter ]
					ifEmpty: [ self class emptyMessage asPresenter ] ];
			yourself.
	
	noteList 
		transmitTo: noteContent 
		transform: [ :aPresenter | aPresenter ifNotNil: #note ]
]

{ #category : #initialization }
NmNotebookPresenter >> initializeSubscribers [

	self application notificationCenter 
		subscribe: self to: NmNoteChangedNotification
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
NmNotebookPresenter >> noteListActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: ((CmCommandGroup named: 'Critical') asSpecGroup
			beDisplayedAsGroup;
			register: (NmRemoveNoteCommand forSpecContext: self);
			yourself);
		"register: ((CmCommandGroup named: 'Pomodoro') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoTaskStartPomodoroCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup named: 'Management') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoViewArchivedCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup named: 'Critical') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoArchiveCompletedCommand forSpecContext: self);
			register: (CrTodoTaskArchiveCommand forSpecContext: self);
			register: (CrTodoTaskDeleteCommand forSpecContext: self);
			yourself);"
		yourself
]

{ #category : #initialization }
NmNotebookPresenter >> noteListKeyBindings [
		
	^ self noteListActions asKMCategory
]

{ #category : #initialization }
NmNotebookPresenter >> noteListMenu [
		
	^ self noteListActions asMenuPresenter
]

{ #category : #'notification handling' }
NmNotebookPresenter >> noteNoteChanged: aNotification [

	noteList presenters 
		detect: [ :each | each note = aNotification note ]
		ifFound: [ :aPresenter | aPresenter updatePresenter ]

]

{ #category : #accessing }
NmNotebookPresenter >> notes [
	
	^ NmNote findAllSortByEditionDate
]

{ #category : #private }
NmNotebookPresenter >> notesAsPresenters [

	^ self notes collect: [ :each | 
		self 
			instantiate: NmNoteSummaryPresenter
			on: each  ]
]

{ #category : #accessing }
NmNotebookPresenter >> selectedNote [

	^ noteList selectedItem ifNotNil: #note
]

{ #category : #initialization }
NmNotebookPresenter >> updatePresenter [

	noteList presenters: self notesAsPresenters
]
