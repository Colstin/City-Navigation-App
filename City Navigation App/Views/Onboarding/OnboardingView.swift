//
//  OnboardingView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/18/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var contentModel: ContentModel
    @State private var tabSelection = 0
    
    private let green = Color(red: 100/255, green: 194/255, blue: 223/255)
    private let blue = Color(red: 116/255, green: 172/255, blue: 255/255)
    
    var body: some View {
        VStack{
            // Tab View
            TabView(selection: $tabSelection) {
                
                // First tab
                VStack(spacing: 20){
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                        
                    Text("Welcome to City Navigation!")
                        .bold()
                        .font(.title)
                    Text("City Navigation helps you find the best of the city!")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .tag(0)
                
                // Second tab
                VStack(spacing: 20){
                    Image("wifi")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea(.all)
                        
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We'll show you the best restaurants, venues and more, based on your location!")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                     
                }
               
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .foregroundColor(.white)
           
            
            
            // Button
            Button {
                if tabSelection == 0 {
                    tabSelection = 1
                } else {
                    // request for geo location
                    contentModel.requestGeolocationPermission()
                }
            } label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(tabSelection == 0 ? "Next" : "Get My Location")
                         .font(.title3)
                        .bold()
                        .padding()
                        .foregroundColor(tabSelection == 0 ? green : blue)
                }
                .padding(.horizontal, 30)
            }
        }
        .background(tabSelection == 0 ? green : blue)
        //.ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(ContentModel())
    }
}
