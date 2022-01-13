Class {
	#name : #NmNoteSummaryPresenter,
	#superclass : #SpPresenter,
	#traits : 'NmTApplication',
	#classTraits : 'NmTApplication classTrait',
	#instVars : [
		'note',
		'firstLineLabel',
		'timeLabel'
	],
	#category : #'Notes-View-Notebook'
}

{ #category : #accessing }
NmNoteSummaryPresenter >> contents [

	^ note contents
]

{ #category : #initialization }
NmNoteSummaryPresenter >> initializePresenters [

	layout := SpBoxLayout newVertical
		borderWidth: 1;
		spacing: 2;
		add: (firstLineLabel := self newLabel) expand: false;
		add: (timeLabel := self newLabel) expand: false;
		yourself.

	timeLabel addStyle: 'dim'
]

{ #category : #accessing }
NmNoteSummaryPresenter >> note [

	^ note
]

{ #category : #initialization }
NmNoteSummaryPresenter >> noteFirstLine [
		
	^ note firstLine
]

{ #category : #'accessing model' }
NmNoteSummaryPresenter >> setModelBeforeInitialization: aNote [

	note := aNote
]

{ #category : #initialization }
NmNoteSummaryPresenter >> updatePresenter [
	
	firstLineLabel label: self noteFirstLine.
	timeLabel label: note humanReadableLastEditionDate
]
