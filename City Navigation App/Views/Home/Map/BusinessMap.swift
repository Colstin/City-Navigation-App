//
//  BusinessMap.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/15/23.
//

import SwiftUI
import MapKit

//MARK: -EXPERIEMENT FILE (NOT IN USE)

struct BusinessMap: View {
    @EnvironmentObject var contentModel:ContentModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.999277,
            longitude: -115.189576),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5))
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: contentModel.mapLocations,
                annotationContent: { location in
                    
                //MapMarker(coordinate: location.coordinate, tint: .red)
                MapAnnotation(coordinate: location.coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                    Text(location.title)
                        .font(.caption)
                    }
                }
            )
            .ignoresSafeArea()
           
            
            //MARK: ZOOM BUTTONS
            HStack {
                Button {
                    region.span.latitudeDelta *= 0.7
                    region.span.longitudeDelta *= 0.7
                } label: {
                    Image(systemName: "plus.magnifyingglass")
            }
                Button {
                    region.span.latitudeDelta /= 0.9
                    region.span.longitudeDelta /= 0.9
                } label: {
                    Image(systemName: "minus.magnifyingglass")
                }
            }
            .padding(.trailing, 50.0)
            .foregroundColor(.black)

        }
    }
}

struct BusinessMap_Previews: PreviewProvider {
    static var previews: some View {
        BusinessMap()
            .environmentObject(ContentModel())
    }
}

/*
    MapAnnotation(title: "test", coordinate: CLLocationCoordinate2D(latitude: 35.99688, longitude: -115.20534))
*/
