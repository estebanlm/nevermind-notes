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

	^ CrApplication current
]

{ #category : #'instance creation' }
NmBaseInteractionPresenter class >> new [

	^ self newApplication: CrApplication current
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

	aWindowPresenter title: self title.
	self traversePresentersDo: [ :each |
		each addGlobalShortcutsTo: aWindowPresenter ]
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
