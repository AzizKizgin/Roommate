//
//  HomeViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import Foundation
import SwiftUI

@Observable class HomeViewModel {
    var rooms: [Room] = []
    var isLoading: Bool = false
    var showError: Bool = false
    var errorText: LocalizedStringKey = ""
    var isActive: Bool = false
    var queryObject: RoomQueryObject = RoomQueryObject()
    var totalPage:Int = 0
    
    func loadMoreContent(currentItem item: Room){
        let thresholdIndex = self.rooms.index(self.rooms.endIndex, offsetBy: -1)
        if thresholdIndex == item.id, (queryObject.page + 1) <= totalPage {
            queryObject.page += 1
            getRooms()
        }
    }
    
    init () {
        getRooms()
    }
    
    func refresh() {
        self.rooms = []
        self.totalPage = 0
        self.queryObject.page = 1
        getRooms()
    }
    
    func getRooms() {
        isLoading = true
        RoomManager.shared.getRooms(query: self.queryObject) { [weak self] result in
            defer {
                self?.isLoading = false
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("\(response.rooms.count)")
                    self?.rooms.append(contentsOf: response.rooms)
                    self?.totalPage = response.totalCount
                case .failure(let error):
                    print(error)
                    self?.setError("An error occurred while fetching data")
                    print("An error occurred while fetching data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func setError(_ message: LocalizedStringKey){
        self.showError.toggle()
        self.errorText = message
    }
    
}
