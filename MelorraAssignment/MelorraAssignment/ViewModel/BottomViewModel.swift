//
//  BottomViewModel.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 22/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This class is the View Model for Bottom View Controller

*/


import Foundation

class BottomViewModel: NSObject {
    
    var modelJsonBottom: ModelData?
    
    func noOfCellsToShow() -> Int {
        if modelJsonBottom?.metadata?.noOfElements == 0 {
           return (modelJsonBottom?.elements!.count)!
       }
       else if (modelJsonBottom?.metadata!.noOfElements)! > (modelJsonBottom?.elements!.count)!
       {
           return (modelJsonBottom?.elements!.count)!
       }
       return (modelJsonBottom?.metadata!.noOfElements)!
    }
}
