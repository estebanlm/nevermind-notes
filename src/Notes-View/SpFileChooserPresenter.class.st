Class {
	#name : #SpFileChooserPresenter,
	#superclass : #SpSystemDialogPresenter,
	#instVars : [
		'title',
		'acceptLabel',
		'cancelLabel',
		'overrideConfirmation'
	],
	#category : #'Notes-View-Spec'
}

{ #category : #specs }
SpFileChooserPresenter class >> adapterName [

	^ #FileChooserAdapter
]

{ #category : #accessing }
SpFileChooserPresenter >> acceptLabel [

	^ acceptLabel
]

{ #category : #accessing }
SpFileChooserPresenter >> acceptLabel: anObject [

	acceptLabel := anObject
]

{ #category : #accessing }
SpFileChooserPresenter >> cancelLabel [

	^ cancelLabel
]

{ #category : #accessing }
SpFileChooserPresenter >> cancelLabel: anObject [

	cancelLabel := anObject
]

{ #category : #accessing }
SpFileChooserPresenter >> currentName [

	^ self withAdapterDo: [ :anAdapter | anAdapter currentName ].

]

{ #category : #accessing }
SpFileChooserPresenter >> currentName: aString [

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter currentName: aString ]
]

{ #category : #initialization }
SpFileChooserPresenter >> initialize [

	super initialize.
	self overrideConfirmation: false 
]

{ #category : #testing }
SpFileChooserPresenter >> isOverrideConfirmation [

	^ overrideConfirmation	
]

{ #category : #accessing }
SpFileChooserPresenter >> overrideConfirmation: aBoolean [

	overrideConfirmation := aBoolean
]

{ #category : #accessing }
SpFileChooserPresenter >> title [

	^ title
]

{ #category : #accessing }
SpFileChooserPresenter >> title: anObject [

	title := anObject
]
