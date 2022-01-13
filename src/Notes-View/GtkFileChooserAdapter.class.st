Class {
	#name : #GtkFileChooserAdapter,
	#superclass : #GtkDialogWindowAdapter,
	#pools : [
		'GtkFileChooserAction',
		'GtkResponseType'
	],
	#category : #'Notes-View-Spec'
}

{ #category : #adding }
GtkFileChooserAdapter >> addModelTo: gtkWidget [

	gtkWidget overrideConfirmation: self presenter isOverrideConfirmation
]

{ #category : #accessing }
GtkFileChooserAdapter >> currentName [

	^ self innerWidgetDo: [ :w | w currentName ]
]

{ #category : #accessing }
GtkFileChooserAdapter >> currentName: aString [

	self innerWidgetDo: [ :w | w currentName: aString ]
]

{ #category : #'instance creation' }
GtkFileChooserAdapter >> newWidget [

	^ (self widgetClass 
		newTitle: (self presenter title ifNil: [ 'Untitled' ])
		action: GTK_FILE_CHOOSER_ACTION_SAVE 
		acceptLabel: (self presenter acceptLabel ifNil: [ 'Accept' ])
		cancelLabel: (self presenter cancelLabel ifNil: [  'Cancel' ]))
		initialize
]

{ #category : #building }
GtkFileChooserAdapter >> widgetClass [

	^ GtkFileChooserDialog
]
