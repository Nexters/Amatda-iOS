//
//  AMMenuViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 22/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

class AMMenuViewController: AMPresentAnimateViewController {
    
    private lazy var menuView = AMMenuView(controlBy : self)
    var carrierEventBus      : Driver<IndexPath>?
    var goWriteEventBus        : Driver<IndexPath>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = self.menuView
    }
    
    
    override func onWillPresentView(){
        self.menuView.onWillPresentView()
    }
    
    
    override func onWillDismissView(){
        self.menuView.onWillDismissView()
    }
    
    
    override func performCustomPresentationAnimation(){
        self.menuView.performCustomPresentationAnimation()
    }
    
    
    override func performCustomDismissingAnimation(){
        self.menuView.performCustomDismissingAnimation()
    }
}


extension AMMenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView()
            let lineView = UIView()
            headerView.addSubview(lineView)
            lineView.snp.makeConstraints{
                $0.left.equalToSuperview().offset(24)
                $0.right.equalToSuperview().offset(-24)
                $0.height.equalTo(1)
                $0.centerY.equalToSuperview()
            }
            lineView.backgroundColor = UIColor(red: 231, green: 231, blue: 231)
            return headerView
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }
}


extension AMMenuViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return AMCarrierStack().count + 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AMMenuCell = tableView.dequeueReusableCell(withIdentifier: "AMMenuCell", for: indexPath) as! AMMenuCell
        if indexPath.section == 0 {
            
            let title = AMCarrierStack().carrierAt(index: indexPath.row)?.carrierName ?? ""
            if indexPath.row == CarrierInfo.currentCarrierIndex {
                cell.selectionType = .carrier(title, true)
            }else if indexPath.row == AMCarrierStack().count{
                cell.selectionType = .addCarrier
            }else{
                cell.selectionType = .carrier(title, false)
            }
            
            
        }else{
            if indexPath.row == 0 {
                cell.selectionType = .pushOption
            }else{
                cell.selectionType = .termsOfService
            }
        }
        
        return cell
    }
}



