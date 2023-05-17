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
    
}
