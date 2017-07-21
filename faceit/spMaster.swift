//
//  spMaster.swift
//  faceit
//
//  Created by Mohan Madhavan on 7/21/17.
//  Copyright © 2017 Mohan Madhavan. All rights reserved.
//

import UIKit

class spMaster: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Since buttons are acting as segue's here I dont need
    // to check if its pressed etc.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? MainViewController{
            // Force load the view
            let _ = dest.view
            if let id = segue.identifier{
                switch id{
                case "happy":
                    dest.myView.smileCurve = 1
                case "sad":
                    dest.myView.smileCurve = -1
                default:
                    break
                }
            }
        }
    }
}
