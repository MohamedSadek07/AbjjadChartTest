//
//  LoadingOverlay.swift
//  AbjjadChartTest
//
//  Created by Mohamed Sadek on 24/08/2022.
//


import Foundation
import UIKit

class LoadingOverlay {
    
    //MARK: Variables
    var view : UIView!
    var spinner = UIActivityIndicatorView(style: .medium)
    var loadingView: UIView = UIView()
    
    //MARK: Initialization
    init(view : UIView){
        self.view = view
    }
    

    //MARK: Methods
    func showActivityIndicator() {
        DispatchQueue.main.async() {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor(named: "000000")
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10

            self.spinner = UIActivityIndicatorView(style: .medium)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async() {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
}
