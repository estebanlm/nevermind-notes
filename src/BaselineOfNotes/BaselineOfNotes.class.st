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
		"self macPack: spec."

		spec 
			package: 'Nevermind-Model' with: [ 
				spec requires: #('ZTimestamp' 'Voyage' 'PersistenceQuery') ];
			package: 'Nevermind-View' with: [ 
				spec requires: #('Stargate') ] ]
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
