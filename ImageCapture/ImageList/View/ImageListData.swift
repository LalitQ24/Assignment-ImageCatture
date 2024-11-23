//
//  ImageListData.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import SwiftUI
import RealmSwift
import Combine

struct ImageListData: View {
    @ObservedObject var viewModel: ImageViewModel
    @ObservedObject var combineViewModel = CombineViewModel()
    var body: some View {
        List {
            ForEach(viewModel.imageListData, id: \.id) {
                imageData in
                let image = viewModel.imageHelper.getImageFromPath(imagePath: imageData.imagePath ?? "")
                if let image = image {
                    let img = Image(uiImage: image)
                    img
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .cornerRadius(5.0)
                        .overlay(
                            ZStack {
                                VStack(alignment: .trailing, content: {
                                    Button {
                                        let data = image.jpegData(compressionQuality: 1.0)
                                        if let data = data {
                                            let object = ObjectWithImage.init(id: UUID(), name: imageData.imageName ?? "" , imageData: data,imageCatureDate: imageData.imageCaptureDate ?? Date())
                                            Publishers.uploadObjectQueue.send(object)
                                            combineViewModel.uploadImageToServer()
                                        }
                                        
                                    } label: {
                                        Text("Upload")
                                            .foregroundStyle(.red)
                                    }
                                })
                                .background(.white)
                                .frame(maxWidth: .infinity,idealHeight: 40, alignment: .trailing)
                                .padding(.trailing, 20)
                                
                            })
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ImageListData(viewModel: ImageViewModel())
}
