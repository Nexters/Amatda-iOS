//
//  AMMainNavigator.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 19/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//
import UIKit

protocol AMMainNavigator {
    func toMain() -> UIViewController
}

final class AMDefaultMainNavigator: AMMainNavigator{
    private let storyBoard: UIStoryboard
    private let services: UseCaseProvide
    
    init(storyBoard: UIStoryboard,
         services : UseCaseProvide) {
        self.storyBoard = storyBoard
        self.services = services
    }
    
    
    func toMain() -> UIViewController {
        let mainUseCase = self.services.makeMainUseCase()
        let vc = self.storyBoard.instantiateViewController(withIdentifier: "AMMainViewController") as! AMMainViewController
        let mainViewController = UINavigationController(rootViewController: vc)
        vc.viewModel = AMMainViewModel(useCase: mainUseCase,
                                       navigator: self)
        
        return mainViewController
    }
}

