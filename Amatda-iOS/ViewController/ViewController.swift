//
//  ViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class ViewController: AMBaseViewController, AMViewControllerUISetAble {
    var titleLabel: UILabel?
    var rightBarButtonItem: UIBarButtonItem?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    
    @IBAction func pressedButton(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController2 = mainStoryboard.instantiateViewController(withIdentifier: "AMWriteViewController") as! AMWriteViewController
        self.modalPresentationStyle = .overCurrentContext
        viewController2.providesPresentationContextTransitionStyle = true
        viewController2.definesPresentationContext = true
        //    self.modalPresentationStyle = UIModalPresentationCurrentContext;

        self.present(viewController2, animated: true, completion: nil)
    }
}

