//
//  BusinessRow.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/1/23.
//

import SwiftUI

struct BusinessRow: View {
    // Cant use this as we are too far deep and in order to condense code more efficent to use business rather than a en obj. technically we are using one in the main list view.
    //@EnvironmentObject var contentModel: ContentModel
    
    @ObservedObject var business: Business
    //@State var business: Business

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                //Image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(15)
                    .scaledToFit()
                //Name and distance
                VStack(alignment: .leading){
                    Text(business.name ?? "Business Name ")
                        .multilineTextAlignment(.leading)
                        .bold()
                    Text(String(format: "%.1f miles away", (business.distance ?? 0)*0.000621 ))
                        .font(.caption)
                    
                }
                Spacer()
                // Star rating and # of reviews
                VStack(alignment: .leading){
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews" )
                        .font(.caption)
                }
            }
            DashedDivider()
                .padding(.vertical)
        }
        .foregroundColor(.black)
    }
}
/*
struct BusinessRow_Previews: PreviewProvider {
    static var previews: some View {
        BusinessRow()
    
    }
}

*/
