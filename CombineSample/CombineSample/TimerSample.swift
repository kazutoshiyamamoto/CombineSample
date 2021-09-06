//
//  TimerSample.swift
//  CombineSample
//
//  Created by home on 2021/08/23.
//

import Foundation
import SwiftUI
import Combine

struct TimerSampleView: View {
    @ObservedObject private var viewModel: TimerSampleViewModel
    
    init(viewModel: TimerSampleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
//            Button("Start") {
//                viewModel.startCounting()
//            }
//            .disabled(viewModel.isTimerRunning)
//
//            Button("Stop") {
//                viewModel.stopCounting()
//            }
//            .disabled(!viewModel.isTimerRunning)
//            .padding()
//
//            Button("Reset") {
//                viewModel.resetCount()
//            }
        }
    }
}

struct TimerSampleView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSampleView(viewModel: TimerSampleViewModel())
    }
}

final class TimerSampleViewModel: ObservableObject {
    @Published var count = 0

    private let endCount: Int = 10000
    
    //    @Published var isTimerRunning = false
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = Timer.publish(every: 0.02, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                let additionNumber = Int(ceil(Double(self.endCount) / 50.0))
                
                if self.count < self.endCount {
                    self.count += additionNumber
                } else {
                    self.count = self.endCount
                    self.cancellable?.cancel()
                }
            }
    }
    
    //    func startCounting() {
    //        isTimerRunning = true
    //        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
    //            .autoconnect()
    //            .sink { _ in
    //                self.count += 1
    //            }
    //    }
    //
    //    func stopCounting() {
    //        isTimerRunning = false
    //        cancellable?.cancel()
    //    }
    //
    //    func resetCount() {
    //        count = 0
    //    }
}
