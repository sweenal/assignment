//
//  NetworkManager.swift
//  MelorraAssignment
//
//  Created by Sweenal Lale on 22/02/20.
//  Copyright © 2020 Sweenal Lale. All rights reserved.
//

/*  This class is the Network Manager to check connectivity

*/


import Foundation
import SystemConfiguration

class NetworkManager {

    static let shared = NetworkManager()
    
    func isConnectedToInternet() -> Bool {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com") else { return false}
        var flags = SCNetworkReachabilityFlags()
        
        SCNetworkReachabilityGetFlags(reachability, &flags)
        if !isNetworkReachable(with: flags) {
           
            return false
        }
        
        #if os(iOS)
        // It's available just for iOS because it's checking if the device is using mobile data
        if flags.contains(.isWWAN) {
            return true
        }
        #endif
        
       return true
    }
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
}
