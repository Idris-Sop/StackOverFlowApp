//
//  BaseViewController.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingView: ISSpinnerView!
    @IBInspectable var screenTitle: String {
        get {
            return self.navigationItem.title ?? ""
        }
        set {
            self.navigationItem.title = newValue
        }
    }
    
    @IBInspectable var navigationBarTitleImage: UIImage? {
        didSet {
            self.navigationItem.titleView = UIImageView(image: navigationBarTitleImage)
        }
    }
    
    @IBInspectable var navigationBarRightButtonTitle: String? {
        didSet {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.navigationBarRightButtonTitle, style: .plain, target: self, action: #selector(rightNavigationBarButtonTapped))
        }
    }
    
    @IBInspectable var navigationBarLeftButtonTitle: String? {
        didSet {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: self.navigationBarLeftButtonTitle, style: .plain, target: self, action: #selector(leftNavigationBarButtonTapped))
        }
    }
    
    @IBInspectable var navigationBarRightButtonImage: UIImage? {
        didSet {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: navigationBarRightButtonImage, style: .plain, target: self, action: #selector(rightNavigationBarButtonImageTapped))
        }
    }
    
    @IBInspectable var navigationBarLeftButtonImage: UIImage? {
        didSet {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: self.navigationBarLeftButtonImage, style: .plain, target: self, action: #selector(leftNavigationBarButtonImageTapped))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    func showErrorMessage(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func rightNavigationBarButtonTapped() {
        //override in child
    }
    
    @objc func leftNavigationBarButtonTapped() {
        //override in child
    }
    
    @objc func rightNavigationBarButtonImageTapped() {
        //override in child
    }
    
    @objc func leftNavigationBarButtonImageTapped() {
        //override in child
    }
    
    func showLoadingIndicator(_ indicator: Bool) {
        if indicator {
            loadingView = ISSpinnerView()
            loadingView.spinnerLineWidth = 2
            loadingView.spinnerDuration = 0
            loadingView.spinnerStrokeColor = UIColor(displayP3Red: 248.0/255.0, green: 114.0/255.0, blue: 45.0/255.0, alpha: 1.0).cgColor
            self.view.alpha = 0.9
            self.view.isUserInteractionEnabled = false
            self.accessibilityElementsHidden = true
            UIAccessibility.post(notification: .announcement, argument: "loading")
        } else {
            UIAccessibility.post(notification: .announcement, argument: "loading done")
            self.accessibilityElementsHidden = false
            self.view.alpha = 1.0
            self.view.isUserInteractionEnabled = true
            loadingView.removeFromSuperview()
        }
    }
}
