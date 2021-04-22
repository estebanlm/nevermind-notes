Class {
	#name : #NmBookManagerPresenter,
	#superclass : #SgaPresenter,
	#instVars : [
		'bookList',
		'actionBar'
	],
	#category : #'Nevermind-View-Book'
}

{ #category : #initialization }
NmBookManagerPresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical
		add: (bookList := self newList);
		add: (actionBar := self newActionBar) expand: false;
		yourself).
		
	bookList display: [ :aBook | aBook name ]
]
