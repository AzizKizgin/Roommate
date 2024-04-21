//
//  FilterSelectionView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 20.04.2024.
//

import SwiftUI

private struct Filters {
    var minPrice: String = ""
    var maxPrice: String = ""
    var roomCounts: [Int] = []
    var bathCounts: [Int] = []
    var minSize: String = ""
    var maxSize: String = ""
    var town: String = ""
    var city: String = ""
}

struct FilterSelectionView: View {
    @Binding var queryObject: RoomQueryObject
    @Environment(\.dismiss) private var dismiss
    @State private var filters: Filters = Filters()
    var body: some View {
        List{
            Section("Price") {
                HStack(spacing:20){
                    FormInput("", text: $filters.maxPrice, icon: "turkishlirasign")
                        .fieldHeight(10)
                        .header("min")
                        .iconSize(.callout)
                    FormInput("", text: $filters.minPrice, icon: "turkishlirasign")
                        .fieldHeight(10)
                        .header("max")
                        .iconSize(.callout)
                }
            }
            Section("Size"){
                HStack(spacing:20) {
                    FormInput("", text: $filters.maxSize, icon: "ruler.fill")
                        .fieldHeight(10)
                        .header("min")
                        .iconSize(.callout)
                    FormInput("", text: $filters.minSize, icon: "ruler.fill")
                        .fieldHeight(10)
                        .header("max")
                        .iconSize(.callout)
                }
            }
            Section("Room Count") {
                HStack {
                    ForEach(1...5, id: \.self) { count in
                        let isSelected = filters.roomCounts.contains(count)
                        Text("\(count)")
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .foregroundStyle(.white)
                            .background(isSelected ? Color.accentColor : Color.gray)
                            .clipShape(Capsule())
                            .onTapGesture {
                                if isSelected {
                                    if let index = filters.roomCounts.firstIndex(of: count) {
                                        filters.roomCounts.remove(at: index)
                                    }
                                } else {
                                    filters.roomCounts.append(count)
                                }
                            }
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section("Bath Count") {
                HStack {
                    ForEach(1...5, id: \.self) { count in
                        let isSelected = filters.bathCounts.contains(count)
                        Text("\(count)")
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .foregroundStyle(.white)
                            .background(isSelected ? Color.accentColor : Color.gray)
                            .clipShape(Capsule())
                            .onTapGesture {
                                if isSelected {
                                    if let index = filters.bathCounts.firstIndex(of: count) {
                                        filters.bathCounts.remove(at: index)
                                    }
                                } else {
                                    filters.bathCounts.append(count)
                                }
                            }
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section("Address")  {
                HStack(spacing:20) {
                    FormInput("Town", text: $filters.town, icon: "map.circle.fill")
                        .fieldHeight(10)
                        .header("Town")
                        .iconSize(.callout)
                    FormInput("City", text: $filters.city, icon: "map.circle.fill")
                        .fieldHeight(10)
                        .header("City")
                        .iconSize(.callout)
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: saveChanges, label: {
                    Text("Save")
                })
            }
        }
    }
}

extension FilterSelectionView {
    private func saveChanges() {
        if !filters.minPrice.isEmpty {
            self.queryObject.minPrice = Double(filters.minPrice)
        }
        if !filters.maxPrice.isEmpty {
            self.queryObject.maxPrice = Double(filters.maxPrice)
        }
        if !filters.minSize.isEmpty {
            self.queryObject.minSize = Double(filters.minSize)
        }
        if !filters.maxSize.isEmpty {
            self.queryObject.maxSize = Double(filters.maxSize)
        }
        if !filters.roomCounts.isEmpty {
            self.queryObject.roomCounts = filters.roomCounts
        }
        if !filters.bathCounts.isEmpty {
            self.queryObject.bathCounts = filters.bathCounts
        }
        if !filters.town.isEmpty {
            self.queryObject.town = filters.town
        }
        if !filters.city.isEmpty {
            self.queryObject.city = filters.city
        }
        dismiss()
    }
}

#Preview {
    NavigationStack {
        FilterSelectionView(queryObject: .constant(RoomQueryObject()))
    }
}
