//
//  AMAlertViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import Lottie

class AMAlertViewController: UIViewController {
    @IBOutlet weak var carrierLottiview: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lottie : LOTAnimationView = LOTAnimationView(name: "bag")
        lottie.contentMode = .scaleAspectFill
        self.carrierLottiview.addSubview(lottie)
        
        self.contentView.layer.cornerRadius = 5
        self.confirmButton.layer.cornerRadius = 10
        lottie.play{ _ in
            
        }
    }


    @IBAction func pressedConfirmButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
