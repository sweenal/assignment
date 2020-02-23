//
//  HomeViewModel.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 21/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This class is the View Model for Home View Controller

*/


import Foundation

class HomeViewModel: NSObject {
    
    let jsonFile = "DynamicDesign.json"
    var modelJson: [ModelData]?
    var topModelJson: ModelData?
    var bottomModelJson: ModelData?
    
    func initViewModel() {
        readJsonFile()
    }
    
    //MARK:- Reading local JSON file
    func readJsonFile() {
                
        let dir = Bundle.main.bundlePath
        let path = dir.appending("/" + jsonFile)
        
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        self.modelJson = parseJson(data: jsonData)
        
        setTopAndBottomJson()
        
    }
    
    
    //MARK:- Set up 2 separate models for top and bottom layouts
    func setTopAndBottomJson() {
        
        for modelJsonElem in self.modelJson! {
            if let layoutStr = modelJsonElem.metadata?.layout {
                if layoutStr == LayoutType.infoBanner.rawValue {
                    self.bottomModelJson = modelJsonElem
                }
                else if layoutStr == LayoutType.imageBanner.rawValue {
                    self.topModelJson = modelJsonElem
                }
            }
        }
    }
    
    
    //MARK:- Parse JSON
    func parseJson(data: Data) -> [ModelData] {
        
        var modelDataArr: [ModelData] = []
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]

            if let dataArr = json["data"] as? [[String: AnyObject]] {
                var modelData = ModelData()
                
                for data in dataArr {
                   var metaData = MetaData()
                   var elementArr: [ElementData] = []
                    
                    if let meta = data["metadata"] as? [String: AnyObject] {
                        if let layout = meta["layout"] as? String {
                            metaData.layout = layout
                        }
                        if let bgColor = meta["backgroundColor"] as? String {
                            metaData.backgroundColor = bgColor
                        }
                        if let noElem = meta["noOfElements"] as? Int {
                            metaData.noOfElements = noElem
                        }
                    }
                    if let elemArr = data["elements"] as? [[String: AnyObject]] {
                        
                        for elem in elemArr {
                            var element = ElementData()
                            if let imgUrl = elem["imageUrl"] as? String {
                                element.imageUrl = imgUrl
                            }
                            if let titl = elem["title"] as? String {
                                element.title = titl
                            }
                            if let descrpt = elem["description"] as? String {
                                element.description = descrpt
                            }
                            elementArr.append(element)
                        }
                        
                    }
                    
                    modelData.metadata = metaData
                    modelData.elements = elementArr
                    
                    modelDataArr.append(modelData)
                }
            }
            
        }
        catch {
            print("jsonData error \(error)")
        }
       
        return modelDataArr
        
    }
 
}
