//
//  OnboardingView.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 08/05/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var stateManager: StateManager
    
    func start() {
        stateManager.currentState = .firstView
    }

        var body: some View {
            
            Spacer()
            
            VStack() {
                
                Text("What to test")
                    .bold()
                    .font(.largeTitle)
                
                VStack(alignment: .center){
                    Image(systemName: "arkit")
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .padding()
                        
                 
                        Text("Face tracking")
                            .bold()
                        Text("This test uses ARKit face tracking to let users interact without using hands.")
                        .multilineTextAlignment(.center)
                        
                    
                    
                    Image(systemName: "eye.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                        .padding()
                    
                    Text("Eyes detection")
                        .bold()
                    Text("Use your eyes to scroll.")
                        .multilineTextAlignment(.center)
                    Text("Right blink: scroll right")
                        .multilineTextAlignment(.center)
                    Text("Left blink: scroll left")
                        .multilineTextAlignment(.center)
                    
                    Image(systemName: "smiley.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.green)
                        .padding()
                    
                    Text("Smile detection")
                        .bold()
                    Text("Smile for two seconds to confirm your selection.")
                        .multilineTextAlignment(.center)
                        
                    
                    
                }.padding()
                  
                
            }.padding()
            
            Spacer()
                
            Button(action: {
                           
                           start()
                           
                       }, label: {
                           Text("Start test")
                               .font(.headline)
                               .foregroundColor(.white)
                               .padding()
                               .background(Color.blue)
                               .cornerRadius(10)
                       })
                       .padding(.bottom, 50)
                    
        }
                    
                 
               
                
                
            
            
        
}
                
                
               
                
                
                
     

#Preview {
    OnboardingView()
}

