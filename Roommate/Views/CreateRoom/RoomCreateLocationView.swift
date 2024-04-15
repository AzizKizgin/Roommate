//
//  RoomLocationView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 13.04.2024.
//

import SwiftUI
import MapKit
import CoreLocation

private let initialLocation: CLLocationCoordinate2D = .init(latitude: 41.015137, longitude: 28.979530)
let initialPosition: MapCameraPosition = .camera(.init(centerCoordinate: initialLocation, distance: 30000))

struct RoomCreateLocationView: View {
    @Namespace private var mapScope
    @State private var position: MapCameraPosition = initialPosition
    @State private var searchText: String = ""
    @State private var searchResults: [MKMapItem] = []
    @State private var selection: MKMapItem?
    @State private var selectedLocation: CLLocationCoordinate2D?

    var body: some View {
        MapReader{ reader in
            Map(position: $position,selection: $selection,scope: mapScope){
                UserAnnotation()
                ForEach(searchResults, id: \.self) { result in
                    Marker(result.name ?? "", coordinate: result.placemark.coordinate)
                }
                if let selectedLocation {
                    Annotation("", coordinate: selectedLocation) {
                        Image(systemName: "house.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white)
                            .background(Circle().foregroundStyle(.accent))
                    }
                }
            }
            .onChange(of: selection, { _, newValue in
                if let newValue {
                    self.selectedLocation = newValue.placemark.coordinate
                }
            })
            .onTapGesture { screenCoord in
                if let location = reader.convert(screenCoord, from: .local) {
                    self.selectedLocation = location
                }
            }
            .safeAreaInset(edge: .bottom, content: {
                HStack{
                    Spacer()
                    MapUserLocationButton(scope: mapScope)
                }
                .padding(.horizontal)
                .buttonBorderShape(.circle)
             
            })
            .safeAreaInset(edge: .top, content: {
                HStack{
                    SearchField(text: $searchText)
                }
                .padding()
            })
            .onSubmit(of: .text) {
                Task {
                    await searchLocation()
                }
            }
            .mapScope(mapScope)
            .onAppear{
                UINavigationBar.appearance().backgroundColor = .accent
                CLLocationManager().requestWhenInUseAuthorization()
                if CLLocationManager().authorizationStatus == .authorizedWhenInUse {
                    position = .userLocation(fallback: .automatic)
                }
            }
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    if selectedLocation != nil  {
                        Button("Next") {
 
                        }
                    }
                }
            }
            .navigationTitle("Select Location")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

extension RoomCreateLocationView {
    private func searchLocation() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let results = try? await MKLocalSearch(request: request).start()
        self.searchResults = results?.mapItems ?? []
        if let firstResult = results?.mapItems.first {
            self.position = .camera(.init(centerCoordinate: firstResult.placemark.coordinate, distance: 300))
        }
       
    }
}

#Preview {
    NavigationStack{
        RoomCreateLocationView()
    }
}
