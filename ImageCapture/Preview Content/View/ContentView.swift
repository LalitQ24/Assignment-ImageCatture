//
//  ContentView.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State private var showCameraSheet = false
    @State private var showSheetGallery = false
    @State private var showAlert: Bool = false
    @State var image: Image? = nil
    @StateObject var imageViewmodel = ImageViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Rectangle().fill(Color.gray)
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .cornerRadius(20.0)
                VStack {
                    HStack(spacing: 70) {
                        VStack {
                            Image("Camera")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("Take Photo")
                                .foregroundStyle(.black)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.top, 30)
                        }
                        .onTapGesture {
                            showCameraSheet = true
                        }.fullScreenCover(isPresented: $showCameraSheet) {
                            ImagePicker(sourceType: .camera) { image in
                                self.image = Image(uiImage: image)
                                imageViewmodel.addImageInformation(imageName: "Lalit.jpeg" + UUID().uuidString, image: image, captureDate: Date())
                            }
                        }
                        VStack {
                            Image("Gallery")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("Gallery")
                                .foregroundStyle(.black)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.top, 30)
                        }
                        .onTapGesture {
                            showSheetGallery = true
                        }
                        .fullScreenCover(isPresented: $showSheetGallery) {
                            ImagePicker(sourceType: .photoLibrary) { image in
                                self.image = Image(uiImage: image)
                                imageViewmodel.addImageInformation(imageName: "Lalit.jpeg" + UUID().uuidString, image: image, captureDate: Date())
                            }
                        }
                    }
                }
            }
            .padding(.top, 40)
            .onAppear() {
                if image != nil {
                    image = nil
                }
            }
            VStack {
                if let image = self.image {
                    image
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                Button("Show Images") {
                    if image == nil {
                        showAlert = true
                    }
                    else {
                        showAlert = false
                        path.append("ShowImageList")
                    }
                }
                .frame(height: 50)
                .buttonStyle(.borderedProminent)
            }
            .alert("Please select images from Camere or Gallery", isPresented: $showAlert, actions: {})
            .padding(.top, 50)
            Spacer()
                .navigationDestination(for: String.self) { value in
                    if value == "ShowImageList" {
                        ImageListData(viewModel: imageViewmodel)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
