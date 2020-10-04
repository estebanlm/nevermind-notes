Class {
	#name : #NmNoteCommiter,
	#superclass : #Object,
	#instVars : [
		'queue',
		'mutex',
		'waitSemaphore',
		'process'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Nevermind-Model'
}

{ #category : #'instance creation' }
NmNoteCommiter class >> new [ 

	self error: 'Use #uniqueInstance'
]

{ #category : #'instance creation' }
NmNoteCommiter class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #private }
NmNoteCommiter >> commit: anObject [

	[ anObject save ] 
	on: Error 
	fork: [ :e | e pass ]
]

{ #category : #private }
NmNoteCommiter >> flushQueue [
	
	mutex critical: [ 
		[ queue isEmpty ]
		whileFalse: [ 
			self commit: queue removeFirst  ] ]
]

{ #category : #initialization }
NmNoteCommiter >> initialize [

	super initialize.
	mutex := Mutex new.
	waitSemaphore := Semaphore new.
	queue := OrderedCollection new
]

{ #category : #accessing }
NmNoteCommiter >> queue: anObject [

	mutex critical: [ 
		(queue includes: anObject) ifFalse: [ 
			queue add: anObject.
			self verifyProcessIsRunning.
			waitSemaphore signal ] ]
]

{ #category : #private }
NmNoteCommiter >> spawnNewProcess [

	^ [  
			waitSemaphore wait.
			self waitTime wait.
			self flushQueue ] 
		forkNamed: 'Note commiter'
]

{ #category : #private }
NmNoteCommiter >> verifyProcessIsRunning [
	
	(process notNil and: [ process isTerminated not ]) ifTrue: [ ^ self ].
	process := self spawnNewProcess
]

{ #category : #accessing }
NmNoteCommiter >> waitTime [
	
	^ 10 seconds
]
