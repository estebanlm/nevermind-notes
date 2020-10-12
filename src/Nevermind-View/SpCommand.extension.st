Extension { #name : #SpCommand }

{ #category : #'*Nevermind-View' }
SpCommand >> asActionButtonPresenter [
	
	^ SpButtonPresenter new
		owner: self context;
		help: self description;
		icon: self icon;
		action: [ self execute ];
		yourself
]
