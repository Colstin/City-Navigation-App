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
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    // These hold the Restaurants or the sights data respectively
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    @Published var business: Business?
   
    @Published var mapLocations: [MapLocation] = []
    
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
        
        // Update authorizationState Property
        authorizationState = locationManager.authorizationStatus
        
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
            getBuisnesses(category: "\(Constants.sightsKey)", location: userLocation!)
            getBuisnesses(category: "\(Constants.restaurantsKey)", location: userLocation!)
        }
    }

    // MARK: Yelp API methods
    
    func getBuisnesses(category:String, location:CLLocation) {
        
        //1. Create URL
        //2. Create URL Request
        //3. Get URLSession
        //4. Create Data Task
        //5. parse Json
        //6. Start Data Task
      
        //1.
        var urlComponents = URLComponents(string: "\(Constants.apiUrl)")
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
        request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        
        
        // 3.
        let session = URLSession.shared
        //4.
        let dataTask = session.dataTask(with: request) { data, response, error in
            //check that there isn't an error
            
            guard error == nil else{
                print("There is an error")
                return
            }
            
            //5.
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessSearch.self, from: data!)
                
                
                //MARK: Sort Businesses (closest at top of list)
                var sortedBusinesses = result.businesses
                sortedBusinesses.sort { b1, b2 in
                    return b1.distance ?? 0 < b2.distance ?? 0
                }
                
                
                // Call image function of the business
                for b in sortedBusinesses{
                    b.getImageData()
                }
                DispatchQueue.main.async {
                    for b in sortedBusinesses{
                        let place = MapLocation(title: b.name ?? "" , coordinate: CLLocationCoordinate2D(latitude: b.coordinates?.latitude ?? 0, longitude: b.coordinates?.longitude ?? 0))
                        self.mapLocations.append(place)
                    }
                }
              
            
                DispatchQueue.main.async {
                    /*
                    if category == "\(Constants.sightsKey)" {
                        self.sights = result.businesses
                        
                    } else if category == "\(Constants.restaurantsKey)" {
                        self.restaurants = result.businesses
                    }
                    */
                    switch category{
                    case Constants.sightsKey:
                        self.sights = sortedBusinesses
                    case Constants.restaurantsKey:
                        self.restaurants = sortedBusinesses
                    default:
                        break
                    }
                }
                
            } catch {
                print(error)
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
