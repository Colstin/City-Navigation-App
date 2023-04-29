//
//  BusinessSearch.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/28/23.
//

import Foundation

struct BusinessSearch: Decodable{
    
    var businesses = [Business]()
    var total = 0
    var region: Region
}

struct Region: Decodable{
    var center = Coordinate()
}
