Class {
	#name : #NmConfirmDialog,
	#superclass : #NmBaseInteractionPresenter,
	#instVars : [
		'label',
		'image',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel'
	],
	#category : #'Nevermind-View-Interaction'
}

{ #category : #accessing }
NmConfirmDialog class >> defaultAcceptLabel [

	^ 'Yes'
]

{ #category : #accessing }
NmConfirmDialog class >> defaultCancelLabel [

	^ 'No'
]

{ #category : #accessing }
NmConfirmDialog class >> defaultExtent [

	^ 400@100
]

{ #category : #specs }
NmConfirmDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: (SpBoxLayout newHorizontal
			spacing: 5;
			add: #image expand: false;
			add: #label;
			yourself);
		yourself
]

{ #category : #accessing }
NmConfirmDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
NmConfirmDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
NmConfirmDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #accessing }
NmConfirmDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #accessing }
NmConfirmDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
NmConfirmDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
NmConfirmDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: self acceptLabel do: [ :presenter | presenter beOk; close ]
		
]

{ #category : #initialization }
NmConfirmDialog >> initializePresenters [

	image := self newImage.
	label := self newLabel.
	
]

{ #category : #initialization }
NmConfirmDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent
]

{ #category : #accessing }
NmConfirmDialog >> label: aString [

	label label: aString
]

{ #category : #accessing }
NmConfirmDialog >> title [

	^ title
]

{ #category : #accessing }
NmConfirmDialog >> title: aString [

	title := aString
]
