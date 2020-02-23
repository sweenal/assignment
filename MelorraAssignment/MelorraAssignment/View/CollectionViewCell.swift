//
//  CollectionViewCell.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 21/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This class is for the custom Collection View Cell

*/


import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = self.isSelected ? UIColor.cyan.cgColor : UIColor.darkGray.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Border colour and width
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 2
    }

}
