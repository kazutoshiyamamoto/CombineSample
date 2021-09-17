//
//  CombineSampleApp.swift
//  CombineSample
//
//  Created by home on 2021/07/08.
//

import SwiftUI

@main
struct CombineSampleApp: App {
    var body: some Scene {
        WindowGroup {
            TimerSampleView(viewModel: TimerSampleViewModel())
        }
    }
}
