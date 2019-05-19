//
//  DefaultMakeCarrierNavigator.swift
//  Amatda-iOS
//
//  Created by JHH on 14/05/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

protocol CreateNavigator {
    func toPost()
    func toCreateCarrier(carrier: Carrier)
}

final class DefaultMakeCarrierNavigator: CreateNavigator{
    private let storyBoard           : UIStoryboard
    private let navigationController : UINavigationController
    private let services             : UseCaseProvider
    
    init(service: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services             = service
        self.navigationController = navigationController
        self.storyBoard           = storyBoard
    }
    
    func toPost() {
        let vc = self.storyBoard.instantiateViewController(withIdentifier: "AMMakeCarrierViewController") as! AMMakeCarrierViewController
        vc.navigator = self
        vc.service = self.services.makeCarrierUseCase()
        self.navigationController.present(vc, animated: true, completion: nil)
    }
    
    
    func toCreateCarrier(carrier: Carrier) {
        appDelegate?.searchFrontViewController().dismiss(animated: true, completion: {
            CarrierInfo.currentCarrierIndex = AMCarrierStack().count
            AMCarrierStack().push(carrier)
        })
    }
}
