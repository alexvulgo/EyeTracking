//
//  SceneContainerView.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 14/05/24.
//

import SwiftUI

struct SceneContainerView: View {
    
    @EnvironmentObject var stateManager : StateManager
    
    var body: some View {
        
        
        switch(stateManager.currentState){
            
        case .onboarding:
            OnboardingView()
                .environmentObject(stateManager)
            
            
        case .firstView:
            ContentView(viewModel: itemViewModel())
                .environmentObject(stateManager)
            
        }
        
        
        
    }
}


