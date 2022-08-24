//
//  UIApplication+Extension.swift
//  AbjjadChartTest
//
//  Created by Mohamed Sadek on 24/08/2022.
//

import Foundation
import UIKit

extension UIApplication {
    
    
    /// method to return current top ViewController
    ///
    /// - Parameter controller: ViewController optional description
    /// - Returns: ViewController description
    class func topViewController(controller : UIViewController? =  UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first?.rootViewController) -> UIViewController? {
            
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
