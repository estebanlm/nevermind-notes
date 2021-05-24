Class {
	#name : #NmSearchTextPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'searchText'
	],
	#category : #'Nevermind-View-Utils'
}

{ #category : #activation }
NmSearchTextPresenter >> activate [

	self isVisible ifTrue: [ ^ self ].
	self show.
	self takeKeyboardFocus.	
	
	self model highlightSearchText: true
]

{ #category : #initialization }
NmSearchTextPresenter >> connectPresenters [ 

	searchText whenTextChangedDo: [ :aString | self search: aString ].
	forwardButton action: [ self searchForward ]
	
]

{ #category : #activation }
NmSearchTextPresenter >> dismiss [

	self isVisible ifFalse: [ ^ self ].
	self hide.
	
	self model highlightSearchText: false.
	self model takeKeyboardFocus
]

{ #category : #private }
NmSearchTextPresenter >> dismissIfNoPresenterHasFocus [

	(self presenters anySatisfy: [ :each | each hasKeyboardFocus ]) ifTrue: [ ^ self ].
	self dismiss
]

{ #category : #activation }
NmSearchTextPresenter >> dismissOnKeyCombination: aKeyCombination [

	self bindKeyCombination: aKeyCombination toAction: [ self dismiss ] 
]

{ #category : #activation }
NmSearchTextPresenter >> dismissOnLostFocus [

	self presentersDo: [ :each | 
		each eventHandler whenFocusLostDo: [ 
			self dismissIfNoPresenterHasFocus ] ]
]

{ #category : #initialization }
NmSearchTextPresenter >> initializePresenter [

	self layout: (SpBoxLayout newHorizontal
		borderWidth: 5;
		add: (searchText := self newSearchInput);
		add: (forwardButton := self newButton) expand: false;
		yourself).
		
	self dismissOnLostFocus.
	self dismissOnKeyCombination: $f meta | (KeyboardKey escape asKeyCombination). 
	self model 
		bindKeyCombination: $f meta 
		toAction: [ self toggleActivate ].
	
	forwardButton icon: (self application iconNamed: 'go-down-search').
]

{ #category : #'private actions' }
NmSearchTextPresenter >> search: aString [

	self model searchText: aString
]

{ #category : #'private actions' }
NmSearchTextPresenter >> searchForward [

	self model searchForward
]

{ #category : #activation }
NmSearchTextPresenter >> toggleActivate [

	self isVisible 
		ifTrue: [ self dismiss ]
		ifFalse: [ self activate ]
]
