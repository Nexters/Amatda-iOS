//
//  AMMakeOptionViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 16/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

var cities = ["도시 없음",
              "일본 오사카",
              "중국 베이징",
              "하와이",
              "미주 뉴욕",
              "독일 베를린",
              "프랑스 파리",
              "베트남 다낭"]

class AMMakeCityViewController: AMBaseViewController {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    private var selectedCity    = ""
    var superPageVC : AMMakeCarrierViewController?
    var disposeBag : DisposeBag?
    
    
    
    private lazy var cityOfCarrierTextField : UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = false
        tf.placeholder = "나고야"
        tf.backgroundColor = .clear
        tf.font = UIFont.notoSansCJKKr_regular(fontSize: 16)
        tf.textColor = UIColor(red: 51, green: 51, blue: 51)
        tf.addTarget(self, action: #selector(showPickerView), for: .touchUpInside)
        return tf
    }()
    
    
    private lazy var cityPickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate   = self
        pickerView.dataSource = self
        
        return pickerView
    }()
    
    
    private lazy var pickerContentView : UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        self.view.addSubview(contentView)
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func setupUI() {
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = UIColor(red: 231, green: 231, blue: 231)
        self.makeFirstView()
        self.makeCityPickerView()
    }
    
    
    
    override func setupBind() {
        self.selectedCity    = cities[0]
        self.bindInput()
        self.bindOutput()
    }

    
    private func bindInput(){
        guard let disposeBag = disposeBag,
            let superPageVC = superPageVC else { return }
        
        nextButton.rx.tap
            .take(1)
            .subscribe(onNext:{ [weak self] in
                guard let self = self else { return }
                
                superPageVC.pressedNextButton()
                self.nextButton.isEnabled = false
            } )
            .disposed(by: disposeBag)
    }
    
    
    private func bindOutput(){
        
    }
}


extension AMMakeCityViewController {
    private func makeFirstView(){
        self.view.addSubview(self.cityOfCarrierTextField)
        self.cityOfCarrierTextField.snp.makeConstraints{
            $0.left.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(202)
            $0.right.equalToSuperview().offset(-57)
            $0.height.equalTo(50)
        }
        
        let cityButton = UIButton()
        self.view.addSubview(cityButton)
        cityButton.addTarget(self, action: #selector(showPickerView), for: .touchUpInside)
        cityButton.snp.makeConstraints{
            $0.left.equalTo(self.cityOfCarrierTextField.snp.left)
            $0.top.equalTo(self.cityOfCarrierTextField.snp.top)
            $0.right.equalTo(self.cityOfCarrierTextField.snp.right)
            $0.bottom.equalTo(self.cityOfCarrierTextField.snp.bottom)
        }
        
        let arrowImageView = UIImageView(image: UIImage(named: "dropdown"))
        self.view.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints{
            $0.right.equalTo(self.cityOfCarrierTextField.snp.right)
            $0.centerY.equalTo(self.cityOfCarrierTextField.snp.centerY)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 179, green: 179, blue: 179)
        self.view.addSubview(lineView)
        
        lineView.snp.makeConstraints{
            $0.left.equalTo(self.cityOfCarrierTextField.snp.left)
            $0.right.equalTo(self.cityOfCarrierTextField.snp.right)
            $0.top.equalTo(self.cityOfCarrierTextField.snp.bottom).offset(-5)
            $0.height.equalTo(1)
        }
    }
    
    
    private func makeCityPickerView(){
        self.pickerContentView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(44)
            $0.height.equalTo(0)
        }
        
        self.pickerContentView.addSubview(self.cityPickerView)
        self.cityPickerView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(self.pickerContentView.snp.height)
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
        confirmButton.addTarget(self, action: #selector(hidePickerView), for: .touchUpInside)
        confirmView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-30)
            $0.size.equalTo(35)
        }
        
        guard let disposeBag = disposeBag,
            let superPageVC = superPageVC else { return }
        
        confirmButton.rx.tap
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                self.nextButton.isEnabled = true
                self.nextButton.backgroundColor = UIColor(red: 255, green: 87, blue: 54)
            })
            .map{ _ in
                self.cityOfCarrierTextField.text = self.selectedCity
                return self.selectedCity
            }
            .bind(to: superPageVC.cityOfCarrier)
            .disposed(by: disposeBag)
        
    }
    
}


extension AMMakeCityViewController{
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
        })
    }
}


extension AMMakeCityViewController : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCity    = cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
}


extension AMMakeCityViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
}
