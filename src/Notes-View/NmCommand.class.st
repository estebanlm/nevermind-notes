Class {
	#name : #NmCommand,
	#superclass : #CmCommand,
	#traits : 'NmTApplication',
	#classTraits : 'NmTApplication classTrait',
	#category : #'Notes-View-Commands'
}

{ #category : #converting }
NmCommand class >> asGtkShortcutsShortcut [

	^ GtkShortcutsShortcut 
		newTitle: self defaultDescription 
		shortcut: self defaultShortcut
]

{ #category : #default }
NmCommand class >> defaultIconName [

	^ nil
]

{ #category : #default }
NmCommand class >> defaultShortcut [

	^ nil
]

{ #category : #default }
NmCommand class >> group [

	^ NmCommandNoteGroup general
]

{ #category : #'instance creation' }
NmCommand class >> newActionButtonFor: aPresenter [
	
	^ (self forSpecContext: aPresenter) asActionButtonPresenter
		owner: aPresenter;
		yourself
]

{ #category : #'instance creation' }
NmCommand class >> newButtonFor: aPresenter [
	
	^ (self forSpecContext: aPresenter) asActionButtonPresenter
		owner: aPresenter;
		yourself
]

{ #category : #accessing }
NmCommand >> application [

	^ context application
]

{ #category : #converting }
NmCommand >> asSpecCommand [ 
	| command |
	
	command := super asSpecCommand 
		iconProvider: self application;
		iconName: self class defaultIconName;
		yourself.
		
	self class defaultShortcut 
		ifNotNil: [ :keyCombination | command shortcutKey: keyCombination ].
		
	^ command
]
