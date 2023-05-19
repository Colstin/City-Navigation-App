//
//  OnboardingTab.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/18/23.
//

import SwiftUI

struct OnboardingTab: View {
    
    var imageText:String
    var titleText:String
    var descText:String
    
    var body: some View {
        
        // Tabs will use this style
        VStack(spacing: 20){
            Image("\(imageText)")
                .resizable()
                .scaledToFit()
                
            Text("\(titleText)")
                .bold()
                .font(.title)
            Text("\(descText)")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct OnboardingTab_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTab(imageText: "city1", titleText: "test", descText: "test")
    }
}
