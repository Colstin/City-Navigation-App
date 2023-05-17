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
        
        //Business Name
        Text(business.name!)
            .font(.largeTitle)
            .padding(.bottom)
        
        //Address     (We have to do this because API stores this in an array)
        if business.location?.displayAddress != nil{
            ForEach(business.location!.displayAddress!, id: \.self){ displayLine in
                Text(displayLine)
                
            }
        }
       
        //Ratings/ Reviews
        Image("regular_\(business.rating ?? 0)")
        Link(destination: URL(string: "\(business.url ?? "No Website Available")")!) {
            Text("\(business.reviewCount ?? 0 ) Reviews")
        }
        Divider()
        
        //Phone
        HStack{
            Text("Phone: ")
            
            Spacer()
            Link(destination: URL(string: "tel:\(business.phone ?? "No Phone Available")")!) {
                Text(business.displayPhone ?? "")
            }
        }
        Divider()
        
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
        Divider()
        
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
}

/*
struct DetailGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGroupView()
    }
}
*/
