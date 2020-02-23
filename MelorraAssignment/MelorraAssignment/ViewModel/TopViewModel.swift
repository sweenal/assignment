//
//  TopViewModel.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 22/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This class is the View Model for Top View Controller

*/

import Foundation

class TopViewModel: NSObject {
    
    var modelJsonTop: ModelData? 
    
    func noOfCellsToShow() -> Int {
        if modelJsonTop?.metadata?.noOfElements == 0 {
           return (modelJsonTop?.elements!.count)!
       }
       else if (modelJsonTop?.metadata!.noOfElements)! > (modelJsonTop?.elements!.count)!
       {
           return (modelJsonTop?.elements!.count)!
       }
       return (modelJsonTop?.metadata!.noOfElements)!
    }
    
    
}
