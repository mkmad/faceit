//
//  faceitModel.swift
//  faceit
//
//  Created by Mohan Madhavan on 7/14/17.
//  Copyright © 2017 Mohan Madhavan. All rights reserved.
//

import Foundation


struct Face{
    
    
    enum eyesState{
        case open
        case closed
    }
    
    enum mouth: Int{
        
        case smile
        case frown
        case nothing
        
        // So, rawValue basically get the value that is currently set
        var happy: mouth{
            get{
                return mouth(rawValue: rawValue + 1) ?? .smile
            }
        }
        
        var sad: mouth{
            get{
                return mouth(rawValue: rawValue - 1) ?? .frown
            }
        }
        
    }
    
    var happier: Face{
        get{
            return Face(eyesState: self.eyesState, mouth: self.mouth.happy)
        }
    }
    
    var sadder: Face{
        get{
            return Face(eyesState: self.eyesState, mouth: self.mouth.sad)
        }
    }
    
    // Without these values you cannot initialize the struct
    let eyesState: eyesState
    let mouth: mouth
    
    
}
