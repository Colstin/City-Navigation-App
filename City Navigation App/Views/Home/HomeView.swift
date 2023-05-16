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
    
    var body: some View {
        VStack {
            if contentModel.restaurants.count != 0 || contentModel.sights.count != 0 {
                NavigationStack{
                    if !isMapShowing{
                        // show list
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "location")
                                Text("Enterprise, NV")
                                Spacer()
                                Button("Switch to map view") {
                                    isMapShowing = true
                                }
                            }
                            Divider()
                            BusinessList()
                        }
                        .padding([.top, .leading, .trailing])
                    } else {
                        // show map
                        BusinessMap()
                            .ignoresSafeArea()
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
