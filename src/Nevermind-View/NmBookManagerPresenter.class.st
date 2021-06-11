Class {
	#name : #NmBookManagerPresenter,
	#superclass : #NmPresenter,
	#instVars : [
		'bookList',
		'actionBar',
		'deleteButton',
		'openButton'
	],
	#category : #'Nevermind-View-Book'
}

{ #category : #initialization }
NmBookManagerPresenter >> addGlobalShortcutsTo: aWindowPresenter [

	aWindowPresenter contextKeyBindings: self bookListActions asKMCategory
]

{ #category : #initialization }
NmBookManagerPresenter >> bookListActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (NmActivateBookCommand forSpecContext: self);
		register: ((CmCommandGroup forSpecNamed: 'Editing')
			beDisplayedAsGroup;
			register: (NmAddBookCommand forSpecContext: self);
			register: (NmRenameBookCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup forSpecNamed: 'Critical')
			beDisplayedAsGroup;
			register: (NmRemoveBookCommand forSpecContext: self);
			yourself);
		yourself
]

{ #category : #initialization }
NmBookManagerPresenter >> bookListMenu [

	^ self bookListActions
		prepareForContextMenu;
		asMenuPresenter.
]

{ #category : #actions }
NmBookManagerPresenter >> doActivateSelectedBook [
	| book |

	book := bookList selectedItem.
	book ifNil: [ ^ self ].

	self application activateBook: book.
	
	self withWindowDo: [ :w | w close ]
]

{ #category : #actions }
NmBookManagerPresenter >> doAddBook [
	| dialog book |

	dialog := self application newRequest
		title: 'New Book';
		label: 'Book name';
		openDialogWithSpecParent: self window.
	dialog isOk ifFalse: [ ^ self ].
	
	book := NmBook newName: dialog presenter text trimmed.
	book save.
	
	self updatePresenter.
	bookList selectItem: book
]

{ #category : #actions }
NmBookManagerPresenter >> doRemoveSelectedBook [
	| dialog book |

	book := bookList selectedItem.
	book ifNil: [ ^ self ].

	dialog := self application newConfirm
		title: 'Remove Book';
		label: (('Remove book {1} and all its notes?
WARNING: You cannot undo this action!') format: { book name });
		acceptLabel: 'Remove';
		openDialogWithSpecParent: self window.
	dialog isOk ifFalse: [ ^ self ].
	
	book remove.
	self updatePresenter
]

{ #category : #actions }
NmBookManagerPresenter >> doRenameSelectedBook [
	| book newName |
	
	book := bookList selectedItem.
	book ifNil: [ ^ self ].

	newName := self application newRequest 
		title: 'Rename Book';
		label: ('Rename {1} to:' format: { book name });
		text: book name;
		acceptLabel: 'Rename';
		openModalWithSpecParent: self window.
		
	(newName isEmptyOrNil or: [ newName = book name ])
		ifTrue: [ ^ self ].
		
	book name: newName.
	book save.
	
	self updatePresenter.
	bookList selectItem: book.
	
	self notify: (NmBookRenamedNotification newBook: book)
]

{ #category : #initialization }
NmBookManagerPresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical
		add: (bookList := self newList);
		add: (actionBar := self newActionBar) expand: false;
		yourself).
		
	bookList 
		display: [ :aBook | aBook name ];
		contextMenu: [ self bookListMenu ].
	
	actionBar 
		add: (NmAddBookCommand forSpecContext: self) asActionButtonPresenter;
		add: (deleteButton := (NmRemoveBookCommand forSpecContext: self) asActionButtonPresenter);
		addLast: (openButton := (NmActivateBookCommand forSpecContext: self) asLabeledActionButtonPresenter).
			
	deleteButton enabled: false.
	openButton enabled: false.
	
	bookList transmitDo: [ :aBook | self updateButtonsFor: aBook ].
	bookList outputActivationPort transmitDo: [ self doActivateSelectedBook ]
]

{ #category : #initialization }
NmBookManagerPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Books...'
]

{ #category : #initialization }
NmBookManagerPresenter >> updateButtonsFor: aBook [

	deleteButton enabled: aBook notNil.
	openButton enabled: aBook notNil
]

{ #category : #initialization }
NmBookManagerPresenter >> updatePresenter [

	bookList items: (self applicationModel allBooks sorted: (#priority ascending, #name ascending))
]
