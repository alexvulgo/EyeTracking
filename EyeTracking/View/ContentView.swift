//
//  ContentView.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    
    //Eyes Check Variable
    
    @State var LeftisWinking: Bool = false
    @State var RightisWinking: Bool = false
    
    //Smile Check Variable
    
    @State var SmileLeftCheck: Bool = false
    @State var SmileRightCheck: Bool = false
    
    //Array
    
    @State var viewModel : itemViewModel
    @State private var currentIndex : Int = 0
    
    //Scrolling functions
    //Con la camera gli occhi risultano specchiati quindi scroll destra -> left blink, scroll sinistra -> right blink
    
    func scroll_right() {
        if (RightisWinking == false && LeftisWinking == true) {
            withAnimation {
                if(currentIndex < viewModel.items.count - 1){
                    currentIndex = currentIndex + 1
                } else {
                    currentIndex = 0
                }
            }
        }
    }
    
    
    func scroll_left() {
        if (RightisWinking == true && LeftisWinking == false) {
            withAnimation {
                if(currentIndex <= viewModel.items.count - 1 && currentIndex > 0){
                    currentIndex = currentIndex - 1
                } else {
                    currentIndex = viewModel.items.count-1
                }
            }
        }
    }
    
    //Confirm function
    
    func confirm() {
        
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack() {
                
                Spacer(minLength: 50)
                
                ZStack(){
                    
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 200)
                            .foregroundStyle(.white)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.1 : 0.9)
                            .offset(x: CGFloat(index - currentIndex) * 220)
                            .shadow(radius: 5)
                        
                        
                        // Scroll Selection
                        
                    } .onChange(of: LeftisWinking) {
                        scroll_right()
                    }
                    
                    .onChange(of: RightisWinking) {
                        scroll_left()
                    }
                    
                    
                } .padding(.vertical)
                
                Spacer(minLength: 50)
                
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
            .navigationTitle("Eye tracking app")
        }
        
    }
    
}




#Preview {
    ContentView(viewModel: itemViewModel())
}
