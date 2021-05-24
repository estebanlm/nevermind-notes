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
		yourself).
		
	self dismissOnLostFocus.
	self dismissOnKeyCombination: $f meta | (KeyboardKey escape asKeyCombination). 
	self model 
		bindKeyCombination: $f meta 
		toAction: [ self toggleActivate ].
	
	searchText whenTextChangedDo: [ :aString | self search: aString ]

]

{ #category : #initialization }
NmSearchTextPresenter >> search: aString [

	self model searchText: aString
]

{ #category : #activation }
NmSearchTextPresenter >> toggleActivate [

	self isVisible 
		ifTrue: [ self dismiss ]
		ifFalse: [ self activate ]
]
