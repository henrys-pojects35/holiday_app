//
//  myAnnotationView.swift
//  travel_go_go
//
//  Created by henry durrance on 03/01/2021.
//

import UIKit
import MapKit

class myAnnotationView: MKMarkerAnnotationView {

    
    
    override var annotation: MKAnnotation?{
        
        willSet{
             
            
            guard let _myAnnotation = newValue as? myAnnotaion else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            
            markerTintColor = _myAnnotation.markerTintColor
            glyphText = String (_myAnnotation.discipline.first!)
        }
        
    }
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
