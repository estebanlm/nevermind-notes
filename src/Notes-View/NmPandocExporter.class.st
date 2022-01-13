Class {
	#name : #NmPandocExporter,
	#superclass : #Object,
	#category : #'Notes-View-Utils'
}

{ #category : #commands }
NmPandocExporter >> exportNote: aNote to: fileName format: format [
	| tmpMarkdown |

	tmpMarkdown := FileReference newTempFilePrefix: 'note_' suffix: '.md'. 
	tmpMarkdown writeStreamDo: [ :stream | stream << aNote contents ].
	  
	[
		self runPandoc: {
			'-f'. 'markdown_github'.
			'-s'. tmpMarkdown fullName.
			'-o'. fileName.
			'-t'. format }. ] 
	ensure: [ 
		tmpMarkdown ensureDelete ]
]

{ #category : #commands }
NmPandocExporter >> listOutputFormats [

	^ (self runPandoc: #( '-C' '--list-output-formats' )) substrings
]

{ #category : #private }
NmPandocExporter >> logRunErrors: errString [
	
	errString crTrace
]

{ #category : #private }
NmPandocExporter >> pandocWorkingDirectory [
	
	^ (FileLocator temp / 'notes') 
		ensureCreateDirectory;
		fullName
]

{ #category : #private }
NmPandocExporter >> runPandoc: anArray [
	| result |

	OSSUnixSubprocess new
		workingDirectory: self pandocWorkingDirectory;
		command: '/usr/bin/pandoc';
		arguments: anArray;
		redirectStdout;
		runAndWaitOnExitDo: [ :command :outString :errString | 
			errString isEmptyOrNil 
				ifFalse: [  self logRunErrors: errString ].
			result := outString ].
 
	^ result
]
