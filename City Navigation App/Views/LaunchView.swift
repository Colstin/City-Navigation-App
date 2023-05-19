//
//  ContentView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 4/27/23.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var contentModel: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of geolocationg the user
        if contentModel.authorizationState == .notDetermined{
            // If undetermined, show onboarding
            OnboardingView()
            
        } else if contentModel.authorizationState == .authorizedAlways || contentModel.authorizationState == .authorizedWhenInUse{
            // if approved, show home view
            HomeView()
        } else {
            // if denied show denied view
            LocationDeniedView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ContentModel())
    }
}
