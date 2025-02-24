//
//  ContentView.swift
//  'Za Hunter
//
//  Created by Zane Matarieh on 2/6/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var startPosition = MapCameraPosition.userLocation(
        fallback: .automatic)
    @State private var places = [Place]()
    @State private var mapRegion = MKCoordinateRegion()
    
    
    var body: some View {
        NavigationView {
            Map(position: $startPosition) {
                
                UserAnnotation()
                
                ForEach(places) { place in
                    
                    Annotation(place.mapItem.name!, coordinate: place.mapItem.placemark.coordinate) {
                        NavigationLink(destination: LocationDetailsView(mapItem: place.mapItem)) {
                            Image("pizza")
                        }
                    }
                }
            }
            .navigationBarTitle("'Za Hunter", displayMode : .inline)
            
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .onMapCameraChange {
            context in
            mapRegion = context.region
            performSearch(item: "Pizza")
        }
        
    }
    func performSearch(item: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = item
        searchRequest.region = mapRegion
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let response = response {
                places.removeAll()
                for mapItem in response.mapItems {
                    places.append(Place(mapItem: mapItem))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


struct Place: Identifiable {
    
    let id = UUID()
    
    let mapItem: MKMapItem
    
}
