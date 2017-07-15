//
//  faceView.swift
//  faceit
//
//  Created by Mohan Madhavan on 7/10/17.
//  Copyright © 2017 Mohan Madhavan. All rights reserved.
//

import UIKit

@IBDesignable
class faceView: UIView {

    @IBInspectable
    var scale: CGFloat = 0.9{
        didSet{
            setNeedsDisplay()
        }
    }

    @IBInspectable
    var smileCurve:CGFloat = -1.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var eyesOpen: Bool = true{
        didSet{
            if eyesOpen == true{
                eyes = .open
            }
            else{
                eyes = .closed
            }
            setNeedsDisplay()
        }
    }
    
    var eyes: eyesState = .open
    
    var myCenter: CGPoint = CGPoint(x:0, y:0)
    var radius: CGFloat = 0
    
    enum eyesState{
        case open
        case closed
    }
    
    private func eyesPath(_ choice: eyesState){
        
        // Create eye circles.
        var eye_center: CGPoint
        let eye_radius: CGFloat = self.radius / 8
        var path: UIBezierPath
        
        switch choice {
        case .open:
            // left eye
            eye_center = CGPoint(x: (self.myCenter.x - (self.radius/2)), y: (self.myCenter.y - (self.radius/3)))
            path = UIBezierPath(arcCenter: eye_center, radius: eye_radius, startAngle: 0, endAngle: 360, clockwise: true)
            path.lineWidth = 3.0
            path.stroke()
            
            // right eye
            eye_center = CGPoint(x: (self.myCenter.x + (self.radius/2)), y: (self.myCenter.y - (self.radius/3)))
            path = UIBezierPath(arcCenter: eye_center, radius: eye_radius, startAngle: 0,endAngle: 360, clockwise: true)
            path.lineWidth = 3.0
            path.stroke()
            
        case .closed:
            // left eye
            eye_center = CGPoint(x: (self.myCenter.x - (self.radius/2)), y: (self.myCenter.y - (self.radius/3)))
            var eye_rect_start = CGPoint(x: eye_center.x - eye_radius, y: eye_center.y - self.radius/16)
            var eye_size = CGSize(width: eye_radius * 2, height: eye_radius)
            var box = CGRect(origin: eye_rect_start, size: eye_size)
            var cp1 = CGPoint(x: box.midX, y: box.midY)
            let path = UIBezierPath()
            var start = CGPoint(x: box.minX, y: box.midY)
            var stop = CGPoint(x: box.maxX, y: box.midY)
            path.move(to: start)
            path.addCurve(to: stop, controlPoint1: cp1, controlPoint2: cp1)
            path.lineWidth = 3.0
            path.stroke()
            
            
            // right eye
            eye_center = CGPoint(x: (self.myCenter.x + (self.radius/2)), y: (self.myCenter.y - (self.radius/3)))
            eye_rect_start = CGPoint(x: eye_center.x - eye_radius, y: eye_center.y - self.radius/16)
            eye_size = CGSize(width: eye_radius * 2, height: eye_radius)
            box = CGRect(origin: eye_rect_start, size: eye_size)
            cp1 = CGPoint(x: box.midX, y: box.midY)
            start = CGPoint(x: box.minX, y: box.midY)
            stop = CGPoint(x: box.maxX, y: box.midY)
            path.move(to: start)
            path.addCurve(to: stop, controlPoint1: cp1, controlPoint2: cp1)
            path.lineWidth = 3.0
            path.stroke()
            
        }
    }
    
    private func mouthPath(){
        let intial = CGPoint(x: (self.myCenter.x - (self.radius/2)), y: (self.myCenter.y + (self.radius/3)))
        let size = CGSize(width: self.radius, height: self.radius/4)
        
        // Create a box for reference
        let box = CGRect(origin: intial, size: size)
        
        // Start and end of the smile
        let smileStart = CGPoint(x: box.minX, y: box.midY)
        let smileEnd = CGPoint(x: box.maxX, y: box.midY)
        
        // Controls how much to smile
        let smileOffset = CGFloat(max(-1, min(self.smileCurve, 1))) * box.height
        
        // These are control points, they pull the curve towards them
        let cp1 = CGPoint(x: (box.minX + box.width/3), y: (box.midY + smileOffset))
        let cp2 = CGPoint(x: (box.maxX - box.width/3), y: (box.midY + smileOffset))

        let path = UIBezierPath()
        path.move(to: smileStart)
        path.addCurve(to: smileEnd, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 3.0
        path.stroke()
        
    }
    
    private func headPath(_ centerPoint: CGPoint, _ rad: CGFloat){
        // Create a circle for the head
        let path = UIBezierPath(arcCenter: centerPoint, radius: rad, startAngle: 0, endAngle: 360, clockwise: true)
        path.lineWidth = 5.0
        path.stroke()

    }
    override func draw(_ rect: CGRect) {
        
        myCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        radius = (min(bounds.height, bounds.width) / 2) * scale
        headPath(myCenter, radius)
        eyesPath(eyes)
        mouthPath()
    }
    

}
