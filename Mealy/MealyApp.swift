//
//  MealyApp.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import SwiftUI

@main
struct MealyApp: App {
    
    @StateObject var userStateViewModel = FlowViewModel()

    var body: some Scene {
        WindowGroup {
            AppFlowView()
                .environmentObject(userStateViewModel)
        }
    }
}
