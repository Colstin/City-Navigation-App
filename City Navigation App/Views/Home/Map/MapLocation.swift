//
//  MapAnnotations.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/16/23.
//

import Foundation
import MapKit

//Used for the BusinessMap
struct MapLocation: Identifiable {
    let id = UUID()
    let title:String
    let coordinate: CLLocationCoordinate2D
}
