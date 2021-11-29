//
//  MapViewAll.swift
//  TrackDiseases
//
//  Created by User on 11/7/21.
//  Copyright © 2021 Team14. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation
 
struct MapViewAll: UIViewRepresentable {
    //***********************
    //   Input Parameters   *
    //***********************
   
    // MKMapType.standard, MKMapType.satellite, MKMapType.hybrid
    var mapType: MKMapType
   
    var records:FetchedResults<Record>
    // North-to-south and east-to-west distance from center
    var delta: Double
   
    // Delta unit = "degrees" or "meters"
    var deltaUnit: String
    var locationLat:Double
    var locationLong:Double

    //----------------------------------------------------------------
   
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
   
    func updateUIView(_ view: MKMapView, context: Context) {
       
        // Dress up the map view object
        view.mapType = mapType
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        view.isRotateEnabled = false
       
        // Obtain Map's Center Location Coordinate
        let centerLocationCoordinate = CLLocationCoordinate2D(latitude: locationLat, longitude: locationLong)
       
        // Instantiate an object from the MKCoordinateRegion() class and
        // store its object reference into local variable mapRegion
        var mapRegion = MKCoordinateRegion()
       
        if deltaUnit == "degrees" {
            /*
             deltaUnit = "degrees" --> used for large maps such as a country map
             *** 1 degree = 111 kilometers = 69 miles ***
             MKCoordinateSpan identifies width and height of a map region.
             latitudeDelta: North-to-south distance in degrees to display in the map region.
             longitudeDelta:  East-to-west distance in degrees to display in the map region.
             */
            let mapSpan = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
 
            // Create a rectangular geographic map region around centerLocationCoordinate
            mapRegion = MKCoordinateRegion(center: centerLocationCoordinate, span: mapSpan)
           
        } else {
            /*
             deltaUnit = "meters" --> used for small maps such as a campus or city map
             *** 1609.344 meters = 1.609344 km = 1 mile ***
             latitudinalMeters: North-to-south distance in meters to display in the map region.
             longitudinalMeters:  East-to-west distance in meters to display in the map region.
             */
           
            // Create a rectangular geographic map region around centerLocationCoordinate
            mapRegion = MKCoordinateRegion(center: centerLocationCoordinate, latitudinalMeters: delta, longitudinalMeters: delta)
        }
       
        // Set the map region with animation
        view.setRegion(mapRegion, animated: true)
       
        //*****************************************
        // Prepare and Set Annotation on Map Center
        //*****************************************
       
        // Instantiate an object from the MKPointAnnotation() class and
        // store its object reference into local variable annotation
        for record in records{
            let annotation = MKPointAnnotation()
           
            // Dress up the newly created MKPointAnnotation() object
            annotation.coordinate = CLLocationCoordinate2D(latitude: record.latitude as! CLLocationDegrees, longitude: record.longitude as! CLLocationDegrees)
            annotation.title = record.choice
            annotation.subtitle = record.date
           
            // Add the created and dressed up MKPointAnnotation() object to the map view
            view.addAnnotation(annotation)
 
        }
    }
   
}
 
 
