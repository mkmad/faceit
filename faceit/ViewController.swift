//
//  ViewController.swift
//  faceit
//
//  Created by Mohan Madhavan on 7/10/17.
//  Copyright © 2017 Mohan Madhavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myFace: Face = Face(mouthVal: .smile, eyesVal: .open)
    
    enum expression{
        case happy
        case sad
    }
    
    // Note: here .frown means a Face.mouth type with .frown value set.
    let smileStates: Dictionary<Int, Face.mouth> = [-2: .frown, -1: .ok, 0: .nothing, 1: .blush, 2: .smile]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var myView: faceView!{
        didSet{
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapping(_:)))
            tap.numberOfTapsRequired = 1
            myView.addGestureRecognizer(tap)
            
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinching(_:)))
            myView.addGestureRecognizer(pinch)
            
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipingUp(_:)))
            swipeUp.direction = .up
            myView.addGestureRecognizer(swipeUp)
            
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipingDown(_:)))
            swipeDown.direction = .down
            myView.addGestureRecognizer(swipeDown)
        }

    }
    
    //Note: I need to update the model and the view here.
    @IBAction func tapping(_ sender: UITapGestureRecognizer) {
        switch myFace.eyesVal{
        case .open:
            myView?.eyesOpen = false
            myFace.eyesVal = .closed
        case .closed:
            myView?.eyesOpen = true
            myFace.eyesVal = .open
        }
    }
    
    @IBAction func pinching(_ sender: UIPinchGestureRecognizer) {
        switch sender.state{
        case .changed, .ended:
            myView?.scale *= sender.scale
            sender.scale = 1
        default:
            break
        }
    }
    
    @IBAction func swipingUp(_ sender: UISwipeGestureRecognizer) {
        updateFace(ex: expression.sad)

    }
    
    @IBAction func swipingDown(_ sender: UISwipeGestureRecognizer) {
        updateFace(ex: expression.happy)

    }
    
    //Note: I need to update the model and the view here.
    func updateFace(ex: expression){
        switch ex{
        case .happy:
            myFace.mouthVal = smileStates[myFace.mouthVal.happier.rawValue] ?? Face.mouth.smile
            myView?.smileCurve = CGFloat(myFace.mouthVal.happier.rawValue)
        case .sad:
            myFace.mouthVal = smileStates[myFace.mouthVal.sadder.rawValue] ?? Face.mouth.frown
            myView?.smileCurve = CGFloat(myFace.mouthVal.sadder.rawValue)
        }
        
    }
}

