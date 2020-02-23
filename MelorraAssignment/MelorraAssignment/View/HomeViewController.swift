//
//  HomeViewController.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 21/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//


/*  This class is the View Controller for Main.storyboard
 
    It contains 2 views corresponding to the 2 types of UI to display:
    1. topViewLayout
    2. bottomViewLayout
 
 */

import UIKit


class HomeViewController: UIViewController {
    
    // UI Displays
    @IBOutlet weak var topViewLayout: UIView!
    @IBOutlet weak var bottomViewLayout: UIView!
    
    // View Model
    let homeViewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To override iOS dark mode setting
        overrideUserInterfaceStyle = .light
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        // Checking if device is connected to Internet - if yes, proceed, else show alert
        
        if !NetworkManager.shared.isConnectedToInternet() {
            self.showNetworkUnavailableAlert()
        }
        else {
            homeViewModel.initViewModel()
            configureTopView()
            configureBottomView()
        }
        
    }
    
    
    // MARK:- Set up Top View Layout
    func configureTopView() {
        let topVC = TopViewController.init(nibName: "TopViewController", bundle: nil)
        topVC.view.frame.size = topViewLayout.frame.size
        self.addChild(topVC)
        topVC.didMove(toParent: self)
        topViewLayout.addSubview(topVC.view)
        
        topVC.setTopViewModelJson(modelJson: homeViewModel.topModelJson)
    }
    
    
    // MARK:- Set up Bottom View Layout
    func configureBottomView() {
        let bottomVC = BottomViewController.init(nibName: "BottomViewController", bundle: nil)
        bottomVC.view.frame.size = bottomViewLayout.frame.size
        self.addChild(bottomVC)
        bottomVC.didMove(toParent: self)
        bottomViewLayout.addSubview(bottomVC.view)
        
        bottomVC.setBottomViewModel(modelJson: homeViewModel.bottomModelJson)
    }

}


