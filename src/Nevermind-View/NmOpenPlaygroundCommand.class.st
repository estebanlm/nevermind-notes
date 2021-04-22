Class {
	#name : #NmOpenPlaygroundCommand,
	#superclass : #NmCommand,
	#category : #'Nevermind-View-Commands'
}

{ #category : #default }
NmOpenPlaygroundCommand class >> defaultDescription [

	^ 'Open a Pharo Playground.'
]

{ #category : #default }
NmOpenPlaygroundCommand class >> defaultIconName [

	^ 'system'
]

{ #category : #default }
NmOpenPlaygroundCommand class >> defaultName [

	^ 'Playground'
]

{ #category : #executing }
NmOpenPlaygroundCommand >> execute [
	
	context doOpenPlayground
]
