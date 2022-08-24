//
//  AlertUtility.swift
//  AbjjadChartTest
//
//  Created by Mohamed Sadek on 24/08/2022.
//

import Foundation
import UIKit

class AlertUtility{

    //MARK: Methods
    // showAlert with title , message and VC parameters
    class func showAlert(title: String, message: String, VC: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (alertAction) in
        })
        alertVC.addAction(ok)
        VC.present(alertVC, animated: true, completion: nil)
        
    }

    // showAlert in case of no internet connection with appropriate message
    class func showNoInternetConnectionAlert() {
        if let viewController =  UIApplication.topViewController(){
        showAlert(title: "Error", message: "There is no internet connection", VC: viewController)
        }
    }
    
    // showAlert in case of no internal server error occurr with appropriate message 
    class func showInternalServerAlert() {
        if let viewController =  UIApplication.topViewController(){
        showAlert(title: "Error", message:  "Internal Server Error" , VC: viewController)
        }
    }
}


