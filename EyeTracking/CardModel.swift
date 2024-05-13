//
//  CardModel.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 06/05/24.
//

import SwiftUI
import Observation

struct Card : Identifiable {
    var id: UUID = UUID()
    var name: String
    var description : String
}

struct Eye : Identifiable, Equatable {
    var id: UUID = UUID()
    var position: String
    var image : String
}


@Observable class EyesViewModel {
    
    var eyes = [
        Eye(position:"Left",image: "eye.circle"),Eye(position:"Right",image: "eye.circle")
    ]
}

@Observable class CardViewModel {
    
    var mainCards = [
        Card(name:"card 1",description: "Test"),Card(name:"card 2",description: "Test"),Card(name:"card 3",description: "Test")
    ]
    
    
}






