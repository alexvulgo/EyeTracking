//
//  EyeTrackingApp.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 02/05/24.
//

import SwiftUI


enum AppState {
    case onboarding
    case firstView
}


class StateManager: ObservableObject{
    
    @Published var currentState = AppState.onboarding
    
}
    


@main
struct EyeTrackingApp: App {
    
    private var stateManager = StateManager()
    
    init() {
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            SceneContainerView()
                .environmentObject(stateManager)
        }
    }
}
