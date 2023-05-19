//
//  DetailGroupView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/2/23.
//

import SwiftUI

struct DetailGroupView: View {
    
    var business: Business
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
            //Title, Reviews, Address
            DetailTitleView(business: business)
            DashedDivider()
                .padding(.horizontal)
            
            //Phone
            HStack{
                Text("Phone: ")
                
                Spacer()
                Link(destination: URL(string: "tel:\(business.phone ?? "No Phone Available")")!) {
                    Text(business.displayPhone ?? "")
                }
            }
            DashedDivider()
            
            // Categories
            HStack{
                Text("Categories: ")
                Spacer()
                VStack(alignment: .trailing){
                    if business.categories != nil {
                        ForEach(business.categories!, id: \.self){ category in
                            Text("\(category.title ?? "No category available")")
                                
                        }
                    }
                }
            }
            DashedDivider()
            
            //Website
            HStack{
                Text("Website: ")
                Spacer()
                Link(destination: URL(string: "\(business.url ?? "No Website Available")")!) {
                    Text("\(business.url ?? "")")
                        .lineLimit(1)
                        
                }
            }
            .padding(.bottom, 50)
        }
        .padding(.horizontal)
    }
}

/*
struct DetailGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGroupView()
    }
}
*/
