//
//  ImageLoader.swift
//  CombineSample
//
//  Created by home on 2021/09/07.
//

import UIKit
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL
    private var cache: ImageCache?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    func load() {
        if let cache = cache?[url as AnyObject] {
            self.image = cache
        } else {
            fetchImage(url: url)
                .receive(on: RunLoop.main)
                .sink(receiveValue: {
                    self.image = $0
                    self.addCache($0)
                })
                .store(in: &cancellables)
        }
    }
    
    private func fetchImage(url: URL) -> Future<UIImage, Never> {
        return Future() { promise in
            URLSession.shared.dataTaskPublisher(for: url)
                .compactMap { UIImage(data: $0.data) }
                .sink(receiveCompletion: {
                    print("completion: \($0)")
                }, receiveValue: {
                    promise(.success($0))
                })
                .store(in: &self.cancellables)
        }
    }
    
    private func addCache(_ image: UIImage?) {
        image.map { cache?[url as AnyObject] = $0 }
    }
}
