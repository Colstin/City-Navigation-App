//
//  ContentModel.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/27/23.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject{
   
    var locationManager = CLLocationManager()
    
    override init() {
        // Init method of NSObject
        super.init()
        
        // Set content mdoel as the delegate of the location manager
        locationManager.delegate = self
        
        
        // Request Permission from user
        locationManager.requestWhenInUseAuthorization()
        
       
    }
    
    // MARK:  Location manager Delegate methods
    //To FIND: type didchange
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == . authorizedWhenInUse {
           
            // We have permission - Start geolocating the user
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
            // We don't have permission
        }
    }
   
    //TO FIND type: didupd
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Gives us the location of the user
        print(locations.first ?? "no location")
        
        // Stop requesting gthe location after we get it once
        locationManager.stopUpdatingLocation()
        
        // TODO: if we have the coordinates of the user, send into the yelp API

    }


}


/*
 MARK: CLLocationManager() needs a few things to work
 1. must create our class to be a NSObject
 2. add the CLLocationManagerDelegate
 3. We need to override the init in order to use
 4. Need to modify ino.plist to request permission from user
 
 
 */
