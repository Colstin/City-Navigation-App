//
//  BusinessMap.swift
//  City Navigation App
//
//  Created by Colstin Donaldson on 5/15/23.
//

import SwiftUI
import MapKit

struct MapAnnotation: Identifiable {
    let id = UUID()
    let title:String
    let coordinate: CLLocationCoordinate2D
}

struct BusinessMap: View {
    @EnvironmentObject var contentModel:ContentModel
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.999277, longitude: -115.189576), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    //@State var mapLocations = [MapAnnotation]()
    
    @State var title = ""
    @State var latitude: CLLocationDegrees =  0 //35.99688
    @State var longitude: CLLocationDegrees = 0 //-115.2053
    
    @State var mapLocations: [MapAnnotation] = []
    var body: some View {
        
//            MapAnnotation(title: "test", coordinate: CLLocationCoordinate2D(latitude: 35.99688, longitude: -115.20534))
        
        
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: mapLocations,
                annotationContent: { location in
                    
                MapMarker(coordinate: location.coordinate, tint: .red)
                
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
    
    
     func getAnnotations() {
        
        for business in contentModel.restaurants + contentModel.sights {
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                latitude = lat
                longitude = long
            }
        }
    }
    
    func testRun() {
        var location1 = MapAnnotation(title: "test", coordinate: CLLocationCoordinate2D(latitude: 35.99688, longitude: -115.20534))
        
        mapLocations.append(location1)
    }
    
}

struct BusinessMap_Previews: PreviewProvider {
    static var previews: some View {
        BusinessMap()
    }
}
