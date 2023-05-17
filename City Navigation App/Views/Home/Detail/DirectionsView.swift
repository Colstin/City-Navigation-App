//
//  DirectionsView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/17/23.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            // Business title
            HStack {
                DetailTitleView(business: business)
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name{
                    Link("Open in Maps", destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)

                }
            }
            .padding(.horizontal)
            // Directions map
            
        }
    }
}

/*
struct DirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsView()
    }
}
*/
