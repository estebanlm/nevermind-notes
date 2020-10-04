Class {
	#name : #NmIconProvider,
	#superclass : #Object,
	#instVars : [
		'icons',
		'locations'
	],
	#category : #'Nevermind-View-Application'
}

{ #category : #accessing }
NmIconProvider >> addLocation: aReference [

	locations := locations copyWith: aReference
]

{ #category : #accessing }
NmIconProvider >> iconNamed: aSymbol [

	^ icons 
		at: aSymbol
		ifAbsentPut: [ self loadIconNamed: aSymbol ]
]

{ #category : #accessing }
NmIconProvider >> icons [

	^ icons
]

{ #category : #initialization }
NmIconProvider >> initialize [ 

	super initialize.
	locations := #().
	icons := IdentityDictionary new.
	icons at: #blank put: (Form extent: 16@16 depth: 8)
]

{ #category : #inspecting }
NmIconProvider >> inspectionIcons [
	<inspectorPresentationOrder: 0 title: 'Icons'> 

	^ SpListPresenter new
		items: (icons associations sorted: [ :a :b | a key < b key ]);
		icon: [ :each | each value ];
		display: [ :each | each key ];
		yourself
]

{ #category : #utils }
NmIconProvider >> loadAllIcons [

	self locations do: [ :eachLocation |
		(eachLocation filesMatching: '*.png') do: [ :each |
			icons 
				at: each basename
				put: (self loadIcon: each) ] ]
]

{ #category : #utils }
NmIconProvider >> loadIcon: fileRef [

	fileRef exists ifFalse: [ 
		self error: ('Icon {1} does not exit' format: { fileRef fullName }) ].

	^ fileRef binaryReadStreamDo: [ :stream |
		 Form fromBinaryStream: stream ]
]

{ #category : #utils }
NmIconProvider >> loadIconNamed: aSymbol [

	self locations do: [ :each | | ref |
		ref := (each / aSymbol) withExtension: 'png'.
		ref exists ifTrue: [ 
			^ self loadIcon: ref ] ].
	
	self error: ('Icon {1} does not exit' format: { aSymbol })
	
]

{ #category : #accessing }
NmIconProvider >> locations [

	^ locations
]
