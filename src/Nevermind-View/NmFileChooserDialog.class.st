Class {
	#name : #NmFileChooserDialog,
	#superclass : #Object,
	#instVars : [
		'application',
		'type',
		'title',
		'acceptLabel',
		'cancelLabel',
		'choices',
		'currentName',
		'overrideConfirmation'
	],
	#pools : [
		'GtkFileChooserAction',
		'GtkResponseType'
	],
	#category : #'Nevermind-View-Utils'
}

{ #category : #accessing }
NmFileChooserDialog class >> defaultAcceptLabel [

	^ 'Accept'
]

{ #category : #accessing }
NmFileChooserDialog class >> defaultCancelLabel [

	^ 'Cancel'
]

{ #category : #accessing }
NmFileChooserDialog class >> defaultTitle [

	^ 'Open...'
]

{ #category : #examples }
NmFileChooserDialog class >> example [ 

	^ (self newApplication: (SpApplication new useBackend: #Gtk))
		beSave;
		title: 'Export as...'; 
		acceptLabel: 'Export';
		overrideConfirmation: true;
		addChoice: 'Format' 
			options: #('pdf' 'odt' 'docx' 'epub' 'html') 
			selectedIndex: 1; 
		addBooleanChoice: 'Open exported document' default: true;
		currentName: 'test';
		openModalWithSpec.

]

{ #category : #'instance creation' }
NmFileChooserDialog class >> newApplication: anApplication [

	^ self new 
		application: anApplication;
		yourself
]

{ #category : #accessing }
NmFileChooserDialog >> acceptLabel [

	^ acceptLabel
]

{ #category : #accessing }
NmFileChooserDialog >> acceptLabel: anObject [

	acceptLabel := anObject
]

{ #category : #accessing }
NmFileChooserDialog >> addBooleanChoice: aLabel [
	"a boolean choice"
	
	self addBooleanChoice: aLabel default: false
]

{ #category : #accessing }
NmFileChooserDialog >> addBooleanChoice: aLabel default: aBoolean [
	"a boolean choice"
	
	choices add: (NmFileChooserBooleanChoice new 
		label: aLabel;
		selected: aBoolean;
		yourself) 
]

{ #category : #accessing }
NmFileChooserDialog >> addChoice: aLabel options: optionsArray [

	^ self 
		addChoice: aLabel 
		options: optionsArray	
		selectedIndex: nil
	
	
]

{ #category : #accessing }
NmFileChooserDialog >> addChoice: aLabel options: optionsArray selectedIndex: index [

	choices add: (NmFileChooserOptionsChoice new 
		label: aLabel;
		options: optionsArray;
		selectedIndex: index;
		yourself)
]

{ #category : #accessing }
NmFileChooserDialog >> application [

	^ application
]

{ #category : #accessing }
NmFileChooserDialog >> application: anObject [

	application := anObject
]

{ #category : #accessing }
NmFileChooserDialog >> beSave [

	self type: GTK_FILE_CHOOSER_ACTION_SAVE
]

{ #category : #accessing }
NmFileChooserDialog >> cancelLabel [

	^ cancelLabel
]

{ #category : #accessing }
NmFileChooserDialog >> cancelLabel: anObject [

	cancelLabel := anObject
]

{ #category : #accessing }
NmFileChooserDialog >> choices [

	^ choices
]

{ #category : #accessing }
NmFileChooserDialog >> currentName [

	^ currentName
]

{ #category : #accessing }
NmFileChooserDialog >> currentName: anObject [

	currentName := anObject
]

{ #category : #private }
NmFileChooserDialog >> deferredRunWithSpecParent: aWindowPresenter [
	| choosenFile dialog result |

	dialog := GtkFileChooserDialog 
		newTitle: self title
		action: self type
		acceptLabel: self acceptLabel
		cancelLabel: self cancelLabel. 

	choices do: [ :aChoice | aChoice addTo: dialog ].
	dialog overrideConfirmation: self isOverrideConfirmation.
	self currentName ifNotNil: [ 
		dialog currentName: self currentName ].

	aWindowPresenter ifNotNil: [ 
		dialog transientTo: aWindowPresenter adapter widget ].
	dialog show.
	result := dialog run.
	result = GTK_RESPONSE_OK ifTrue: [ 
		choosenFile := NmFileChooserResult new 
			directory: dialog currentFolder;
			name: dialog currentName;
			choices: (choices collect: [ :each | each getFrom: dialog ]);
			yourself ].

	^ choosenFile
]

{ #category : #initialization }
NmFileChooserDialog >> initialize [

	super initialize.
	self type: GTK_FILE_CHOOSER_ACTION_OPEN.
	self title: self class defaultTitle.
	self acceptLabel: self class defaultAcceptLabel.
	self cancelLabel: self class defaultCancelLabel.
	overrideConfirmation := true.
	choices := OrderedCollection new: 1
]

{ #category : #testing }
NmFileChooserDialog >> isOverrideConfirmation [

	^ overrideConfirmation
]

{ #category : #'api - showing' }
NmFileChooserDialog >> openModalWithSpec [

	^ self openModalWithSpecParent: nil
]

{ #category : #'api - showing' }
NmFileChooserDialog >> openModalWithSpecParent: aWindowPresenter [

	^ GtkRunLoop defer: [ self deferredRunWithSpecParent: aWindowPresenter ]
]

{ #category : #accessing }
NmFileChooserDialog >> overrideConfirmation: anObject [

	overrideConfirmation := anObject
]

{ #category : #accessing }
NmFileChooserDialog >> title [

	^ title
]

{ #category : #accessing }
NmFileChooserDialog >> title: anObject [

	title := anObject
]

{ #category : #accessing }
NmFileChooserDialog >> type [

	^ type
]

{ #category : #private }
NmFileChooserDialog >> type: anObject [

	type := anObject
]
