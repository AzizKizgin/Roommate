//
//  RoomMap.swift
//  Roommate
//
//  Created by Aziz Kızgın on 19.04.2024.
//

import SwiftUI
import MapKit

struct RoomMap: View {
    let address: RoomAddress
    var body: some View {
        VStack {
            let initialLocation: CLLocationCoordinate2D = .init(latitude: address.latitude, longitude: address.longitude)
            let position: MapCameraPosition = .camera(.init(centerCoordinate: initialLocation, distance: 2000))
            Map(position: .constant(position), interactionModes: .zoom){
                Annotation("", coordinate: initialLocation) {
                    Image(systemName: "house.circle.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .background(Circle().foregroundStyle(.accent))
                }
            }
        }
    }
}

#Preview {
    RoomMap(address: testRoom.address)
}
