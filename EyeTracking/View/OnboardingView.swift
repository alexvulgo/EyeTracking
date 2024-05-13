//
//  OnboardingView.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 08/05/24.
//

import SwiftUI

struct OnboardingView: View {
        
        @State var LeftisWinking: Bool = false
        @State var RightisWinking: Bool = false
        
        @State var SmileLeftCheck: Bool = false
        @State var SmileRightCheck: Bool = false
        
        var body: some View {
            
      
                
                VStack() {
                    
                    
                    
                    
                    VStack(alignment: .center){
                        Image(systemName: "faceid")
                            .font(.title)
                            .foregroundStyle(.blue)
                            .padding()
                        Text("This test use ARKit face tracking for let the user use the app without using hands.")
                            .bold()
                        
                    }
                    
                    
                    
                    VStack(alignment: .center){
                        Image(systemName: "eye.circle")
                            .font(.title)
                            .foregroundStyle(.red)
                            .padding()
                        Text("Use the blink of your eyes for scroll the selection.")
                            .bold()
                        
                    }
                    
                    VStack(alignment: .center){
                        Image(systemName: "smiley")
                            .font(.title)
                            .foregroundStyle(.green)
                            .padding()
                        Text("Smile for confirm your chooice.")
                            .bold()
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }.padding()
                ZStack() {
                    
                    
                    
                    
                    
                    //Camera position
                    CustomContainer(LeftisWinking : $LeftisWinking , RightisWinking : $RightisWinking , SmileLeftCheck : $SmileLeftCheck, SmileRightCheck : $SmileRightCheck)
                        .ignoresSafeArea()
                    
                    
                    VStack {
                        
                        Spacer()
                        Text(SmileLeftCheck || SmileRightCheck ? "Smiling" : "Not Smiling")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
                        
                    }
                    
                 
               
                }
                
            }
            
        
    }
                
                
               
                
                
                
     

#Preview {
    OnboardingView()
}

