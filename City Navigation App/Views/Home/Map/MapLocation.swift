//
//  MapAnnotations.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/16/23.
//

import Foundation
import MapKit



struct MapAnnotation2: Identifiable {
    let id = UUID()
    let title:String
    let coordinate: CLLocationCoordinate2D
}

var location:[MapLocation] = []


    /*
    static func getLocation() -> [MapAnnotations]{
        @EnvironmentObject var contentModel:ContentModel
        
        for business in contentModel.restaurants + contentModel.sights {
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                return [
                    //MapAnnotations()
                ]
            }
        }
        
        return [
            //MapAnnotations()
        ]
    }
}

//extension MapAnnotations: Identifiable{}

*/
