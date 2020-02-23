//
//  TopViewController.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 21/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This class is the View Controller for Top View Layout

*/


import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var sideImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    
    var topViewModel = TopViewModel()
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Border colour, width and corner radius
        sideImgView.layer.cornerRadius = sideImgView.frame.width/2
        topImgView.layer.borderWidth = 1.0
        topImgView.layer.borderColor = UIColor.darkGray.cgColor
    }

    func setTopViewModelJson(modelJson: ModelData?) {
        
        // Setting Model View data
        topViewModel.modelJsonTop = modelJson
        
        // Setting UI after model view data is set
        configureCollectionView()
        setBackgroundColor()
    }
    
    
    // MARK:- Set up Collection View
    func configureCollectionView() {
   
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        topCollectionView.collectionViewLayout = layout
       
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        topCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
       
        // Select first cell for top display
        if (topViewModel.modelJsonTop?.elements!.count)! > 0 {
            self.topCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
            self.collectionView(self.topCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        }
    }
    
    
    // MARK:- Set up Background Colour
    func setBackgroundColor() {
        let color = UIColor(hex: (topViewModel.modelJsonTop?.metadata?.backgroundColor)!)
        self.backgroundView.backgroundColor = color
        self.topCollectionView.backgroundColor = color
    }

}


extension TopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
  
    // MARK:- Collection View Delegate, DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topViewModel.noOfCellsToShow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        let element = topViewModel.modelJsonTop?.elements?[indexPath.row]
        let url = URL(string: (element?.imageUrl)!)
        cell.imgView.downloadImage(from: url!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let element = topViewModel.modelJsonTop?.elements?[indexPath.row]
        let url = URL(string: (element?.imageUrl)!)
        self.topImgView.downloadImage(from: url!)
        self.sideImgView.downloadImage(from: url!)
        
        self.titleLabel.text = element?.title
        self.descriptionLabel.text = element?.description
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height - 20, height: collectionView.frame.size.height - 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    
}
