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
	self flag: #TODO. "Here also restore search"
]

{ #category : #activation }
NmSearchTextPresenter >> dismiss [

	self isVisible ifFalse: [ ^ self ].
	self hide.
	self owner takeKeyboardFocus
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
	self model bindKeyCombination: $f meta toAction: [ self toggleActivate ].

]

{ #category : #activation }
NmSearchTextPresenter >> toggleActivate [

	self isVisible 
		ifTrue: [ self dismiss ]
		ifFalse: [ self activate ]
]
