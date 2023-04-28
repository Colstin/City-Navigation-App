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
        let userLocation = locations.first
        
        if userLocation != nil {
            // Stop requesting gthe location after we get it once
            locationManager.stopUpdatingLocation()
            
            // if we have the coordinates of the user, send into the yelp API
            //getBuisnesses(category: "arts", location: userLocation!)
            getBuisnesses(category: "restaurants", location: userLocation!)
        }
    }

    // MARK: Yelp API methods
    
    func getBuisnesses(category:String, location:CLLocation) {
        
        //1. Create URL
        //2. Create URL Request
        //3. Get URLSession
        //4. Create Data Task
        //5. Start Data Task
      
        //1.
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        guard url != nil else{
            print("url was not found")
            return
        }
        
        //2.
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue("Bearer mm9vAWCcQu50GIwKPd_XN9XlabM8xcnxgMVlGmdmFwVXLgFOXSJasOa7ZFcZ0cL35RbbbvWdW9X05vEmK_CTPGob5K-KR5CDMPldqq3c2KFvRIXcwu7DbAe3h_5KZHYx", forHTTPHeaderField: "Authorization")
        
        
        // 3.
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            //check that there isn't an error
            
            guard error == nil else{
                print("There is an error")
                return
            }
            
            
            
        }
        dataTask.resume()
    }
}



/*
 MARK: CLLocationManager() needs a few things to work
 1. must create our class to be a NSObject
 2. add the CLLocationManagerDelegate
 3. We need to override the init in order to use
 4. Need to modify ino.plist to request permission from user
 
 
 */

/* Other way of creating the string I dont like it as much because more error prone but a good check for simple data
let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&Longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
 let url = URL(string: urlString)

 */
