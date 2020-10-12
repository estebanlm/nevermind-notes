Class {
	#name : #NmCommand,
	#superclass : #CmCommand,
	#category : #'Nevermind-View-Application'
}

{ #category : #default }
NmCommand class >> defaultIconName [

	^ nil
]

{ #category : #default }
NmCommand class >> defaultShortcut [

	^ nil
]

{ #category : #'instance creation' }
NmCommand class >> newActionButtonFor: aPresenter [
	
	^ (self forSpecContext: aPresenter) asButtonPresenter
		owner: aPresenter;
		yourself
]

{ #category : #'instance creation' }
NmCommand class >> newButtonFor: aPresenter [
	
	^ (self forSpecContext: aPresenter) asButtonPresenter
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

{ #category : #accessing }
NmCommand >> notificationCenter [

	^ self application notificationCenter
]
