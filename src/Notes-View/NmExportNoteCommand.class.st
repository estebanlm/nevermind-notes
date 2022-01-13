Class {
	#name : #NmExportNoteCommand,
	#superclass : #NmCommand,
	#category : #'Notes-View-Commands'
}

{ #category : #default }
NmExportNoteCommand class >> defaultDescription [

	^ 'Export current note.'
]

{ #category : #default }
NmExportNoteCommand class >> defaultIconName [

	^ 'document-export'
]

{ #category : #default }
NmExportNoteCommand class >> defaultName [

	^ 'Export Note'
]

{ #category : #default }
NmExportNoteCommand class >> defaultShortcut [

	^ $e platformMeta
]

{ #category : #accessing }
NmExportNoteCommand class >> group [

	^ NmCommandNoteGroup note
]

{ #category : #executing }
NmExportNoteCommand >> execute [
	
	context doExport
]
