//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
            }
            .store(in: &cancellables)
    }
    
    }
    
    //    }
}
