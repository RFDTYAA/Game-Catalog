import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedPhotoItem: PhotosPickerItem?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Nama")) {
                    TextField("Nama Anda", text: $viewModel.name)
                }

                Section(header: Text("Edit Foto")) {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                    }
                    
                    PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                        Label("Pilih Foto Profil Baru", systemImage: "photo.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
            }
            .onChange(of: selectedPhotoItem) {
                viewModel.processSelectedPhoto(item: selectedPhotoItem)
            }
            .navigationTitle("Edit Profil")
            .navigationBarItems(
                leading: Button("Batal") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Simpan") {
                    viewModel.saveProfile()
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
