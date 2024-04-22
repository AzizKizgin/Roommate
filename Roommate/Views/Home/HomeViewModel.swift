//
//  HomeViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import Foundation

@Observable class HomeViewModel {
    var rooms: [Room] = []
    var isLoading: Bool = false
    var showError: Bool = false
    var errorText: String = ""
    var queryObject: RoomQueryObject = RoomQueryObject()
    var totalPage:Int = 0
    
    init () {
        Task {
            await getRooms()
        }
    }
    func loadMoreContent(currentItem item: Room) async{
        let thresholdIndex = self.rooms.index(self.rooms.endIndex, offsetBy: -1)
        if thresholdIndex == item.id, (queryObject.page + 1) <= totalPage {
            queryObject.page += 1
            await getRooms()
        }
    }
    
    func refresh() async{
        self.rooms = []
        self.totalPage = 0
        self.queryObject.page = 1
        await getRooms()
    }
    
    func getRooms() async{
        isLoading = true
        RoomManager.shared.getRooms(query: self.queryObject) { [weak self] result in
            guard let self else {return}
            defer {
                self.isLoading = false
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.rooms.append(contentsOf: response.rooms)
                    self.totalPage = response.totalPage
                case .failure(let error):
                    self.setError(error.localizedDescription)
                }
            }
        }
    }
    
    private func setError(_ message: String){
        self.showError.toggle()
        self.errorText = message
    }
    
}
