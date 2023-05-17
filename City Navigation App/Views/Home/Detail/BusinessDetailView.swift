//
//  BusinessDetailView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/2/23.
//

import SwiftUI

struct BusinessDetailView: View {
    
    var business: Business
    @State private var showDirections = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 0){
                GeometryReader(){ geo in
                    //Business Image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
                
                // Open/Closed Indicator
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray: .blue )
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
            .ignoresSafeArea()
   
            
            Group{
              DetailGroupView(business: business)
   
            }
           
            
            // MARK: Directions Button
            Button {
                showDirections = true
            } label: {
                ZStack{
                    Rectangle()
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(height: 48)
                .foregroundColor(.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                .sheet(isPresented: $showDirections) {
                    DirectionsView(business: business)
                }
          
            }
        } //Vstack
    }
}

/*
struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetailView()
    }
}
*/
