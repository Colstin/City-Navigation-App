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
                if !isMapShowing{
                    // show list
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Text("Switch to map view")
                        }
                        Divider()
                        BusinessList()
                    }
                } else {
                    // show map
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
