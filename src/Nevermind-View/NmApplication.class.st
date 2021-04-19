Class {
	#name : #NmApplication,
	#superclass : #SpApplication,
	#instVars : [
		'notificationCenter',
		'standalone'
	],
	#classVars : [
		'Current'
	],
	#classInstVars : [
		'session'
	],
	#category : #'Nevermind-View-Application'
}

{ #category : #activation }
NmApplication class >> applicationName [

	^ 'Nevermind Notes'
]

{ #category : #accessing }
NmApplication class >> current [

	self validateSession.
	^ Current ifNil: [ Current := self new ]
]

{ #category : #initialization }
NmApplication class >> reset [
	<script>

	Current ifNil: [ ^ self ].
	Current emergencyShutdown.
	Current := nil
]

{ #category : #private }
NmApplication class >> validateSession [
	
	session == Smalltalk session ifTrue: [ ^ self ].
	Current := nil.
	session := Smalltalk session
]

{ #category : #'accessing icons' }
NmApplication >> buttonIconNamed: aString [

	^ GtkRunLoop defer: [ GtkImage newIconForButtonNamed: aString ]
]

{ #category : #accessing }
NmApplication >> defaultMainWindowExtent [

	self flag: #TODO. "Take from configuration".
	^ 800@800
]

{ #category : #'accessing icons' }
NmApplication >> iconNamed: aString [

	^ self buttonIconNamed: aString
]

{ #category : #initialization }
NmApplication >> initialize [

	super initialize.
	self initializeBackend.
	self initializeModel
]

{ #category : #initialization }
NmApplication >> initializeBackend [
	| gtk |

	"Ensure the name of the application"
	self isStandalone ifTrue: [ 
		gtk := GtkApplication new initGtk3.
		GLibLibrary uniqueInstance gSetPrgName: self class applicationName.
		gtk run ].
	
	self useBackend: #Gtk with: NmGtkConfiguration new
]

{ #category : #initialization }
NmApplication >> initializeModel [
	
	NmModelApplication reset
]

{ #category : #testing }
NmApplication >> isStandalone [

	^ standalone ifNil: [ standalone := false ]
]

{ #category : #'accessing resources' }
NmApplication >> languageManager [ 
		
	^ self 
		propertyAt: #languageManager
		ifAbsentPut: [
			GtkRunLoop defer: [  
				GtkSourceLanguageManager default
				"GtkSourceLanguageManager new
					searchPaths: { (FileLocator imageDirectory /'thiefmd' / 'data' / 'language-specs') fullName };
					yourself" ] ]
]

{ #category : #'accessing resources' }
NmApplication >> languageMarkdown [

	^ self languageManager languageWithId: 'markdown' 
]

{ #category : #'accessing icons' }
NmApplication >> menuIconNamed: aString [

	^ GtkRunLoop defer: [ GtkImage newIconForMenuNamed: aString ]
]

{ #category : #accessing }
NmApplication >> notificationCenter [

	^ notificationCenter ifNil: [ 
		notificationCenter := NmNotificationCenter new ]
]

{ #category : #initialization }
NmApplication >> prepareAsStandaloneApplication [
	
	MorphicUIManager uiProcess ifNotNil: #terminate.
	standalone := true
]

{ #category : #running }
NmApplication >> run [

	Current := self.
	super run
]

{ #category : #running }
NmApplication >> start [
	| window |

	window := (self new: NmNotebookPresenter) openWithSpec.
	standalone ifTrue: [ 
		window whenClosedDo: [
			Smalltalk exitSuccess ] ]
]

{ #category : #'accessing resources' }
NmApplication >> styleScheme [
	"Notes themes: 'notes-light', 'notes-dark'
	 Default themes: 'classic' 'cobalt' 'kate' 'oblivion' 'solarized-dark' 'solarized-light' 'tango'"

	^ self styleSchemeManager schemeWithId: 'notes-dark'
]

{ #category : #'accessing resources' }
NmApplication >> styleSchemeManager [ 

	^ self 
		propertyAt: #styleSchemeManager
		ifAbsentPut: [
			GtkRunLoop defer: [
				GtkSourceStyleSchemeManager new
					searchPaths: { (self configuration resourcesDirectory / 'data' / 'schemes') fullName };
					yourself ] ]
]
