//
//  ViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class AMMainViewController: AMBaseViewController, AMViewControllerNaviSetAble, AMViewControllerBottomUISetAble {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var leftButton              : UIButton? = UIButton()
    var rightButton             : UIButton? = UIButton()
    var titleLabel              : UILabel?  = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    var subTitleLabel           : UILabel?  = UILabel()
    var rightBarButtonItem      : UIBarButtonItem? = UIBarButtonItem()
    var centerButton            : AMPlustButton?   = AMPlustButton()
    var isFirstAccess           : Bool = false
    
    private let viewModel   = AMMainViewModel()
    var disposeBag : DisposeBag  {
        return viewModel.disposeBag
    }
    
    
    override func setupUI() {
        super.setupUI()
        titleLabel?.text = "캐리어 1"
        setupNavigation()
        setupBottom()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    
    override func setupBind() {
        super.setupBind()
        bindInput()
        bindOutput()
    }
    
    
    private func bindInput(){
        self.centerButton?
            .rx
            .tap
            .asObservable()
            .bind (to:viewModel.didTap)
            .disposed(by: disposeBag)
        
    }
    
    private func bindOutput(){
        viewModel
            .didTap
            .subscribe( onNext : { [weak self] in
                self?.pressedCenterButton()
            }).disposed(by: disposeBag)
    }
    
    
    private func pressedCenterButton() {
        let viewController2 = AMWriteViewController()
        viewController2.modalPresentationStyle = .overCurrentContext
        viewController2.view.backgroundColor    = .clear
        self.present(viewController2, animated: true, completion: nil)
    }
    
    private func showCompleteMakeCarrier(){
        if isFirstAccess {
            let vc = AMAlertViewController(nibName: "AMAlertViewController", bundle: nil)
            vc.modalPresentationStyle = .overCurrentContext
            vc.view.backgroundColor    = .clear
            self.present(vc, animated: false, completion: nil)
        }
    }
}



extension AMMainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showCompleteMakeCarrier()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.reloadData()
    }
    
    
    private func setupCollectionView() {
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.register(AMMainHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: mainHeaderView)
        collectionView.register(UINib(nibName: "AMPackageHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AMPackageHeaderView")
    }
    
    
    private func setupCollectionViewLayout() {
        let layout = AMMainHeaderLayout()
        layout.delegate = self
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.collectionViewLayout = layout
    }
}


extension AMMainViewController : AMMainHeaderDelegate {
    func recognizeHeaderContentOffset(_: AMMainHeaderLayout, contentOffSetY: CGFloat) {
        let differ = 164 - contentOffSetY
        print("differ : \(differ)")
        if differ > 0 {
            titleLabel?.alpha = 1 - (differ/100)
        }
    }
}


extension AMMainViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}



extension AMMainViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 164)
        }
        
        return CGSize(width: view.frame.width, height: 38)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width
        if UIApplication.shared.statusBarOrientation == .landscapeRight ||
            UIApplication.shared.statusBarOrientation == .landscapeLeft{
            width = (width - 1) / 2
        }else{
            
        }
        
        return CGSize(width: width, height: 40)
    }
}



extension AMMainViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 3
        case 2:
            return 10
        default:
            return 0
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mainHeaderView, for: indexPath)
            return header
        }else{
            if indexPath.section == 1 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AMPackageHeaderView", for: indexPath)
                (header as! AMPackageHeaderView).lineView.isHidden = false
                return header
            }else{
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AMPackageHeaderView", for: indexPath)
                (header as! AMPackageHeaderView).lineView.isHidden = true
                return header
            }
        }
        
    }
}

