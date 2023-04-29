//
//  BusinessListSection.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/29/23.
//

import SwiftUI

struct BusinessListSection: View {
    
    var title: String
    var business: [Business]
    
    var body: some View {
        
        Section(header: BusinessListSectionHeader(title: title)) {
            ForEach(business) { business in
                Text(business.name ?? "")
                Divider()
            }
        }
    }
}


