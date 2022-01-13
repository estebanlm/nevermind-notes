Class {
	#name : #NoWindowsWebBrowser,
	#superclass : #NoWebBrowser,
	#category : #'Notes-View-WebBrowser'
}

{ #category : #testing }
NoWindowsWebBrowser class >> isForCurrentSystem [

	^Smalltalk os isWindows   
]

{ #category : #private }
NoWindowsWebBrowser class >> openNativeWebBrowserOn: anURLString [

	^self shellExecute: 'open' file: anURLString parameters: '' directory: '' show: 5 "SW_SHOW"
]

{ #category : #'private - uffi' }
NoWindowsWebBrowser class >> shellExecute: lpOperation file: lpFile parameters: lpParameters directory: lpDirectory show: nShowCmd [	
	
	^self ffiCall: #( 
			FFIConstantHandle ShellExecuteA(
     				0,
     				String* lpOperation,
         			String* lpFile,
     				String* lpParameters,
     				String* lpDirectory,
        			int nShowCmd)) module: #shell32
]
