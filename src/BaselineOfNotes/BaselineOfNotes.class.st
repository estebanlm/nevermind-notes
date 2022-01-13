Class {
	#name : #BaselineOfNotes,
	#superclass : #BaselineOf,
	#category : #BaselineOfNotes
}

{ #category : #baselines }
BaselineOfNotes >> baseline: spec [
	<baseline>
	
	spec for: #pharo do: [
		self ztimestamp: spec.
		self voyage: spec.
		self persistenceQuery: spec.
		self specGtk: spec.
		self objCBridge: spec.
		self stargate: spec.
		
		OSPlatform current isWindows 
			ifTrue: [ self osWinSubprocess: spec ]
			ifFalse: [ self osSubprocess: spec ].

		spec 
			package: 'Notes-Model' with: [ 
				spec requires: #(
					'ZTimestamp' 
					'Voyage' 
					'PersistenceQuery' 
					'OSSubprocess') ];
			package: 'Notes-View' with: [ 
				spec requires: #('Stargate' 'Notes-Model') ] ]
]

{ #category : #'external projects' }
BaselineOfNotes >> macPack: spec [

	spec
		baseline: 'MacPack'
		with: [ spec repository: 'github://estebanlm/macpack' ] 
]

{ #category : #'external projects' }
BaselineOfNotes >> objCBridge: spec [

	spec
		baseline: 'ObjCBridge'
		with: [ spec repository: 'github://estebanlm/objcbridge' ]
]

{ #category : #'external projects' }
BaselineOfNotes >> osSubprocess: spec [
		
	spec baseline: 'OSSubprocess' with: [ 
		spec repository: 'github://pharo-contributions/OSSubprocess:v1.3.0' ]
]

{ #category : #'external projects' }
BaselineOfNotes >> osWinSubprocess: spec [
		
	spec baseline: 'OSSubprocess' with: [
		spec 
			className: 'BaselineOfOSWinSubprocess';
			repository: 'github://pharo-contributions/OSWinSubprocess:v1' ]
]

{ #category : #'external projects' }
BaselineOfNotes >> persistenceQuery: spec [

	spec
		baseline: 'PersistenceQuery'
		with: [ 
			spec 
				loads: #('ejdb');
				repository: 'github://pharo-nosql/PersistenceQuery' ]
]

{ #category : #'external projects' }
BaselineOfNotes >> specGtk: spec [

	spec
		baseline: 'SpecGtk'
		with: [ spec repository: 'github://pharo-spec/Spec-Gtk' ]
]

{ #category : #'external projects' }
BaselineOfNotes >> stargate: spec [

	spec
		baseline: 'Stargate'
		with: [ spec repository: 'github://estebanlm/stargate' ]
]

{ #category : #'external projects' }
BaselineOfNotes >> voyage: spec [

	spec
		baseline: 'Voyage'
		with: [ 
			spec 
				loads: #('memory' 'ejdb tests');
				repository: 'github://pharo-nosql/voyage' ]
]

{ #category : #'external projects' }
BaselineOfNotes >> ztimestamp: spec [

	spec
		baseline: 'ZTimestamp'
		with: [ spec repository: 'github://svenvc/ztimestamp' ]
]
