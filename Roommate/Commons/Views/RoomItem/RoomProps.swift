//
//  RoomProps.swift
//  Roommate
//
//  Created by Aziz Kızgın on 19.04.2024.
//

import SwiftUI

struct RoomProps: View {
    let price: Double
    let size: Double
    let roomCount: Int
    let bathCount: Int
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "turkishlirasign")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                Text("\(String(format: "%.2f", price))")
            }
            Spacer()
            HStack{
                Image(systemName: "ruler.fill")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                Text("\(String(format: "%.1f", size)) m²")
            }
            Spacer()
            HStack{
                Image(systemName: "bed.double.fill")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                Text("\(String(roomCount))")
            }
            Spacer()
            HStack{
                Image(systemName: "bathtub.fill")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                Text("\(String(bathCount))")
            }
        }
    }
}

#Preview {
    RoomProps(price: 1500.00, size: 79.4, roomCount: 2, bathCount: 4)
}
