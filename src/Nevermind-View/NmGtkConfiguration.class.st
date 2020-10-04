Class {
	#name : #NmGtkConfiguration,
	#superclass : #SpGtkConfiguration,
	#instVars : [
		'iconProvider'
	],
	#category : #'Nevermind-View-Application'
}

{ #category : #'accessing style' }
NmGtkConfiguration >> commonStyle [

	^ '
.dim { color: LightSlateGrey }
.title { font-weight: bold }
.titleShortcut { color: LightSlateGrey }
.list { padding: 5px }
.listNameLabel { color: LightSlateGrey; margin-top: 3px; margin-bottom: 3px }
.mark { margin-right: 3px }
.pomodoroSurpassedTime { color: red }
'
]

{ #category : #configuring }
NmGtkConfiguration >> configureOSX: anApplication [

	self ensureAppearance: self macAppearanceName. 
	self installTheme: self macThemeName.
	self addCSSProviderFromString: self commonStyle.
	self addCSSProviderFromString: self macStyle
]

{ #category : #configuring }
NmGtkConfiguration >> configureUnix: anApplication [

	self unixThemeName 
		ifNotNil: [ :aName | self installTheme: aName ].
	self addCSSProviderFromString: self commonStyle.
	self addCSSProviderFromString: self unixStyle
]

{ #category : #configuring }
NmGtkConfiguration >> configureWindows: anApplication [

	self installTheme: self windowsThemeName.
	self addCSSProviderFromString: self commonStyle.
	self addCSSProviderFromString: self windowsStyle
]

{ #category : #configuring }
NmGtkConfiguration >> ensureAppearance: aName [

	"MpSettings ensureAppearance: aName"
]

{ #category : #accessing }
NmGtkConfiguration >> iconProvider [

	^ iconProvider ifNil: [ 
		iconProvider := NmIconProvider new
			addLocation: self iconsDirectory;
			addLocation: self themeIconsDirectory;
			yourself ] 
]

{ #category : #'accessing resources' }
NmGtkConfiguration >> iconsDirectory [

	^ self model paths iconsDirectory
]

{ #category : #accessing }
NmGtkConfiguration >> macAppearanceName [

	^ 'NSAppearanceNameAqua'
]

{ #category : #'accessing style' }
NmGtkConfiguration >> macStyle [

	^ '
.cronoText { font: 12pt "Monaco" }
.pomodoroTime { font: 32pt "Monaco" }
'
]

{ #category : #accessing }
NmGtkConfiguration >> macThemeName [
		
	^ 'Mojave-light'
]

{ #category : #accessing }
NmGtkConfiguration >> model [

	^ CrModelApplication current
]

{ #category : #'accessing resources' }
NmGtkConfiguration >> resourcesDirectory [

	^ self model paths resourcesDirectory
]

{ #category : #'accessing resources' }
NmGtkConfiguration >> themeIconsDirectory [

	^ self iconsDirectory / 'light'
]

{ #category : #'accessing style' }
NmGtkConfiguration >> unixStyle [

	^ '
.cronoText { font: 11pt "Monospace Regular" }
.pomodoroTime { font: 32pt "Monospace Regular" }
'
]

{ #category : #accessing }
NmGtkConfiguration >> unixThemeName [

	^ nil
]

{ #category : #'accessing style' }
NmGtkConfiguration >> windowsStyle [

	^ '
.cronoText { font: 10pt "Microsoft Sans Serif" }
.pomodoroTime { font: 32pt "Microsoft Sans Serif" }
'
]

{ #category : #accessing }
NmGtkConfiguration >> windowsThemeName [

	^ 'Windows-10-master'
]
