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
                        Text("This test use ARKit face tracking for let the user use the app without using hands.")
                        
                    
                    
                    Image(systemName: "eye.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                        .padding()
                    
                    Text("Eyes detection")
                        .bold()
                    Text("Use the blink of your eyes to scroll right or left.")
                    
                    Image(systemName: "smiley.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.green)
                        .padding()
                    
                    Text("Smile detection")
                        .bold()
                    Text("Keep your smile for 2 seconds to confirm your selection.")
                        
                    
                    
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

