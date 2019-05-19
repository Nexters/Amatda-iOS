//
//  Application.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 11/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//
import UIKit


final class Application{
    static let shared           = Application()
    private let useCaseProvider : UseCaseProvide
    
    private init(){
        self.useCaseProvider = UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = UINavigationController(rootViewController: mainStoryboard.instantiateViewController(withIdentifier: "AMMainViewController") as! AMMainViewController)
        
        window.rootViewController = mainViewController
    }
}
