Class {
	#name : #NmNotification,
	#superclass : #Object,
	#category : #'Nevermind-View-Application'
}

{ #category : #converting }
NmNotification class >> asNotification [

	^ self new
]

{ #category : #accessing }
NmNotification class >> receiverSelector [

	^ #note:
]

{ #category : #accessing }
NmNotification class >> systemIconName [

	^ #announcementIcon
]

{ #category : #converting }
NmNotification >> asNotification [

	^ self
]

{ #category : #accessing }
NmNotification >> dispatchTo: anObject [
	| selector |

	selector := self lookupSelectorOn: anObject.
	
	"(anObject className,'>>',selector,'(', self receiverSelector, ')') crTrace. "
		
	anObject 
		perform: selector
		with: self
]

{ #category : #private }
NmNotification >> lookupSelectorOn: anObject [

	^ self 
		lookupSelectorOn: anObject 
		for: self class
]

{ #category : #private }
NmNotification >> lookupSelectorOn: anObject for: aNotificationClass [

	^ (anObject respondsTo: aNotificationClass receiverSelector)
		ifTrue: [ aNotificationClass receiverSelector ]
		ifFalse: [ 
			(aNotificationClass = CrNotification) ifTrue: [ 
				self error: 'Notification receiver not defined.' ]. 
			self lookupSelectorOn: anObject for: aNotificationClass superclass ].
]

{ #category : #accessing }
NmNotification >> receiverSelector [

	^ self class receiverSelector
]
