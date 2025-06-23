import Foundation
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var name: String
    @Published var profileImage: Image?
    
    private var imageData: Data?
    
    private let nameKey = "profile_name_key"
    private let imageKey = "profile_image_data_key"

    init() {
        
        self.name = UserDefaults.standard.string(forKey: nameKey) ?? "Muhammad Rafi Aditya"
        if let data = UserDefaults.standard.data(forKey: imageKey) {
            self.imageData = data
            if let uiImage = UIImage(data: data) {
                self.profileImage = Image(uiImage: uiImage)
            }
        }
    }

    func saveProfile() {
        UserDefaults.standard.set(name, forKey: nameKey)
        if let data = imageData {
            UserDefaults.standard.set(data, forKey: imageKey)
        }
        print("✅ Profile saved.")
    }
    
    func processSelectedPhoto(item: PhotosPickerItem?) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                self.imageData = data
                if let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        self.profileImage = Image(uiImage: uiImage) 
                    }
                }
            }
        }
    }
}
