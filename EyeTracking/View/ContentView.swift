//
//  ContentView.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var stateManager: StateManager
    
    //Eyes Check Variable
    
    @State var LeftisWinking: Bool = false
    @State var RightisWinking: Bool = false
    
    //Smile Check Variable
    
    @State var SmileLeftCheck: Bool = false
    @State var SmileRightCheck: Bool = false
    
    @State var viewModel : itemViewModel
    @State private var currentIndex : Int = 0
    
    @State private var selection = "Not selected"
    
    @State private var count = 0
    
    @State private var timer: Timer? //timer used for countdown
    @State private var counter = 2 //the user have to mantain the position for 5 seconds
    
    @State private var load : Bool = false
    
    //Scrolling functions
    
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
        
        if (load == false){
            load = true
            startCountdown()
        } else if (load == true) {
            load = false
            resetCountdown()
        }
        
    }
    
    //Timer functions
    
    func resetCountdown() {
        counter = 2
        
        if ((timer?.isValid) != nil)  {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            counter -= 1
            
            if(counter == 0){
                timer?.invalidate()
                timer = nil
                
                if(viewModel.items[currentIndex].selection == "Back") {
                    back()
                }
                
                if(viewModel.items[currentIndex].selection == "Not selected") {
                    viewModel.items[currentIndex].selection = "Selected"
                } else {
                    viewModel.items[currentIndex].selection = "Not selected"
                }
                
               
                    
                
                resetCountdown()
              
            }
        }
    }
    
    func back() {
        stateManager.currentState = .onboarding
    }
    
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack() {
                
                Spacer(minLength: 30)
                
                ZStack(){
                    
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 200)
                            .foregroundStyle(viewModel.items[index].color)
                            .opacity(viewModel.items[index].selection == "Selected" ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.1 : 0.9)
                            .offset(x: CGFloat(index - currentIndex) * 220)
                            .shadow(radius: 5)
                        
                        
                        
                        Text(viewModel.items[index].selection)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
                            .offset(x: CGFloat(index - currentIndex) * 220)
                        
                        // Scroll Selection
                        
                    } .onChange(of: LeftisWinking) {
                        scroll_right()
                    }
                    
                    .onChange(of: RightisWinking) {
                        scroll_left()
                    }
                    
                    .onChange(of: SmileLeftCheck || SmileRightCheck){
                        confirm()
                    }
                    
                    
                } .padding(.vertical)
                
               
                Text(counter.description)
                    .font(.title2)
                    .padding()
                    .bold()
                
                Spacer()
                
                ZStack() {
                    //Camera position
                    CustomContainer(LeftisWinking : $LeftisWinking , RightisWinking : $RightisWinking , SmileLeftCheck : $SmileLeftCheck, SmileRightCheck : $SmileRightCheck)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        Text(SmileLeftCheck || SmileRightCheck ? "Smiling" : "Not Smiling")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial)
                                .stroke(SmileLeftCheck || SmileRightCheck ? .green : .red,lineWidth: 2))
                        
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
