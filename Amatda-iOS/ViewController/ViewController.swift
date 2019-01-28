//
//  ViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class ViewController: AMBaseViewController, AMViewControllerNaviSetAble, AMViewControllerBottomUISetAble {
    
    
    var titleLabel: UILabel? = UILabel()
    var subTitleLabel           : UILabel? = UILabel()
    var rightBarButtonItem: UIBarButtonItem? = UIBarButtonItem()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        titleLabel?.text = "나고야"
        subTitleLabel?.text = "햇빵이에\n무엇을 챙길까요?"
        setupNavigation()
        setupBottom()
    }
    
    
    @IBAction func pressedButton(_ sender: Any) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController2 = mainStoryboard.instantiateViewController(withIdentifier: "AMWriteViewController") as! AMWriteViewController
        //    self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        let viewController2 = AMWriteViewController()
        viewController2.modalPresentationStyle = .overCurrentContext
        viewController2.view.backgroundColor    = .clear
        self.present(viewController2, animated: true, completion: nil)
    }
    
    @objc func pressedCenterButton() {
        let viewController2 = AMWriteViewController()
        viewController2.modalPresentationStyle = .overCurrentContext
        viewController2.view.backgroundColor    = .clear
        self.present(viewController2, animated: true, completion: nil)
    }
}

