Class {
	#name : #NmShorcutsDialog,
	#superclass : #Object,
	#instVars : [
		'parentWindow'
	],
	#category : #'Nevermind-View-Notebook'
}

{ #category : #accessing }
NmShorcutsDialog class >> defaultExtent [

	^ 800@300
]

{ #category : #'private building' }
NmShorcutsDialog >> buildSections [
	| section |
	
	section := GtkShortcutsSection new.
	(((NmCommand allSubclasses 
		select: [ :each | 
			each group notNil 
				and: [ each defaultShortcut notNil ] ])
		sorted: [ :aCommandClass | aCommandClass group order ] ascending)
		groupedBy: #group)
		keysAndValuesDo: [ :aGroup :aList | | group |
			group := GtkShortcutsGroup newTitle: aGroup name.
			section add: group.
			(aList sorted: #defaultName ascending)
				do: [ :each | group add: each asGtkShortcutsShortcut ] ].

	^ { section }
]

{ #category : #opening }
NmShorcutsDialog >> open [

	GtkRunLoop defer: [ 
		| sections window |

		sections := self buildSections.
		window := GtkShortcutsWindow new 
			beModal;
			resize: self class defaultExtent;
			yourself.
		sections do: [ :each | window add: each ].
		self parentWindow ifNotNil: [ :aPresenter | 
			window transientTo: aPresenter adapter widget ].
		window showAll ]
]

{ #category : #accessing }
NmShorcutsDialog >> parentWindow [

	^ parentWindow
]

{ #category : #accessing }
NmShorcutsDialog >> parentWindow: aWindowPresenter [

	parentWindow := aWindowPresenter
]
