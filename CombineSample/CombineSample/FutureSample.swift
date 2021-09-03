//
//  FutureSample.swift
//  CombineSample
//
//  Created by home on 2021/08/26.
//

import SwiftUI
import Combine

struct FutureSampleView: View {
    @ObservedObject private var viewModel: FutureSampleViewModel
    
    init(viewModel: FutureSampleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("\(viewModel.count)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                if viewModel.isCountingCompleted {
                    Text("Completed!")
                        .frame(width: 220, height: 50)
                        .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                        .cornerRadius(110)
                        .shadow(color: Color(red: 0.85, green: 0.85, blue: 0.85), radius: 20)
                        .position(x: geometry.size.width / 2, y: 30)
                        .transition(.move(edge: .top))
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct FutureSampleView_Previews: PreviewProvider {
    static var previews: some View {
        FutureSampleView(viewModel: FutureSampleViewModel())
    }
}

final class FutureSampleViewModel: ObservableObject {
    @Published var count = 0
    private let endCount: Int = 20
    
    @Published var isCountingCompleted = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // カウントアップ処理の呼び出し元
        // startCounting()の戻り値であるFutureはPublishersの一種であるため、
        // Operatorsで値を変換したり、Subscribersで値を受け取ることができる
        startCounting()
            // startCounting()の処理内でpromiseが呼ばれると以下の処理を実行する
            .sink { _ in
                withAnimation(.easeOut(duration: 0.8)) {
                    self.isCountingCompleted = true
                }
                self.cancellables.removeAll()
            }
            .store(in: &cancellables)
        
        //        startCounting() { [weak self] in
        //            // startCounting()の処理内でcompletionHandler()が呼ばれると以下の処理を実行する
        //            guard let self = self else { return }
        //
        //            withAnimation(.easeOut(duration: 0.8)) {
        //                self.isCountingCompleted = true
        //            }
        //            self.cancellables.removeAll()
        //        }
    }
    
    // カウントアップ処理
    func startCounting() -> Future<Void, Never> {
        return Future() { promise in
            Timer.publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .receive(on: RunLoop.main)
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    
                    if self.count < self.endCount {
                        self.count += 1
                    } else {
                        // カウントアップが完了した時点でpromiseを実行する
                        // promiseを実行するとFutureは値を発行（公開）する
                        promise(.success(()))
                    }
                }
                .store(in: &self.cancellables)
        }
    }
    
    //    func startCounting(completionHandler: @escaping () -> Void) {
    //        Timer.publish(every: 0.1, on: .main, in: .common)
    //            .autoconnect()
    //            .receive(on: RunLoop.main)
    //            .sink { [weak self] _ in
    //                guard let self = self else { return }
    //
    //                if self.count < self.endCount {
    //                    self.count += 1
    //                } else {
    //                    // 処理が終了した時点でcompletionHandler()を呼ぶ
    //                    completionHandler()
    //                }
    //            }
    //            .store(in: &self.cancellables)
    //    }
}
