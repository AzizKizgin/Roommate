//
//  CreateRoomViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable class CreateRoomViewModel {
    var room: RoomUpsertInfo = RoomUpsertInfo()
    var screen: CreateRoomScreen = .location
    var roomPickerItems: [PhotosPickerItem] = []
    var showError: Bool = false
    var errorText: String = ""
    var isLoading: Bool = false
    var responseRoom: Room? = nil
    
    func goScreen(_ screen: CreateRoomScreen) {
        DispatchQueue.main.async {
            self.screen = screen
        }
    }
    
    func setCoordinate(coordinate: CLLocationCoordinate2D) {
        Utils.getAddressFromLatLong(coordinate: coordinate) { [weak self] address in
            guard let address = address else {
                DispatchQueue.main.async {
                    self?.setError("Connot convert coordinates")
                }
                return
            }
            self?.room.address = address
            self?.goScreen(.photo)
        }
    }
    
    func setImages() async {
        Task {
            defer {
                if !roomPickerItems.isEmpty {
                    self.goScreen(.detail)
                }
                else{
                    self.setError("Error occured while processing images")
                }
            }
            self.room.images = []
            for item in roomPickerItems{
                if let loadedData = try? await item.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: loadedData) {
                        ImageManager.shared.convertImageToString(for: uiImage) { [weak self]  imageString in
                            if let imageString {
                                self?.room.images.append(imageString)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func saveRoom() {
        guard validateRoom() else {
            return
        }
        RoomManager.shared.createRoom(roomData: self.room) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let room):
                    self?.responseRoom = room
                    print("sss")
                case .failure(let error):
                    print(error)
                    self?.setError(error.localizedDescription)
                }
            }
        }
    }
    
    private func validateRoom() -> Bool {
        if self.room.address.street.isEmpty ||
            self.room.address.city.isEmpty ||
            self.room.address.town.isEmpty ||
            self.room.address.country.isEmpty ||
            self.room.address.buildingNo.isEmpty ||
            self.room.address.apartmentNo.isEmpty ||
            self.room.address.zipCode.isEmpty ||
            self.room.price.isEmpty ||
            self.room.roomCount.isEmpty ||
            self.room.bathCount.isEmpty ||
            self.room.size.isEmpty ||
            self.room.about.isEmpty {
            setError("Please fill all fields")
            return false
        }
        if self.room.images.isEmpty {
            setError("Please add image for your room")
            return false
        }
        if self.room.address.latitude == 0.0 && self.room.address.longitude == 0.0 {
            setError("Something wrong with your location")
            return false
        }
        return true
    }
    
    private func setError(_ message: String){
        self.showError.toggle()
        self.errorText = message
    }
}
