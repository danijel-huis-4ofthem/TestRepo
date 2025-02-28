//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by Danijel Huis on 26.02.2025..
//

import SwiftUI
import Module1
import Module2

@main
struct DemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            Button("Tap") {
                Module1Manager.debug()
                Module2Manager.debug()
            }
        }
    }
}
