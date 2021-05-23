Class {
	#name : #NmBaseInteractionPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#parentWindow => WeakSlot'
	],
	#category : #'Nevermind-View-Interaction'
}

{ #category : #accessing }
NmBaseInteractionPresenter class >> currentApplication [ 

	^ NmApplication current
]

{ #category : #'instance creation' }
NmBaseInteractionPresenter class >> new [

	^ self newApplication: NmApplication current
]

{ #category : #'instance creation' }
NmBaseInteractionPresenter class >> open [
	<script>
	
	^ self new openWithSpec
]

{ #category : #'instance creation' }
NmBaseInteractionPresenter class >> openDialog [
	<script>
	
	^ self new openDialogWithSpec
]

{ #category : #initialization }
NmBaseInteractionPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ]
]

{ #category : #initialization }
NmBaseInteractionPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: self title.

]

{ #category : #api }
NmBaseInteractionPresenter >> openDialogWithSpecParent: aWindow [ 
	
	parentWindow := aWindow.
	^ self openDialogWithSpec
]

{ #category : #accessing }
NmBaseInteractionPresenter >> parentWindow [

	^ parentWindow
]

{ #category : #initialization }
NmBaseInteractionPresenter >> title [

	^ 'NONAME'
]
