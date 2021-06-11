Class {
	#name : #SpMarkdownPresenter,
	#superclass : #SpTextPresenter,
	#instVars : [
		'#textWidth',
		'#margin',
		'#languageManager',
		'#styleScheme => ObservableSlot'
	],
	#category : #'Nevermind-View-Utils'
}

{ #category : #specs }
SpMarkdownPresenter class >> adapterName [

	^ #MarkdownAdapter
]

{ #category : #'actions search' }
SpMarkdownPresenter >> highlightSearchText: aBoolean [

	self withAdapterDo: [ :anAdapter | anAdapter highlightSearchText: aBoolean ]
]

{ #category : #accessing }
SpMarkdownPresenter >> languageManager [

	^ languageManager
]

{ #category : #accessing }
SpMarkdownPresenter >> languageManager: anObject [

	languageManager := anObject
]

{ #category : #accessing }
SpMarkdownPresenter >> margin [

	^ margin
]

{ #category : #accessing }
SpMarkdownPresenter >> margin: anObject [

	margin := anObject
]

{ #category : #'actions search' }
SpMarkdownPresenter >> searchBackward [

	self withAdapterDo: [ :anAdapter | anAdapter searchBackward ]
]

{ #category : #'actions search' }
SpMarkdownPresenter >> searchForward [

	self withAdapterDo: [ :anAdapter | anAdapter searchForward ]
]

{ #category : #'actions search' }
SpMarkdownPresenter >> searchText: aString [

	self withAdapterDo: [ :anAdapter | anAdapter searchText: aString ]
]

{ #category : #accessing }
SpMarkdownPresenter >> styleScheme [

	^ styleScheme
]

{ #category : #accessing }
SpMarkdownPresenter >> styleScheme: anObject [

	styleScheme := anObject
]

{ #category : #accessing }
SpMarkdownPresenter >> textWidth [

	^ textWidth
]

{ #category : #accessing }
SpMarkdownPresenter >> textWidth: anObject [

	textWidth := anObject
]

{ #category : #events }
SpMarkdownPresenter >> whenStyleSchemeChangedDo: aBlock [

	self property: #styleScheme whenChangedDo: aBlock
]
