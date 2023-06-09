//
//  HomeView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/29/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var contentModel: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness:Business?
    
    var body: some View {
        VStack {
            if contentModel.restaurants.count != 0 || contentModel.sights.count != 0 {
                NavigationStack{
                    if !isMapShowing{
                        // show list
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "location")
                                Text(contentModel.placemark?.subLocality ?? "Current City")
                                Spacer()
                                Button("Switch to map view") {
                                    isMapShowing = true
                                }
                            }
                            Divider()
                            ZStack(alignment: .top) {
                                BusinessList()
                                
                                HStack{
                                    Spacer()
                                    YelpAttribution(link: "https://yelp.ca")
                                        .frame(height: 36)
                                        .padding(.trailing, -20)
                                }
                            }
                        }
                        .padding([.top, .leading, .trailing])
                    } else {
                        
                        ZStack(alignment: .top) {
                            // Show map
                            BusinessMap2(selectedBusiness: $selectedBusiness)
                                .ignoresSafeArea()
                                .sheet(item: $selectedBusiness) { business in
                                    
                                    //Create a business detail view instance
                                    // Pass in selected business
                                    BusinessDetailView(business: business)
                            }
                            
                            // Rectangle Overlay
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .frame(height: 48)
                                
                                HStack{
                                    Image(systemName: "location")
                                    Text(contentModel.placemark?.subLocality ?? "Current City")
                                    Spacer()
                                    Button {
                                        isMapShowing = false
                                    } label: {
                                        Text("Switch to list view")
                                            .font(.subheadline)
                                    }
                                }
                                .padding()

                            }
                            .padding()
                        }
                    }
                }
             
                
            } else {
                ProgressView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
