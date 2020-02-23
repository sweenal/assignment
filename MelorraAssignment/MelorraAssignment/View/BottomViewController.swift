//
//  BottomViewController.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 21/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This class is the View Controller for Bottom View Layout

*/


import UIKit

class BottomViewController: UIViewController {

    @IBOutlet weak var sideImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    var bottomViewModel = BottomViewModel()
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Border colour, width and corner radius
        self.sideImgView.layer.cornerRadius = sideImgView.frame.size.width/2
        self.topView.layer.borderColor = UIColor.darkGray.cgColor
        self.topView.layer.borderWidth = 1.0
    }
    
    func setBottomViewModel(modelJson: ModelData?) {
        
        // Setting Model View data
        bottomViewModel.modelJsonBottom = modelJson
        
        // Setting UI after model view data is set
        configureCollectionView()
        setBackgroundColor()
    }

    
    // MARK:- Set up Collection View
    func configureCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        bottomCollectionView.collectionViewLayout = layout
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        
        // Select first cell for top display
        if (bottomViewModel.modelJsonBottom?.elements!.count)! > 0 {
            self.bottomCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
            self.collectionView(self.bottomCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        }
       
    }
    
    
    // MARK:- Set up Background Colour
    func setBackgroundColor() {
        let color = UIColor(hex: (bottomViewModel.modelJsonBottom?.metadata?.backgroundColor)!)
        self.view.backgroundColor = color
       
    }
    
}


extension BottomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK:- Collection View Delegate, DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bottomViewModel.noOfCellsToShow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        let element = bottomViewModel.modelJsonBottom?.elements?[indexPath.row]
        let url = URL(string: (element?.imageUrl)!)
        cell.imgView.downloadImage(from: url!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let element = bottomViewModel.modelJsonBottom?.elements?[indexPath.row]
        let url = URL(string: (element?.imageUrl)!)
       
        self.sideImgView.downloadImage(from: url!)
        self.titleLabel.text = element?.title
        self.descriptionLabel.text = element?.description
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 10, height: collectionView.frame.size.width/3 - 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
}
