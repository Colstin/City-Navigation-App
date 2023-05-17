//
//  DirectionsMap.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/17/23.
//

import Foundation
import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    
    @EnvironmentObject var contentModel: ContentModel
    var business:Business
    
    var start:CLLocationCoordinate2D {
        contentModel.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end:CLLocationCoordinate2D {
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            return CLLocationCoordinate2D()
        }
    }
    
    func makeUIView(context: Context) -> MKMapView  {
        //Create Map
        let map = MKMapView()
        map.delegate = context.coordinator
        
        //Show the User Location
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        //Create directions request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // Create directions Object
        let directions = MKDirections(request: request)
        
        // Calculate route
        directions.calculate { response, error in
            
            if error == nil && response != nil {
                for route in response!.routes {
                    
                    // plot the route on the map
                    map.addOverlay(route.polyline)
                    
                    // Zoom into the region
                    map.setVisibleMapRect(route.polyline.boundingMapRect,
                                          edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                                          animated: true)
                }
            }
        }
        
        // Place annotation for the end point
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = business.name ?? ""
        map.addAnnotation(annotation)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // We Dont need to do anything here because our data has already come back from the yelp API and we use the var business:Business
        // To access everything
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    
    //MARK: -Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            render.strokeColor = .blue
            render.lineWidth = 5
            return render
        }
    }
}
