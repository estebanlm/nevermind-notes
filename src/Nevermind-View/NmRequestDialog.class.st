Class {
	#name : #NmRequestDialog,
	#superclass : #NmBaseInteractionPresenter,
	#instVars : [
		'label',
		'textInput',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel'
	],
	#category : #'Nevermind-View-Interaction'
}

{ #category : #accessing }
NmRequestDialog class >> defaultAcceptLabel [

	^ 'Accept'
]

{ #category : #accessing }
NmRequestDialog class >> defaultCancelLabel [

	^ 'Cancel'
]

{ #category : #accessing }
NmRequestDialog class >> defaultExtent [

	^ 400@100
]

{ #category : #specs }
NmRequestDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #textInput expand: false;
		yourself
]

{ #category : #accessing }
NmRequestDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
NmRequestDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
NmRequestDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #accessing }
NmRequestDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #accessing }
NmRequestDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
NmRequestDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
NmRequestDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: self acceptLabel do: [ :presenter | presenter beOk; close ]
		
]

{ #category : #initialization }
NmRequestDialog >> initializePresenters [

	label := self newLabel.
	textInput := self newTextInput
]

{ #category : #initialization }
NmRequestDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ textInput takeKeyboardFocus ]
]

{ #category : #accessing }
NmRequestDialog >> label: aString [

	label label: aString
]

{ #category : #accessing }
NmRequestDialog >> text [ 
	
	^ textInput text trimmed
]

{ #category : #accessing }
NmRequestDialog >> text: aString [

	textInput text: aString
]

{ #category : #accessing }
NmRequestDialog >> title [

	^ title
]

{ #category : #accessing }
NmRequestDialog >> title: aString [

	title := aString
]
