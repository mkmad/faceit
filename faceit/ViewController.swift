//
//  ViewController.swift
//  faceit
//
//  Created by Mohan Madhavan on 7/10/17.
//  Copyright © 2017 Mohan Madhavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myFace: Face = Face(eyesState: .open, mouth: .smile)
    
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
    
    @IBAction func tapping(_ sender: UITapGestureRecognizer) {
        print("Touching")
        myView?.eyesOpen = (myView?.eyesOpen)! ? false : true
    }
    
    @IBAction func pinching(_ sender: UIPinchGestureRecognizer) {
        print("Pinching")
        switch sender.state{
        case .changed, .ended:
            myView?.scale *= sender.scale
            sender.scale = 1
        default:
            break
        }
    }
    
    @IBAction func swipingUp(_ sender: UISwipeGestureRecognizer) {
        myView?.smileCurve = 1

    }
    
    @IBAction func swipingDown(_ sender: UISwipeGestureRecognizer) {
        myView?.smileCurve = -1

    }
    
    
}

