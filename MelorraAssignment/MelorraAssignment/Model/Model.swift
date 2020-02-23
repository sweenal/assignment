//
//  Model.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 21/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This file is for the models for storing json data

*/

import Foundation

struct ModelData {
    
    var metadata: MetaData?
    var elements: [ElementData]?
    
    init() {
        metadata = MetaData.init()
        elements = []
    }
}



struct ElementData {
    var imageUrl: String?
    var title: String?
    var description: String?
    
    init() {
        imageUrl = ""
        title = ""
        description = ""
    }
}

struct MetaData {
    var layout: String?
    var noOfElements: Int?
    var backgroundColor: String?
    
    init() {
        layout = ""
        noOfElements = 0
        backgroundColor = ""
    }
}



enum LayoutType: String {
    case imageBanner = "image-banner-with-tiles"
    case infoBanner = "info-banner-with-tiles"
}


