//
//  ImageView.swift
//  CombineSample
//
//  Created by home on 2021/09/07.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject private var imageloader: ImageLoader
    
    init(url: URL, cache: ImageCache? = nil) {
        imageloader = ImageLoader(url: url, cache: cache)
    }
    
    var body: some View {
        ZStack {
            if let image = imageloader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            imageloader.load()
        }
    }
}
