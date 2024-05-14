//
//  ItemViewModel.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 13/05/24.
//

import SwiftUI
import Observation

@Observable class itemViewModel {
    
    var items = [
        Item(name: "Item 1", color: .blue),Item(name: "Item 2", color: .green),Item(name: "Item 3", color: .red),Item(name: "Item 4", color: .yellow),Item(name: "Item 4", color: .white,selection: "Back")
    ]
}


