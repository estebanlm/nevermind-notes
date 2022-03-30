Class {
	#name : #GtkMarkdownAdapter,
	#superclass : #GtkTextAdapter,
	#instVars : [
		'spellTextBuffer'
	],
	#category : #'Notes-Spec'
}

{ #category : #building }
GtkMarkdownAdapter >> addMarkdownFeaturesTo: gtkSourceView [
	
	gtkSourceView
		connectSizeAllocate: [ :aRect | self calculateMargin: aRect of: gtkSourceView ];
		tabWidth: 4;
		beWrapWord.

	self presenter whenStyleSchemeChangedDo: [ :newScheme | 
		gtkSourceView textBuffer styleScheme: newScheme ].

	gtkSourceView textBuffer: self newSourceBuffer.
		
	self presenter spellLanguage ifNotNil: [ :lang |
		self 
			addSpellCheckerTo: gtkSourceView 
			buffer: gtkSourceView textBuffer 
			language: lang ].
	self presenter whenSpellLanguageChangedDo: [ :newLanguage | 
		self innerWidgetDo: [ :w |
			self 
				addSpellCheckerTo: w 
				buffer: w textBuffer 
				language: newLanguage ] ]
]

{ #category : #building }
GtkMarkdownAdapter >> addModelTo: gtkTextView [ 

	self addMarkdownFeaturesTo: gtkTextView.	
	super addModelTo: gtkTextView
]

{ #category : #building }
GtkMarkdownAdapter >> addSpellCheckerTo: gtkWidget buffer: aTextBuffer language: aName [
	| language spellChecker |

	language := GspellLanguage languageNamed: aName.
	language ifNil: [ 
		self spellChecking: gtkWidget enable: false. 
		^ self ].

	self spellChecking: gtkWidget enable: true. 
	spellTextBuffer ifNil: [ spellTextBuffer := aTextBuffer spellTextBuffer ].
	spellChecker := spellTextBuffer spellChecker.
	spellChecker getHandle isNull 
		ifTrue: [ 
			spellTextBuffer spellChecker: ((GspellChecker newLanguage: language)
				connect: 'session-cleared' do: [ :w :d | 'OK' crTrace ];
				yourself ) ]
		ifFalse: [ spellChecker language: language ]
]

{ #category : #building }
GtkMarkdownAdapter >> bufferClass [

	^ GtkSourceBuffer
]

{ #category : #private }
GtkMarkdownAdapter >> calculateMargin: aRect of: aGtkSourceView [
	| w textWidth margin |
	
	w := aRect width.
	textWidth := self textWidth.
	margin := w > (textWidth + (self margin width))
		ifTrue: [ | border |
			border := ((w - textWidth) / 2) asInteger. 
			Margin 
				top: self margin top 
				left: border
				bottom: self margin bottom  
				right: border ]
		ifFalse: [ self margin ].
		
	aGtkSourceView
		topMargin: margin top;
		leftMargin: margin left;
		bottomMargin: margin bottom;
		rightMargin: margin right.
		

]

{ #category : #'actions search' }
GtkMarkdownAdapter >> highlightSearchText: aBoolean [ 

	self innerWidgetDo: [ :w |
		w textBuffer searchContext highlight: aBoolean ]
]

{ #category : #accessing }
GtkMarkdownAdapter >> margin [

	^ self presenter margin
]

{ #category : #building }
GtkMarkdownAdapter >> newSourceBuffer [
	
	^ self bufferClass new 
		language: (self presenter languageManager languageWithId: 'markdown');
		infiniteUndoLevels;
		styleScheme: self presenter styleScheme;
		yourself

]

{ #category : #'actions search' }
GtkMarkdownAdapter >> searchBackward [

	self innerWidgetDo: [ :w |
		| buffer |
		buffer := w textBuffer.
		buffer searchContext 
			backwardThenDo: [ :start :end :wrappedAround | 
				buffer
					selectRangeInsert: start 
					bound: end ] ]
]

{ #category : #'actions search' }
GtkMarkdownAdapter >> searchForward [

	self innerWidgetDo: [ :w |
		| buffer |
		buffer := w textBuffer.
		buffer searchContext 
			forwardThenDo: [ :start :end :wrappedAround | 
				buffer
					selectRangeInsert: start 
					bound: end ] ]
]

{ #category : #'actions search' }
GtkMarkdownAdapter >> searchText: aString [

	self innerWidgetDo: [ :w |
		w textBuffer searchContext searchText: aString ]
]

{ #category : #building }
GtkMarkdownAdapter >> spellChecking: gtkWidget enable: aBoolean [

	gtkWidget spellTextView 
		inlineSpellChecking: aBoolean";
		languageMenuEnabled: aBoolean".
	
]

{ #category : #accessing }
GtkMarkdownAdapter >> textWidth [

	^ self presenter textWidth
]

{ #category : #building }
GtkMarkdownAdapter >> widgetClass [

	^ GtkSourceView
]
