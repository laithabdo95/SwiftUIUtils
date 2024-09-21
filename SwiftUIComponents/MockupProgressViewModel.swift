//
//  MockupProgressViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 18/09/2024.
//

import SwiftUI

class MockupProgressViewModel: ProgressLoaderConfigurable {
    internal var buttonTitle: String { "Finalize" }
    
    @Published private(set) var message: String
    @Published private(set) var current: Int
    @Published private(set) var hasFinished = false
    
    private(set) var total: Int
    var color: Color = .indigo
    internal var items: [Mockup]
    var onComplete: (() -> Void)? = nil
    var timer: Timer?
    
    required init(items: [Mockup]) {
        self.message = "Uploading Attachments.."
        self.hasFinished = false
        self.items = items
        self.current = 0
        self.total = items.count
    }
    
    func execute() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            guard self.current < self.total else {
                self.timer?.invalidate()
                self.timer = nil
                withAnimation {
                    self.hasFinished = true
                    self.message = "Uploading Done.."
                }
                return
            }
            withAnimation {
                self.current += 1
            }
        })
    }
}
