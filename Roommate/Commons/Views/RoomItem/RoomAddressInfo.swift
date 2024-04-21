//
//  RoomAddressInfo.swift
//  Roommate
//
//  Created by Aziz Kızgın on 19.04.2024.
//

import SwiftUI

struct RoomAddressInfo: View {
    let address: RoomAddress
    var body: some View {
        VStack{
            Text("\(address.town), \(address.city)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(address.street), no: \(address.buildingNo) / \(address.apartmentNo) ")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    RoomAddressInfo(address: testRoom.address)
}
