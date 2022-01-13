Class {
	#name : #NmShowShortcutsCommand,
	#superclass : #NmCommand,
	#category : #'Notes-View-Commands'
}

{ #category : #default }
NmShowShortcutsCommand class >> defaultDescription [

	^ 'Show shortcuts'
]

{ #category : #default }
NmShowShortcutsCommand class >> defaultName [

	^ 'Shortcuts'
]

{ #category : #default }
NmShowShortcutsCommand class >> defaultShortcut [

	^ $h platformMeta
]

{ #category : #executing }
NmShowShortcutsCommand >> execute [
	
	context doShowShortcuts
]
