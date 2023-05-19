//
//  LocationDeniedView.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/18/23.
//

import SwiftUI

struct LocationDeniedView: View {
    
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack(spacing: 10) {
            
            Spacer()
            Text("Whoops!")
                .bold()
                .font(.title)
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in settings.")
                .multilineTextAlignment(.center)
         
                
            Spacer()
            
            Button {
                // Open Settings
                if let url = URL(string: UIApplication.openSettingsURLString){
                    
                    if UIApplication.shared.canOpenURL(url){
                        UIApplication.shared.open(url)
                    }
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(height: 48)
       
                    Text("Go to settings")
                        .foregroundColor(backgroundColor)
                        .bold()
                        .font(.title3)
                }
                .padding(.horizontal, 30)
            }
            Spacer()
                //MARK: ?? WEIRD PADDING TRICK ??
               // .padding(.bottom)
            
        }
        .background(backgroundColor)
        .foregroundColor(.white)
        //.ignoresSafeArea(.all, edges: .all)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
