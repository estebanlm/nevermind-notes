Trait {
	#name : #SpTSchemeManager,
	#category : #'Notes-Spec'
}

{ #category : #'accessing - resources' }
SpTSchemeManager >> styleScheme [
	"Notes themes: 'notes-light', 'notes-dark'
	 Default themes: 'classic' 'cobalt' 'kate' 'oblivion' 'solarized-dark' 'solarized-light' 'tango'"

	^ GRunLoop defer: [ 
		self styleSchemeManager schemeWithId: (self configuration isDarkTheme 
			ifTrue: [ 'notes-dark' ]
			ifFalse: [ 'notes-light' ]) ]
]

{ #category : #'accessing - resources' }
SpTSchemeManager >> styleSchemeManager [ 

	^ self 
		propertyAt: #styleSchemeManager
		ifAbsentPut: [
			GRunLoop defer: [
				GtkSourceStyleSchemeManager new
					searchPaths: { (self configuration resourcesDirectory / 'data' / 'schemes') fullName };
					yourself ] ]
]
