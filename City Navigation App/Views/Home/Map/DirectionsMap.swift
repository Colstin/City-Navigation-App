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
    
    func makeUIView(context: Context) -> MKMapView  {
        let map = MKMapView()
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
    }
    
    
    //MARK: -Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
    }
}
