Class {
	#name : #NmSearchTextPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'searchText',
		'forwardButton',
		'backwardButton',
		'mouseInComponent'
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
	forwardButton action: [ self searchForward ].
	backwardButton action: [ self searchBackward ]
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

	searchText bindKeyCombination: aKeyCombination toAction: [ self dismiss ] 
]

{ #category : #activation }
NmSearchTextPresenter >> dismissOnLostFocus [

	self presentersDo: [ :each | 
		each eventHandler whenFocusLostDo: [ 
			self dismissIfNoPresenterHasFocus ] ]
]

{ #category : #initialization }
NmSearchTextPresenter >> initialize [

	mouseInComponent := true.
	super initialize
]

{ #category : #initialization }
NmSearchTextPresenter >> initializePresenter [

	self layout: (SpBoxLayout newHorizontal
		borderWidth: 5;
		add: (searchText := self newSearchInput);
		add: (forwardButton := self newButton) expand: false;
		add: (backwardButton := self newButton) expand: false;
		yourself).
	
	self eventHandler 
		whenMouseEnterDo: [ :event | 
			mouseInComponent := true ];
		whenMouseLeaveDo: [ :event |
			mouseInComponent := false. 
			self dismissIfNoPresenterHasFocus ].
	self dismissOnLostFocus.
	self dismissOnKeyCombination: Character escape asKeyCombination.
	self model 
		bindKeyCombination: $f meta 
		toAction: [ self toggleActivate ].
	
	self flag: #TODO. "Move to Spec"
	self whenBuiltDo: [  
		{ forwardButton. backwardButton } 
		do: [ :each | each adapter widget canFocus: false ] ].
	
	forwardButton icon: (self application iconNamed: 'go-down-search').
	backwardButton icon: (self application iconNamed: 'go-up-search')
]

{ #category : #'private actions' }
NmSearchTextPresenter >> search: aString [

	self model searchText: aString
]

{ #category : #'private actions' }
NmSearchTextPresenter >> searchBackward [

	self model searchBackward
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
