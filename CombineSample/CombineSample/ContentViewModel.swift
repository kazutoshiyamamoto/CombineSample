//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
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
                        promise(Result.success(()))
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
