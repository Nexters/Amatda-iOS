//
//  AMCarrierTimeViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 17/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class AMCarrierTimeViewController: AMBaseViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var timeOfCarrier: UITextField!
    @IBOutlet weak var dayOfCarrier: UITextField!
    
    var superPageVC : AMMakeCarrierViewController?
    var disposeBag : DisposeBag?
    
    
    private var pickerDate : String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMMM yyyy"
        let date = dateformatter.string(from: datePickerView.date)
        return date
    }
    
    
    private var pickerTime : String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        let time = dateformatter.string(from: timePickerView.date)
        return time
    }
    
    
    private lazy var pickerContentView : UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        self.view.addSubview(contentView)
        return contentView
    }()
    
    
    private lazy var datePickerView : UIDatePicker = {
        let dayPicker = UIDatePicker()
        dayPicker.datePickerMode = .date
        return dayPicker
    }()
    
    
    private lazy var timePickerView : UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        return timePicker
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func setupUI() {
        makeCityPickerView()
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = UIColor(red: 231, green: 231, blue: 231)
    }
    
    
    override func setupBind() {
        guard let disposeBag  = disposeBag,
              let superPageVC = superPageVC else { return }
        
        self.nextButton.rx.tap
            .take(1)
            .subscribe(onNext:{
                superPageVC.pressedNextButton()
                self.nextButton.isEnabled = false
            } )
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(superPageVC.dayOfCarrier,
                           superPageVC.timeOfCarrier){($0,$1)}
            .asDriver(onErrorJustReturn: ("",""))
            .drive(onNext: { _ in
                self.nextButton.isEnabled = true
                self.nextButton.backgroundColor = UIColor(red: 255, green: 87, blue: 54)
            }).disposed(by: disposeBag)
    }
    
    
    
    @IBAction func touchedDayOfCarrier(_ sender: Any) {
        self.showPickerView()
        self.pickerContentView.addSubview(self.datePickerView)
        self.datePickerView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.pickerContentView.snp.height)
        }
    }
    
    
    @IBAction func touchedTimeOfCarrier(_ sender: Any) {
        showPickerView()
        self.pickerContentView.addSubview(self.timePickerView)
        self.timePickerView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.pickerContentView.snp.height)
        }
    }
}



//Setup PickerView
extension AMCarrierTimeViewController{
    private func makeCityPickerView(){
        self.pickerContentView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(44)
            $0.height.equalTo(0)
        }
        
        let confirmView = UIView()
        self.view.addSubview(confirmView)
        confirmView.backgroundColor = UIColor(red: 250, green: 250, blue: 248)
        confirmView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(self.pickerContentView.snp.top)
            $0.height.equalTo(44)
        }
        
        let confirmTopLine = UIView()
        confirmView.addSubview(confirmTopLine)
        confirmTopLine.backgroundColor = UIColor(red: 225, green: 224, blue: 224)
        confirmTopLine.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        let confirmBottomLine = UIView()
        confirmView.addSubview(confirmBottomLine)
        confirmBottomLine.backgroundColor = UIColor(red: 225, green: 224, blue: 224)
        confirmBottomLine.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        
        let confirmButton = UIButton()
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(UIColor(red: 0, green: 125, blue: 255), for: .normal)
        confirmButton.titleLabel?.font = UIFont.notoSansCJKKr_medium(fontSize: 15)
        confirmView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-30)
            $0.size.equalTo(35)
        }
        
        guard let disposeBag = disposeBag,
              let superPageVC = superPageVC else { return }
        
        
            confirmButton.rx.tap
                .filter{ self.pickerContentView.subviews[0] == self.datePickerView }
                .map{
                    self.hidePickerView()
                    self.dayOfCarrier.text = self.pickerDate
                    return self.pickerDate
                }.bind(to: superPageVC.dayOfCarrier)
                .disposed(by: disposeBag)
        
        
            confirmButton.rx.tap
                .filter{ self.pickerContentView.subviews[0] == self.timePickerView }
                .map{
                    self.hidePickerView()
                    self.timeOfCarrier.text = self.pickerTime
                    return self.pickerTime
                }.bind(to: superPageVC.timeOfCarrier)
                .disposed(by: disposeBag)
    }
    
    
    
    @objc private func showPickerView(){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerContentView.snp.remakeConstraints{
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.height.equalTo(217)
            }
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    @objc private func hidePickerView(){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerContentView.snp.remakeConstraints{
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(44)
                $0.height.equalTo(0)
            }
            self.view.layoutIfNeeded()
        }) { _ in
            
            self.datePickerView.removeFromSuperview()
            self.timePickerView.removeFromSuperview()
        }
    }
}
