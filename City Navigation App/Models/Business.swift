//
//  Business.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/28/23.
//

import Foundation

class Business: ObservableObject, Decodable, Identifiable{
    
    @Published var imageData: Data?
    
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount:Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case alias
        case name
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
    }
    
    func getImageData() {
        
        // Check image isn't nil
        
        guard imageUrl != nil else{
            return
        }
        
        //Dowload the data for the image
        let url = URL(string: imageUrl!)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil{
                
                DispatchQueue.main.async {
                    // Set image data
                    self.imageData = data
                }
               
            }
        }
        dataTask.resume()
        
    }
}


struct Location: Decodable{
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case address3
        case city
        case zipCode = "zip_code"
        case country
        case state
        case displayAddress = "display_address"
    }
    
}

struct Category: Decodable, Hashable{
    var alias: String?
    var title: String?
}

struct Coordinate: Decodable{
    var latitude: Double?
    var longitude: Double?
}
