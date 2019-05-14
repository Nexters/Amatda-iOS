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

private class CarrierOption{
    var button : UIButton
    var label  : UILabel
    var unSelectedImage : UIImage
    var selectedImage : UIImage
    
    var isSelected = false
    init(button : UIButton,
         label : UILabel,
         unSelectedImage : UIImage,
         selectedImage : UIImage) {
        self.button          = button
        self.label           = label
        self.unSelectedImage = unSelectedImage
        self.selectedImage   = selectedImage
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
    
    private lazy var options : [CarrierOption] = [CarrierOption(button: self.nonSelectButton,
                                                                label: nonSelectLabel,
                                                                unSelectedImage: UIImage(named: "notselected")!,
                                                                selectedImage : UIImage(named: "on_icNotselectedSelect")!),
                                                  CarrierOption(button: self.essentialButton,
                                                                label: self.essentialLabel,
                                                                unSelectedImage: UIImage(named: "icEssential")!,
                                                                selectedImage : UIImage(named: "on_icEssential")!),
                                                  CarrierOption(button: self.swimmingButton,
                                                                label: swimminLabel,
                                                                unSelectedImage: UIImage(named: "icSwimming")!,
                                                                selectedImage : UIImage(named: "on_icSwimming")!),
                                                  CarrierOption(button: self.winterSportsButton,
                                                                label: winterSportsLabel,
                                                                unSelectedImage: UIImage(named: "icWintersports")!,
                                                                selectedImage : UIImage(named: "on_icWintersports")!),
                                                  CarrierOption(button: self.campingButton,
                                                                label: campingLabel,
                                                                unSelectedImage: UIImage(named: "icCamping")!,
                                                                selectedImage : UIImage(named: "on_icCamping")!),
                                                  CarrierOption(button: self.businessTripButton,
                                                                label: businessTripLabel,
                                                                unSelectedImage: UIImage(named: "icBusinesstrip")!,
                                                                selectedImage : UIImage(named: "on_icBusinesstrip")!),
                                                  CarrierOption(button: self.babyButton,
                                                                label: babyLabel,
                                                                unSelectedImage: UIImage(named: "icBaby")!,
                                                                selectedImage : UIImage(named: "on_icBaby")!)]
   
    private let unSelectedLabelColor = UIColor(red: 51, green: 51, blue: 51)
    private let selectedLabelColor   = UIColor(red: 255, green: 87, blue: 54)
    private var optionCarrier  = PublishRelay<[Int]>()
    @IBOutlet weak var nextButton: UIButton!
    var superPageVC : AMMakeCarrierViewController?
    var disposeBag : DisposeBag?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func setupUI() {
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = UIColor(red: 231, green: 231, blue: 231)
    }
    
    
    override func setupBind() {
        guard let disposeBag = disposeBag,
            let superPageVC = self.superPageVC
            else {
                return
        }
        
        let ob = self.nonSelectButton.rx.tap.map{ self.nonSelectButton.tag}
        let ob1 = self.essentialButton.rx.tap.map{ self.essentialButton.tag }
        let ob2 = self.swimmingButton.rx.tap.map{ self.swimmingButton.tag }
        let ob3 = self.winterSportsButton.rx.tap.map{ self.winterSportsButton.tag }
        let ob4 = self.campingButton.rx.tap.map{ self.campingButton.tag }
        let ob5 = self.businessTripButton.rx.tap.map{ self.businessTripButton.tag }
        let ob6 = self.babyButton.rx.tap.map{ self.babyButton.tag }
        
        
        Observable.merge(ob,ob1,ob2,ob3,ob4,ob5,ob6)
            .subscribe(onNext: self.convertSelectionOption)
            .disposed(by: disposeBag)
        
        
        nextButton.rx.tap
            .map{self.options
                .filter{ $0.isSelected }
                .map{$0.button.tag}
            }
            .bind(to: superPageVC.didTapRegister)
            .disposed(by: disposeBag)
    }
}


extension AMCarrierOptionViewController{
    
    private func convertSelectionOption(_ index : Int){
        if index == 0 {
            self.options.map{
                $0.isSelected = false
                $0.button.setImage($0.unSelectedImage, for: .normal)
                $0.label.textColor = unSelectedLabelColor
            }
            
            options[index].isSelected = true
            options[index].button.setImage(options[index].selectedImage, for: .normal)
            options[index].label.textColor = selectedLabelColor
        }else{
            options[0].isSelected = false
            options[0].button.setImage(options[0].unSelectedImage, for: .normal)
            options[0].label.textColor = unSelectedLabelColor
            
            if self.options[index].isSelected {
                self.options[index].button.setImage(self.options[index].unSelectedImage, for: .normal)
                self.options[index].label.textColor = unSelectedLabelColor
                self.options[index].isSelected = false
            }else{
                self.options[index].button.setImage(self.options[index].selectedImage, for: .normal)
                self.options[index].label.textColor = selectedLabelColor
                self.options[index].isSelected = true
            }
        }
        
        let tempArr = self.options.filter{ $0.isSelected }
        if tempArr.count > 0 {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = UIColor(red: 255, green: 87, blue: 54)
        }else{
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = UIColor(red: 231, green: 231, blue: 231)
        }
    }
}
