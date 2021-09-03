//
//  SubjectSample.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import Foundation
import SwiftUI
import Combine

struct SubjectSampleView: View {
    @ObservedObject private var viewModel: SubjectSampleViewModel
    
    init(viewModel: SubjectSampleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TextField("Search", text: $viewModel.text)
            .frame(width: 300, height: 50)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        
        //        Button("Sample") {
        //            viewModel.onTapped()
        //        }
    }
}

struct SubjectSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectSampleView(viewModel: SubjectSampleViewModel())
    }
}

final class SubjectSampleViewModel: ObservableObject {
    @Published var text = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    //    private lazy var subject = PassthroughSubject<Int, Error>()
    
    private lazy var subject = PassthroughSubject<String, Never>()
    
    enum SampleError: Error {
        case error
    }
    
    init() {
        $text
            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink {
                self.subject.send($0)
            }
            .store(in: &cancellables)
        
        subject
            .sink(receiveCompletion: {
                print ("completion:\($0)")
            },
            receiveValue: {
                print("\($0)")
            })
            .store(in: &cancellables)
    }
    
    //    func onTapped() {
    //        // sendの挙動チェック
    //        let randomNumber = Int.random(in: 1...10)
    //        subject.send(randomNumber)
    
    // 終了する挙動を確認したい場合は、以下のコメントアウトを外す
    //        subject.send(completion: .finished)
    
    // エラーで終了する挙動を確認したい場合は、以下のコメントアウトを外す
    //        subject.send(completion: .failure(SampleError.error))
    //    }
}
