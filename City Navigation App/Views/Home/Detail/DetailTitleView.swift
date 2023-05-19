//
//  DetailTitleView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/17/23.
//

import SwiftUI

struct DetailTitleView: View {
    
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading){
            //Business Name
            Text(business.name!)
                .font(.title2)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .bold()
        
            
            //Address     (We have to do this because API stores this in an array)
            if business.location?.displayAddress != nil{
                ForEach(business.location!.displayAddress!, id: \.self){ displayLine in
                    Text(displayLine)
                        .foregroundColor(.black)
                }
            }
           
            HStack{
                VStack{
                    //Ratings/ Reviews
                    Image("regular_\(business.rating ?? 0)")
                    Link(destination: URL(string: "\(business.url ?? "No Website Available")")!) {
                        Text("\(business.reviewCount ?? 0 ) Reviews")
                    }
                }
                Spacer()
                YelpAttribution(link: business.url ?? "https://yelp.ca")
                    .frame(height: 46)
                    .padding(.trailing, -20)
            }
        } 
    }
}

/*
struct DetailTitleView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTitleView()
    }
}

*/
