//
//  Extensions.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 22/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This file is for extensions for UIImageView, UIViewController, UIColor

*/


import Foundation
import UIKit


// MARK:- UIImageView Extension

// Caching images in memory, so each image will be downloaded only once
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloadImage(from URL: URL) {
                
        if let cachedImage = imageCache.object(forKey: URL.absoluteString as NSString) {
            DispatchQueue.main.async() {
                self.image = cachedImage
            }
            return
        }
        
        // Download logic
        URLSession.shared.dataTask(with: URL) {data, response, error in
            guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            imageCache.setObject(image, forKey: URL.absoluteString as NSString)
            
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }

}


// MARK:- UIColor Extension
extension UIColor {
    
    // Converting Hexcode to UIColor
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {

                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }

        return nil
    }
}


// MARK:- UIViewController Extension
extension UIViewController {
    
    // Showing alert if network is unreachable
    func showNetworkUnavailableAlert() {
        
        let alertController = UIAlertController.init(title: "Oops!", message: "Please check your network connection", preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

