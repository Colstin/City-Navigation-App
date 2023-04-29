//
//  BusinessListSectionHeader.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/29/23.
//

import SwiftUI

struct BusinessListSectionHeader: View {
    
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
        }
    }
}

struct BusinessListSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListSectionHeader(title: "Sample text")
    }
}
