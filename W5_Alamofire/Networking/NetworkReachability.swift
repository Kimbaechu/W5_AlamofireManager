//
//  NetworkReachability.swift
//  W5_Alamofire
//
//  Created by Beomcheol Kwon on 2021/01/29.
//

import UIKit
import Alamofire

class NetworkReachability {
    static let shared = NetworkReachability()
    let reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    let offlineAlertController: UIAlertController = {
        UIAlertController(title: "No Network", message: "Please connect to network and try again", preferredStyle: .alert)
    }()
    
    func showOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.present(offlineAlertController, animated: true, completion: nil)
    }
    
    func dismissOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func startNetworkMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.showOfflineAlert()
            case .reachable(.cellular), .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
            print("Unknown network state")
            }
        }
    }
    
}
