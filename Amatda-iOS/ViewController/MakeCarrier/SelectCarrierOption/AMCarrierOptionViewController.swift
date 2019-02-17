//
//  AMCarrierOptionViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 17/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

private struct CarrierOption{
    var button : UIButton
    var label  : UILabel
    var isSelected = false
    init(button : UIButton, label : UILabel) {
        self.button = button
        self.label  = label
    }
}

class AMCarrierOptionViewController: AMBaseViewController {
    @IBOutlet private weak var nonSelectButton: UIButton!
    @IBOutlet private weak var nonSelectLabel: UILabel!
    @IBOutlet private weak var essentialButton: UIButton!
    @IBOutlet private weak var essentialLabel: UILabel!
    @IBOutlet private weak var swimmingButton: UIButton!
    @IBOutlet private weak var swimminLabel: UILabel!
    @IBOutlet private weak var winterSportsButton: UIButton!
    @IBOutlet private weak var winterSportsLabel: UILabel!
    @IBOutlet private weak var campingButton: UIButton!
    @IBOutlet private weak var campingLabel: UILabel!
    @IBOutlet private weak var businessTripButton: UIButton!
    @IBOutlet private weak var businessTripLabel: UILabel!
    @IBOutlet private weak var babyButton: UIButton!
    @IBOutlet private weak var babyLabel: UILabel!
    
    private var options : [CarrierOption]?
    
    @IBOutlet weak var nextButton: UIButton!
    var superPageVC : AMMakeCarrierViewController?
    var disposeBag : DisposeBag?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        options = [CarrierOption(button: self.nonSelectButton, label: nonSelectLabel),
                   CarrierOption(button: self.essentialButton, label: self.essentialLabel),
                   CarrierOption(button: self.swimmingButton, label: swimminLabel),
                   CarrierOption(button: self.winterSportsButton, label: winterSportsLabel),
                   CarrierOption(button: self.campingButton, label: campingLabel),
                   CarrierOption(button: self.businessTripButton, label: businessTripLabel),
                   CarrierOption(button: self.babyButton, label: babyLabel)]
    }
    
    override func setupUI() {
        nonSelectLabel.text      = "선택안함"
        essentialLabel.text      = "필수품"
        swimminLabel.text        = "물놀이"
        winterSportsLabel.text   = "겨울 스포츠"
        campingLabel.text        = "캠핑"
        businessTripLabel.text   = "출장"
        babyLabel.text           = "영유아 동반"
    }
    
    override func setupBind() {
        bindButton()
    }
}

extension AMCarrierOptionViewController{
    private func bindButton(){
        
    }
}
