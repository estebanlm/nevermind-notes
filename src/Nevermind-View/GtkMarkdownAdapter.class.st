Class {
	#name : #GtkMarkdownAdapter,
	#superclass : #GtkTextAdapter,
	#category : #'Nevermind-View-Spec'
}

{ #category : #adding }
GtkMarkdownAdapter >> addMarkdownFeaturesTo: gtkSourceView [
	
	gtkSourceView
		connectSizeAllocate: [ :aRect | self calculateMargin: aRect of: gtkSourceView ];
		tabWidth: 4;
		beWrapWord.

	self presenter whenStyleSchemeChangedDo: [ :newScheme | 
		gtkSourceView textBuffer styleScheme: newScheme ].

	gtkSourceView textBuffer: (GtkSourceBuffer new 
		language: (self presenter languageManager languageWithId: 'markdown');
		infiniteUndoLevels;
		styleScheme: self presenter styleScheme;
		yourself)
]

{ #category : #adding }
GtkMarkdownAdapter >> addModelTo: gtkTextView [ 

	self addMarkdownFeaturesTo: gtkTextView.	
	super addModelTo: gtkTextView
]

{ #category : #building }
GtkMarkdownAdapter >> bufferClass [

	^ GtkSourceBuffer
]

{ #category : #adding }
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

{ #category : #adding }
GtkMarkdownAdapter >> margin [

	^ self presenter margin
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

{ #category : #adding }
GtkMarkdownAdapter >> textWidth [

	^ self presenter textWidth
]

{ #category : #building }
GtkMarkdownAdapter >> widgetClass [

	^ GtkSourceView
]
