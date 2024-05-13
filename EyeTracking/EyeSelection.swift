//
//  EyeSelection.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 06/05/24.
//


import SwiftUI

//allowing the users to choose their dominant eye

struct EyeSelection: View {
    
    @State var LeftisWinking: Bool = false
    @State var RightisWinking: Bool = false
    
    @State var SmileLeftCheck: Bool = false
    @State var SmileRightCheck: Bool = false
    
    //cards array
    
    @State var viewModel : EyesViewModel
    @State private var currentIndex : Int = 0
    
    //scrolling function
    
    func scroll() {
        if (RightisWinking == false && LeftisWinking == true) {
            withAnimation {
                if(currentIndex < viewModel.eyes.count - 1){
                    currentIndex = currentIndex + 1
                } else {
                    currentIndex = 0
                }
            }
        }
    }
    
    
    
    func chooseEye() {
        
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack() {
                
                Text("Blink with the right or the left eye to scroll the selection.")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
                
                //Spacer(minLength: 50)
                
                ZStack(){
                    
                    ForEach(0..<viewModel.eyes.count, id: \.self) { index in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 170, height: 170)
                            .foregroundStyle(.white)
                            .opacity(currentIndex == index ? 1.0 : 0.3)
                            .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 190)
                            .shadow(radius: 5)
                        
                        VStack(spacing: 10) {
                            
                            Text(viewModel.eyes[index].position)
                                .bold()
                            Image(systemName: viewModel.eyes[index].image)
                            
                            
                            
                        } .font(.largeTitle)
                            .foregroundStyle(.black)
                            .offset(x: CGFloat(index - currentIndex) * 190)
                            .opacity(currentIndex == index ? 1.0 : 0.3)
                        
                    } .onChange(of: LeftisWinking) {
                        
                        scroll()
                    }
                    
                }
            
               
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
    EyeSelection(viewModel: EyesViewModel())
}

