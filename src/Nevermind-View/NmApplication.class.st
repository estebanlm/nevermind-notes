Class {
	#name : #NmApplication,
	#superclass : #SgaApplication,
	#instVars : [
		'scheduler'
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

{ #category : #actions }
NmApplication >> activateBook: aBook [

	self model activeBook = aBook ifTrue: [ ^ self ].
	self model activateBook: aBook.
	self notify: (NmBookActivatedNotification newBook: aBook)
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

{ #category : #'accessing icons' }
NmApplication >> iconProvider [

	self error: 'Use directly #iconNamed:'
]

{ #category : #initialization }
NmApplication >> initialize [

	super initialize.
	self initializeBackend.
	self initializeModel.
	self initializeScheduler.
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

{ #category : #initialization }
NmApplication >> initializeScheduler [

	scheduler := TKTWorkerPool new.
	scheduler poolMaxSize: 5.
	scheduler start
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

{ #category : #'accessing icons' }
NmApplication >> menuIconNamed: aString [

	^ GtkRunLoop defer: [ GtkImage newIconForMenuNamed: aString ]
]

{ #category : #accessing }
NmApplication >> model [

	^ NmModelApplication current
]

{ #category : #actions }
NmApplication >> moveNote: aNote toBook: aBook [

	aNote book = aBook ifTrue: [ ^ self ].
  	aNote moveTo: aBook.
	self notify: (NmNoteMovedNotification newNote: aNote book: aBook)
]

{ #category : #'instance creation' }
NmApplication >> newConfirm [

	^ super newConfirm
		icon: nil"(self buttonIconNamed: 'gtk-dialog-question')";
		yourself
]

{ #category : #'instance creation' }
NmApplication >> newFileChooser [

	^ NmFileChooserDialog newApplication: self
]

{ #category : #'instance creation' }
NmApplication >> newInform [

	^ super newInform
		icon: nil"(self buttonIconNamed: 'gtk-dialog-info')";
		yourself
]

{ #category : #'instance creation' }
NmApplication >> newRequest [

	^ super newRequest
		icon: nil"(self buttonIconNamed: 'gtk-dialog-question')";
		yourself
]

{ #category : #'instance creation' }
NmApplication >> newRequestText [

	^ super newRequestText
		icon: nil"(self buttonIconNamed: 'gtk-dialog-question')";
		yourself
]

{ #category : #'accessing resources' }
NmApplication >> noteMargin [

	^ Margin 
		top: 20
		left: 40 
		bottom: 100 
		right: 40
]

{ #category : #actions }
NmApplication >> notify: aNotification [

	self notificationCenter notify: aNotification
]

{ #category : #running }
NmApplication >> run [

	Current := self.
	super run
]

{ #category : #schedulling }
NmApplication >> schedule: aBlock [

	scheduler schedule: aBlock
]

{ #category : #running }
NmApplication >> start [
	| window |

	window := (self new: NmNotebookPresenter) openWithSpec.
	standalone ifFalse: [ ^ self ].
	"Ensure exit when close"
	window whenClosedDo: [ Smalltalk exitSuccess ].
	"Kill unnecessary process that may be still there"
	MorphicUIManager uiProcess ifNotNil: #terminate.
	ProcessBrowser new processList
		detect: [ :each | each name = 'SDL2 Event loop' ]
		ifFound: [ :aProcess | aProcess terminate ]	
]

{ #category : #'accessing resources' }
NmApplication >> styleScheme [
	"Notes themes: 'notes-light', 'notes-dark'
	 Default themes: 'classic' 'cobalt' 'kate' 'oblivion' 'solarized-dark' 'solarized-light' 'tango'"

	^ GtkRunLoop defer: [ 
		self styleSchemeManager schemeWithId: (self configuration isDarkTheme 
			ifTrue: [ 'notes-dark' ]
			ifFalse: [ 'notes-light' ]) ]
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

{ #category : #'accessing resources' }
NmApplication >> textWidth [
	
	^ 700
]
