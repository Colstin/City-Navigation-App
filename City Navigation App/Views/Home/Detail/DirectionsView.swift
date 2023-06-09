//
//  DirectionsView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/17/23.
//
//MARK: ENCODING for LINKs
/*
 Methods like addingPercentEncoding encode characters such as spaces and apostrophes, which cannot be directly used in URLs.
 */

import SwiftUI

struct DirectionsView: View {
    
    var business: Business
 
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            // Business title
            ZStack(alignment: .trailing) {
                
                DetailTitleView(business: business)
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                    
                    Link("Open in Maps", destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name)")!)
                               
                }
            }
            .padding([.top, .leading, .trailing])
            // Directions map
            DirectionsMap(business: business)
                .ignoresSafeArea(.all, edges: .bottom)
            
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
