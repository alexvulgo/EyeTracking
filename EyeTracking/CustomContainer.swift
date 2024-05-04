//
//  CustomContainer.swift
//  EyeTracking
//
//  Created by Alessandro Esposito Vulgo Gigante on 02/05/24.
//

import SwiftUI
import ARKit
import RealityKit

struct CustomContainer: UIViewRepresentable {
    
    @Binding var LeftisWinking: Bool
    @Binding var RightisWinking: Bool
    
    
    func makeUIView(context: Context) -> CustomARView {
        
        return CustomARView(LeftisWinking : $LeftisWinking , RightisWinking : $RightisWinking)
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}

class CustomARView: ARView, ARSessionDelegate {
    @Binding var LeftisWinking: Bool
    @Binding var RightisWinking: Bool
    
    init(LeftisWinking: Binding<Bool> , RightisWinking: Binding<Bool>) {
       
        _LeftisWinking = LeftisWinking
        _RightisWinking = RightisWinking
        
        super.init(frame: .zero)
        
        self.session.delegate = self
        
        let configuration = ARFaceTrackingConfiguration()
        self.session.run(configuration)
    }
    
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
            guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }
        
        detectBlink(faceAnchor: faceAnchor)
        
    }
    
    
    private func detectBlink(faceAnchor: ARFaceAnchor) {
        
        let blendShapes = faceAnchor.blendShapes
        
        if let leftEyeBlink = blendShapes[.eyeBlinkLeft] as? Float,
           let rightEyeBlink = blendShapes[.eyeBlinkRight] as? Float {
            
            if rightEyeBlink > 0.9 {
                RightisWinking = true
            } else {
                RightisWinking = false
            }
            
            if leftEyeBlink > 0.9 {
                LeftisWinking = true
            } else {
                LeftisWinking = false
            }
            
        }
    }
    
    
   @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}
