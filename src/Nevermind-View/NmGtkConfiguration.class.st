Class {
	#name : #NmGtkConfiguration,
	#superclass : #SpGtkConfiguration,
	#instVars : [
		'iconProvider',
		'darkTheme',
		'settings'
	],
	#category : #'Nevermind-View-Application'
}

{ #category : #'accessing style' }
NmGtkConfiguration >> commonStyle [

	^ '
.dim { color: LightSlateGrey }
.note { color: #000000 }
'
]

{ #category : #configuring }
NmGtkConfiguration >> configureGeneral: anApplication [

	self addCSSProviderFromReference: self resourcesDirectory / 'data' / 'styles' / 'general.css'.
	GtkRunLoop defer: [ 
		settings := GtkSettings default.
		settings connectThemeChanged: [ :set :spec :app |
			darkTheme := nil.
			anApplication notificationCenter notify: NmThemeChanged new ] ]
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

{ #category : #private }
NmGtkConfiguration >> detectDarkTheme [
	| backgroundColor |

	"Taking the background color of a GtkTextView is a hack to determine if we are in presence of a 
	 dark or light theme"
	backgroundColor := GtkRunLoop defer: [ 
		| widget |
		widget := GtkTextView new. 
		widget markForAutoRelease. 
		widget styleContext getBackgroundColor ].
	
	^ backgroundColor luminance < 0.5
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

{ #category : #testing }
NmGtkConfiguration >> isDarkTheme [

	^ darkTheme ifNil: [ darkTheme := self detectDarkTheme ]
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

	^ NmModelApplication current
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
