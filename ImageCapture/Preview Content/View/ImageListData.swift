//
//  ImageListData.swift
//  ImageCapture
//
//  Created by Lalit Kumar on 22/11/24.
//

import SwiftUI
import RealmSwift
struct ImageListData: View {
    @ObservedObject var viewModel: ImageViewModel
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
                                    } label: {
                                        Text("Upload ")
                                            .foregroundStyle(.red)
                                    }
                                })
                                .background(.white)
                                .frame(maxWidth: .infinity,idealHeight: 40, alignment: .trailing)
                                .padding(.trailing, 20)
                               
                            }
                            
//
                        )
                }
            }
        }
        .onAppear() {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ImageListData(viewModel: ImageViewModel())
}
