Class {
	#name : #NmToggleNotePanelCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmToggleNotePanelCommand class >> defaultDescription [

	^ 'Toggle note panel visibility.'
]

{ #category : #default }
NmToggleNotePanelCommand class >> defaultIconName [

	^ 'sidebar'
]

{ #category : #default }
NmToggleNotePanelCommand class >> defaultName [

	^ 'Note Panel'
]

{ #category : #default }
NmToggleNotePanelCommand class >> defaultShortcut [

	^ $b platformMeta
]

{ #category : #executing }
NmToggleNotePanelCommand >> execute [
	
	context doToggleNotePanel
]
