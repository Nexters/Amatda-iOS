//
//  AMMenuViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 22/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import SnapKit

class AMMenuViewController: AMPresentAnimateViewController {

    private lazy var menuView = AMMenuView(controlBy : self)
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
    
}


extension AMMenuViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return AMCarrierStack().count
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AMMenuCell = tableView.dequeueReusableCell(withIdentifier: "AMMenuCell", for: indexPath) as! AMMenuCell
        if indexPath.section == 0 {
            cell.titleStr = AMCarrierStack().carrierAt(index: indexPath.row)?.carrierName ?? ""
        }else{
            cell.titleStr = "ㅇㅇ"
        }
        
        return cell
    }
}




class AMMenuCell : UITableViewCell{
    
    
    private var titleLabel : UILabel = UILabel()
    var titleStr = "" {
        didSet{
            setupUI()
        }
    }
    
    
    private func setupUI(){
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.text = titleStr
    }
}
