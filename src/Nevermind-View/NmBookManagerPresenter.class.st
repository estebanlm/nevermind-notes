Class {
	#name : #NmBookManagerPresenter,
	#superclass : #SgaPresenter,
	#instVars : [
		'bookList',
		'actionBar',
		'deleteButton',
		'openButton'
	],
	#category : #'Nevermind-View-Book'
}

{ #category : #accessing }
NmBookManagerPresenter >> applicationModel [

	^ self application model
]

{ #category : #initialization }
NmBookManagerPresenter >> bookListMenu [

	^ nil
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
]

{ #category : #actions }
NmBookManagerPresenter >> doRemoveSelectedBook [
]

{ #category : #actions }
NmBookManagerPresenter >> doRenameSelectedBook [
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
		add: (self newButton 
			icon: (self application buttonIconNamed: 'document-new');
			help: 'Create a new book.'
			yourself);
		add: ((deleteButton := self newButton) 
			icon: (self application buttonIconNamed: 'delete');
			help: 'Delete selected book.'
			yourself);
		addLast: ((openButton := self newButton) 
			icon: (self application buttonIconNamed: 'document-open');
			label: 'Open';
			help: 'Open selected book.'
			yourself).
			
	deleteButton enabled: false.
	openButton enabled: false.
	
	bookList transmitDo: [ :aBook | self updateButtonsFor: aBook ].

]

{ #category : #initialization }
NmBookManagerPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: 'Books...'
]

{ #category : #initialization }
NmBookManagerPresenter >> updateButtonsFor: aBook [

	deleteButton enabled: aBook notNil.
	openButton enabled: aBook notNil
]

{ #category : #initialization }
NmBookManagerPresenter >> updatePresenter [

	bookList items: self applicationModel allBooks
]
