//
//  AMPackageHeaderView.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 20/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AMPackageHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var sortImageView: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet private weak var expandableButton: UIButton!
    var tapExpandableButton : Driver<Void>?
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBind()
    }
    
    
    private func setupBind(){
        self.tapExpandableButton = self.expandableButton.rx.tap
            .debug("expandableButton")
            .map{()}
            .asDriver(onErrorJustReturn: ())
    }
}
