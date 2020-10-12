Class {
	#name : #NmPresenter,
	#superclass : #SpPresenter,
	#category : #'Nevermind-View-Application'
}

{ #category : #initialization }
NmPresenter >> initializeWindow: aWindowPresenter [

	self traversePresentersDo: [ :each |
		each addGlobalShortcutsTo: aWindowPresenter ]
]
