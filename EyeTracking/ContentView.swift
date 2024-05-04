//
//  ContentView.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var LeftisWinking: Bool = false
    @State var RightisWinking: Bool = false
    
    //cards array
    
    var cards : [Color] = [.white,.white,.white]
    
    //cards Animation
    
    @State private var currentIndex : Int = 0
    //@State private var dragOffset : CGFloat = 5
    
    func ArrayLoop () {
        
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack() {
                
                Spacer(minLength: 50)
                
                //scrolling cards
                
                ZStack(){
                    
                    ForEach(0..<cards.count, id: \.self) { index in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 200)
                            .foregroundStyle(cards[index])
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.1 : 0.9)
                            .offset(x: CGFloat(index - currentIndex) * 220 , y: 0)
                            .shadow(radius: 5)
                            
                        
                     // Scroll Selection
                    
                } .onChange(of: LeftisWinking) {
                    if (RightisWinking == false && LeftisWinking == true && currentIndex < 2) {
                        withAnimation {
                            currentIndex = currentIndex + 1
                            
                        }
                        
                    } else if (RightisWinking == false && LeftisWinking == true && currentIndex == 2) {
                        currentIndex = 0
                        
                    }
                }
                    
                    
                    
                    
                    
                    
                    
                } .padding(.vertical)
                
                
                
                Spacer(minLength: 50)
                
                
                
                //Camera position
                CustomContainer(LeftisWinking: $LeftisWinking, RightisWinking: $RightisWinking)
                    .ignoresSafeArea()
                
                
                
                
            }
            .navigationTitle("Eye tracking app")
        }
        
    }
    
}




#Preview {
    ContentView()
}
