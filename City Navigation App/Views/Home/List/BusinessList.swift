//
//  BusinessList.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/29/23.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var contentModel: ContentModel
    
    var body: some View {
        
        ScrollView{
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]){
                
                BusinessListSection(title: "Restaurants", business: contentModel.restaurants)
                
                BusinessListSection(title: "Sights", business: contentModel.sights)
                
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
            .environmentObject(ContentModel())
    }
}
