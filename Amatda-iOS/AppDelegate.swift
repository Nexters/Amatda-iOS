//
//  AppDelegate.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let appDelegate = UIApplication.shared.delegate as? AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var keyboardHeight : CGFloat = 0.0
    var eventBuss = PublishSubject<Int>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Application.shared.configureMainInterface(in: window!)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        return true
    }
    
    
    
    private func searchFrontViewController(_ viewController : UIViewController)->UIViewController{
        var vc = viewController
        if let presentVC = viewController.presentedViewController {
            vc = self.searchFrontViewController(presentVC)
        }
        
        return vc
    }
    
    
    func searchFrontViewController()->UIViewController{
        var vc = appDelegate?.window?.rootViewController
        vc = self.searchFrontViewController(vc!)
        return vc!
    }

    
    @objc private func keyboardWillShow(notification : Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let height = keyboardRectangle.height
            self.keyboardHeight = height
        }
    }
    
    @objc private func keyboardWillHide(notification : Notification){
        self.keyboardHeight = 0
    }
}

