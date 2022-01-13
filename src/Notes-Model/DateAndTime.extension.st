Extension { #name : #DateAndTime }

{ #category : #'*Notes-Model' }
DateAndTime >> notesAsString [

	^ String streamContents: [ :stream |
		stream 
			nextPutAll: self asDate notesAsString;
			nextPutAll: ', '.
		self asTime 
			print24: false
			showSeconds: false 
			on: stream ]
]
