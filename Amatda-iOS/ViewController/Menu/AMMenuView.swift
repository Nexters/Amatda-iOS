//
//  AMMenuView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 22/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class AMMenuView: AMBaseView, AMViewAnimatable {
    var contentViewHeight: CGFloat? = 296
    
    
    lazy var contentView : UIView? = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        
        return contentView
    }()
    
    
    
    lazy var backgroundView : UIView? = {
        let backView = UIView()
        backView.backgroundColor = .black
        backView.alpha = 0.2
        return backView
    }()
    
    
    
    private lazy var controller : AMMenuViewController? = {
        if self.vc is AMMenuViewController{
            return (self.vc as! AMMenuViewController)
        }
        
        return nil
    }()
    
    
    private lazy var tableView : UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    
    
    
    override func setupUI(){
        setupBaseView()
        setupTableView()
        self.layoutIfNeeded()
        self.backgroundColor = .clear
    }
    
    
    
    override func setupBinding() {
        self.tableView.delegate   = controller
        self.tableView.dataSource = controller
    }
    
    
    
    
    
    private func setupTableView(){
        self.contentView?.addSubview(self.tableView)
        tableView.separatorStyle = .none
        tableView.register(AMMenuCell.self, forCellReuseIdentifier: "AMMenuCell")
        tableView.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
        tableView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}



extension AMMenuView : AMActionAnimate {
    func onWillPresentView(){
        backgroundView!.alpha = 0.0
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
    }
    
    func onWillDismissView(){
        backgroundView!.alpha = 0.4
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    func performCustomPresentationAnimation(){
        backgroundView!.alpha = 0.4
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    func performCustomDismissingAnimation(){
        backgroundView!.alpha = 0.0
        contentView!.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
    }
}


