//
//  BusinessMap2.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/16/23.
//

import Foundation
import SwiftUI
import MapKit

struct BusinessMap2: UIViewRepresentable {
    
    @EnvironmentObject var contentModel: ContentModel
    @Binding var selectedBusiness: Business?
    
    //Computed Property
    var locations:[MKPointAnnotation]{
        
        var annotations = [MKPointAnnotation]()
        
        // MARK: Create Annotations
        for business in contentModel.restaurants + contentModel.sights{
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                // create annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // This detects when a user taps something
        mapView.delegate = context.coordinator

        
        //make user show on map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on business
        uiView.showAnnotations(self.locations, animated: true) // This one starts zoomed in
        //uiView.addAnnotations(self.locations)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    
    //MARK: Coordinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self) // self means businessMap2
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        // This is for the Sheet
        var map: BusinessMap2
        
        init(map: BusinessMap2) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // User Location Blue dot stays
            if annotation is MKUserLocation {
                return nil
            }
            
            // Create annotation Detail View when clicked
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            // This makes everything resuable 
            if annotationView == nil {
                // Create new one
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        // This is for the Sheet
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // User tapped on the annotation view
            
            // Get the business object that this annotation represents
            // Loop through busineess in the model and find a match
            
            for business in map.contentModel.restaurants + map.contentModel.sights {
                if business.name == view.annotation?.title {
                    // Set the selectedBusiness property to that business object

                    map.selectedBusiness = business
                    return
                }
            }
        }
        
    }
}
