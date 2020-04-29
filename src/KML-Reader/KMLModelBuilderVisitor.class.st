Class {
	#name : #KMLModelBuilderVisitor,
	#superclass : #KMLVisitor,
	#instVars : [
		'model',
		'currentObject'
	],
	#category : #'KML-Reader'
}

{ #category : #accessing }
KMLModelBuilderVisitor >> model [
	^ model 
]

{ #category : #'as yet unclassified' }
KMLModelBuilderVisitor >> use: aKMLObject during: aBlock [
	| previous |
	previous := currentObject.
	currentObject := aKMLObject.
	aBlock ensure: [ 
		currentObject := previous ]
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitCoordinatesElement: aKMLCoordinatesElement [ 
	| rawCoordinates |
	rawCoordinates := (Character space split: aKMLCoordinatesElement contentString trimBoth) reject: #isEmpty.
	currentObject coordinates: (rawCoordinates collect: [ :each| | tuple |
		tuple := $, split: each.
		tuple first asNumber @@ tuple second asNumber ])
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitDescriptionElement: aKMLDescriptionElement [ 
	
	currentObject description: aKMLDescriptionElement contentString
]

{ #category : #'as yet unclassified' }
KMLModelBuilderVisitor >> visitDocument: aKMLDocument [ 
	model := KMLDocument new.
	currentObject := model.
	^ self visitElementWithChildren: aKMLDocument 
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitFolderElement: aKMLFolderElement [ 
	| folder |
	folder := KMLFolder new.
	self 
		use: folder
		during: [ self visitElementWithChildren: aKMLFolderElement ].
	currentObject addFeature: folder.
	^ folder
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitInnerBoundayIsElement: aKMLInnerBoundaryIsElement [
	| holder |
	holder := KMLGeometryHolder new .
	self
		use: holder
		during: [ self visitElementWithChildren: aKMLInnerBoundaryIsElement ].
	currentObject addInnerBoundary: holder geometry.
	^ holder
]

{ #category : #visting }
KMLModelBuilderVisitor >> visitLinearRingElement: aKMLLinearRingElement [ 
	| linearRing |
	linearRing := KMLLinearRing new.
	self
		use: linearRing 
		during: [ self visitElementWithChildren: aKMLLinearRingElement ].
	currentObject addGeometry: linearRing.
	^ linearRing
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitMultiGeometryElement: aKMLMultiGeometryElement [ 
	^ self visitElementWithChildren: aKMLMultiGeometryElement 
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitNameElement: aKMLNameElement [ 
	
	currentObject name: aKMLNameElement contentString
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitOuterBoundaryIs: aKMLOuterBoundaryIsElement [ 
	| holder |
	holder := KMLGeometryHolder new .
	self
		use: holder
		during: [ self visitElementWithChildren: aKMLOuterBoundaryIsElement ].
	currentObject outerBoundary: holder geometry.
	^ holder
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitParameterElement: aKMLParameterElement [ 
	currentObject 
		propertyAt: aKMLParameterElement name
		put: aKMLParameterElement contentString 
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitPlacemarkElement: aKMLPlacemarkElement [ 
	| placemark |
	placemark := KMLPlacemark new.
	self
		use: placemark
		during: [ self visitElementWithChildren: aKMLPlacemarkElement ].
	currentObject addFeature: placemark.
	^ placemark
]

{ #category : #visiting }
KMLModelBuilderVisitor >> visitPolygonElement: aKMLPolygonElement [ 
	| polygon |
	polygon := KMLPolygon new .
	self
		use: polygon
		during: [ self visitElementWithChildren: aKMLPolygonElement ].
	currentObject addGeometry: polygon
]