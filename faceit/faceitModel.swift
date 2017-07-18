//
//  faceitModel.swift
//  faceit
//
//  Created by Mohan Madhavan on 7/14/17.
//  Copyright © 2017 Mohan Madhavan. All rights reserved.
//

import Foundation


struct Face{
    
    enum eyes: Int{
        case open = 1
        case closed
        
        var state: eyes{
            get{ return eyes(rawValue: self.rawValue) ?? .open}
        }
    }
    
    enum mouth: Int{
        
        case frown = -2
        case ok = -1
        case nothing = 0
        case blush = 1
        case smile = 2

        
        // So, rawValue basically get the value that is currently set
        // Also, I need to cast the return type to mouth rather than a simple int because I am returning a .smile / .frown value with is of a mouth type, when you are doing that I need to pass the value using the rawValue attribute of the mouth.
        var happier: mouth{
            get{
                return mouth(rawValue: rawValue + 1) ?? .smile
            }
        }
        
        var sadder: mouth{
            get{
                return mouth(rawValue: rawValue - 1) ?? .frown
            }
        }
        
    }
    
    
    // Without these values you cannot initialize the struct
    var mouthVal: mouth
    var eyesVal: eyes
    
    
}
