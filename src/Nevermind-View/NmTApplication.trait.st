Trait {
	#name : #NmTApplication,
	#category : #'Nevermind-View-Application'
}

{ #category : #accessing }
NmTApplication >> applicationModel [

	^ self application model
]

{ #category : #accessing }
NmTApplication >> notificationCenter [

	^ self application notificationCenter
]

{ #category : #notifying }
NmTApplication >> notify: aNotification [

	self notificationCenter notify: aNotification
]
