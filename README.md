# EyeTracking App

**Concept by Alessandro Esposito Vulgo Gigante**

## Project Overview

The purpose of this project is to conduct a speculative analysis in order to produce a fully interactive application that doesn't require the use of hands. The main aim is to provide a solution for individuals who have motor disabilities or difficulty using their upper limbs. I am of the opinion that technological advancement should always be supported by strong accessibility. I think that the proposed solution can be useful for both the use of devices like iPhone and iPad and as a substitute for manual gestures on devices like the VisionPro.

This test was executed by me using SwiftUI and the ARKit, RealityKit frameworks provided by Apple.

## Focus Points

I wanted to focus on three specific points:

- Scrolling of elements
- Selection of elements
- Navigation between the views

A generic array is displayed on the main screen using multiple cards, each representing a different color. By blinking your right eye, you can scroll items to the right. Similarly, using the left eye, you can scroll to the left. The vector will return to its start or final position if you reach the right or left margin. The camera located at the bottom of the screen is capable of observing eye closure and determining whether the user is smiling or not.

If the smile has been detected, the user is informed by a button. A smile for two seconds is necessary to confirm the selection of an item.

A timer is visible below the cards, which allows the user to check the time needed to confirm their selection. Selecting an element causes the card's opacity to increase and the word 'selected' to appear.

The last card is an example to show how it is possible to move between different views using this eye tracking mechanism and works as a back button.

An onboarding page when starting the application summarizes the commands that were just listed.

## Eye Tracking

Real-time facial expression recognition can be achieved by analyzing the user's face using ARKit and RealityKit.

ARKit: “Detect faces in a front-camera AR experience, overlay virtual content, and animate facial expressions in real-time.”

Before defining the project's views, I had to set an ARContainer that would only recognize the facial information I needed.

```swift
struct CustomContainer: UIViewRepresentable {
    
    @Binding var LeftisWinking: Bool
    @Binding var RightisWinking: Bool
    
    @Binding var SmileLeftCheck: Bool
    @Binding var SmileRightCheck: Bool
    
    func makeUIView(context: Context) -> CustomARView {
        
        return CustomARView(LeftisWinking: $LeftisWinking, RightisWinking: $RightisWinking, SmileLeftCheck: $SmileLeftCheck, SmileRightCheck: $SmileRightCheck)
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}

class CustomARView: ARView, ARSessionDelegate {
    
    @Binding var LeftisWinking: Bool
    @Binding var RightisWinking: Bool
    
    @Binding var SmileLeftCheck: Bool
    @Binding var SmileRightCheck: Bool
    
    init(LeftisWinking: Binding<Bool>, RightisWinking: Binding<Bool>, SmileLeftCheck: Binding<Bool>, SmileRightCheck: Binding<Bool>) {
       
        _LeftisWinking = LeftisWinking
        _RightisWinking = RightisWinking
        _SmileLeftCheck = SmileLeftCheck
        _SmileRightCheck = SmileRightCheck
        
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
        
        detectSmile(faceAnchor: faceAnchor)
        
    }
}

```


## Scrolling

In order to navigate through the array elements, the goal was to use the right and left eye closures to change directions. An object called ARFaceAnchor is provided by ARKit to accomplish this task. The Apple documentation states:

“An anchor for a unique face that is visible in the front-facing camera.”

Using the FaceAnchor class, you can use specific facial expressions recognized by the framework and exploited through variables called blendShapes.

*“The blendShapes dictionary provided by an ARFaceAnchor object describes the facial expression of a detected face in terms of the movements of specific facial features. For each key in the dictionary, the corresponding value is a floating point number indicating the current position of that feature relative to its neutral configuration, ranging from 0.0 (neutral) to 1.0 (maximum movement).”*

```swift
private func detectBlink(faceAnchor: ARFaceAnchor) {
        
        let blendShapes = faceAnchor.blendShapes
        
        if let leftEyeBlink = blendShapes[.eyeBlinkLeft] as? Float,
           let rightEyeBlink = blendShapes[.eyeBlinkRight] as? Float {
            
            if rightEyeBlink > 0.8 {
                RightisWinking = true
            } else {
                RightisWinking = false
            }
            
            if leftEyeBlink > 0.8 {
                LeftisWinking = true
            } else {
                LeftisWinking = false
            }
            
        }
    }

```
In my case, I opted for:

**blendShapes[.eyeBlinkLeft]** -> The coefficient describing closure of the eyelids over the left eye.

**blendShapes[.eyeBlinkRight]** -> The coefficient describing closure of the eyelids over the right eye.











