Class {
	#name : #KMLReaderTest,
	#superclass : #TestCase,
	#category : #'KML-Reader-Tests'
}

{ #category : #'as yet unclassified' }
KMLReaderTest >> cubeString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">

  <name>Cube</name>


  <Placemark>


    <Polygon>

      <extrude>1</extrude>

      <altitudeMode>relativeToGround</altitudeMode>

      <outerBoundaryIs>

				<LinearRing>
					<coordinates>
						8.542634850324216,47.36654315613557,100 
            8.54263475978412,47.36550030198994,100 
            8.544161875287033,47.36550183316037,100
            8.54416186368919,47.36654140446431,100
            8.542634850324216,47.36654315613557,100
					</coordinates>
				</LinearRing>

      </outerBoundaryIs>

    </Polygon>

   <!-- - - - - - - - - - - - - - - - - - - - - - - -->

	  <LookAt>
	  	<longitude> 8.543151875920312 </longitude>
	  	<latitude>  47.36561202482072 </latitude>
	  	<altitude>  0                 </altitude>
	  	<heading>   45                </heading>
	  	<tilt>      64                </tilt>
	  	<range>     843               </range>

	  	<gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode>
	  </LookAt>

  </Placemark>


</kml>'
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> lineStringString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>

	<name>polygon.kml</name>

	<Style id="orange-5px">
		<LineStyle>
			<color>ff00aaff</color>
			<width>5</width>
		</LineStyle>
	</Style>


	<Placemark>

		<name>A polygon</name>
		<styleUrl>#orange-5px</styleUrl>

		<LineString>

			<tessellate>1</tessellate>
			<coordinates>
        8.542123809233731,47.36651432591258,0
        8.542020373307826,47.36684332453151,0
        8.544057950790664,47.36717881947375,0
        8.544133279150493,47.36684482636069,0
        8.542123809233731,47.36651432591258,0  <!-- End coordinates == start coordinates -->
			</coordinates>

		</LineString>

	</Placemark>

</Document>
</kml>'
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> polygonString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>

	<name>polygon.kml</name>

	<Style id="orange-5px">
		<LineStyle>
			<color>ff00aaff</color>
			<width>5</width>
		</LineStyle>
	</Style>


	<Placemark>  
 <Polygon>
  <outerBoundaryIs>
   <LinearRing>
    <coordinates>
     0.0,0.0,0.0
     1.0,15.0,0.0
     5.0,15.0,0.0
     5.0,0.0,0.0
     0.0,0.0,0.0
    </coordinates>    
   </LinearRing>
  </outerBoundaryIs>
  <innerBoundaryIs>
   <LinearRing>
    <coordinates>
     0.5,0.5,0.0
     2,14.0,0.0
     4.5,14.0,0.0
     4.0,0.5,0.0
     0.5,0.5,0.0
    </coordinates>    
   </LinearRing>
  </innerBoundaryIs>
 </Polygon>
</Placemark>

</Document>
</kml>'
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> simplePlacemarkPlusHTMLString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">

  <Placemark>

    <name>Description with html</name>

    <description><![CDATA[

      <h1>HTML is possible within a description</h1>

      Some <span style="color:red">red text</span>.
      
      <table border=1>
        <tr><td>one  </td><td>foo</td></tr>
        <tr><td>two  </td><td>bar</td></tr>
        <tr><td>three</td><td>baz</td></tr>
      </table>


    ]]></description>

    <Point>
			<coordinates>8.542952335953721,47.36685263064198,0</coordinates>
    </Point>

  </Placemark>

</kml>'
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> simplePlacemarkString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">

  <Placemark>

    <name>A simple placemark on the ground</name>

    <Point>
			<coordinates>8.542952335953721,47.36685263064198,0</coordinates>
    </Point>

  </Placemark>

</kml>'
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> testCube [
	| model geometry |
	model := KMLReader parse: self cubeString.
	self assert: model features size equals: 1.
	geometry := model features first geometry.
	self assert: geometry geometryType equals: 'Polygon'.
	self assert: geometry exterorRing points first x equals: 8.542634850324216.
	self assert: geometry exterorRing points first y equals: 47.36654315613557.
	
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> testLineString [
	| model geometry |
	model := KMLReader parse: self lineStringString.
	self assert: model features size equals: 1.
	geometry := model features first geometry.
	self assert: geometry geometryType equals: 'LineString'.
	self assert: geometry points first x equals: 8.54212380923373.
	self assert: geometry points first y equals: 47.36651432591258.
	
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> testPolygon [
	| model geometry |
	model := KMLReader parse: self polygonString.
	self assert: model features size equals: 1.
	geometry := model features first geometry.
	self assert: geometry geometryType equals: 'Polygon'.
	self assert: geometry exterorRing points second x equals: 1.0.
	self assert: geometry interiorRings first points first y equals: 0.5.
	
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> testSimplePlacemark [
	| model geometry |
	model := KMLReader parse: self simplePlacemarkString.
	self assert: model features size equals: 1.
	geometry := model features first geometry.
	self assert: geometry x equals: 8.542952335953721.
	self assert: geometry y equals: 47.36685263064198.
	
]

{ #category : #'as yet unclassified' }
KMLReaderTest >> testSimplePlacemarkPlusHTML [
	| model geometry |
	model := KMLReader parse: self simplePlacemarkPlusHTMLString.
	self assert: model features size equals: 1.
	geometry := model features first geometry.
	self assert: geometry x equals: 8.542952335953721.
	self assert: geometry y equals: 47.36685263064198.
	
]
