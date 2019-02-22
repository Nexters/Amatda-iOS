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


class AMMainViewController: AMBaseViewController, AMViewControllerNaviSetAble, AMViewControllerBottomUISetAble, AMCanShowAlert {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var leftButton              : UIButton? = UIButton()
    var rightButton             : UIButton? = UIButton()
    var titleLabel              : UILabel?  = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    var subTitleLabel           : UILabel?  = UILabel()
    var rightBarButtonItem      : UIBarButtonItem? = UIBarButtonItem()
    var centerButton            : UIButton? = UIButton()
    var isFirstAccess           : Bool = false
    
    var carrierItem             = BehaviorSubject(value: CarrierModel(carrier: nil, options: nil))
    var packageList : PackageModel?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    private let viewModel   = AMMainViewModel()
    var disposeBag : DisposeBag  {
        return viewModel.disposeBag
    }
    
    
    override func setupUI() {
        super.setupUI()
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
        self.centerButton?.rx.tap.subscribe(onNext:{
            self.pressedCenterButton()
        }).disposed(by: disposeBag)
        
        
        
        self.carrierItem
            .do(onNext:{ model in
                self.titleLabel?.text = model.carrier?.carrierName ?? ""
            })
            .bind(to: viewModel.completeCarrierInfo)
            .disposed(by: disposeBag)
    }
    
    
    
    private func bindOutput(){
        self.viewModel.detailCarrier?
            .drive(self.carrierItem)
            .disposed(by: disposeBag)
        
        
        
        self.viewModel.packageList?.drive(onNext:{
            self.packageList = $0
        }).disposed(by: disposeBag)
        
        
        
        self.viewModel.apiError
            .asDriver(onErrorJustReturn: "")
            .drive(onNext:{ _ in
                self.showAlert(title: "오류", message: String.errorString)
            }).disposed(by: disposeBag)
    }
    
    
    
    private func pressedCenterButton() {
        
        let viewController2 = AMWriteViewController()
        viewController2.modalPresentationStyle = .overCurrentContext
        viewController2.view.backgroundColor   = .clear
        viewController2.carrierItem = CarrierInfo.currentCarrierID()
        viewController2.writeEventBus?
            .asDriver(onErrorJustReturn: ())
            .map{ CarrierInfo.currentCarrierID() }
            .do(onNext:{ s in
                print("\(s)")
            })
            .drive(self.viewModel.viewDidLoad)
            .disposed(by: disposeBag)

        
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
        self.rx.viewWillAppear.map{ CarrierInfo.currentCarrierID() }
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
//        Observable.just(CarrierInfo.currentCarrierID())
//            .bind(to: viewModel.viewDidLoad)
//            .disposed(by: disposeBag)
        self.showCompleteMakeCarrier()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        collectionView.register(AMPackageCell.self, forCellWithReuseIdentifier: "AMPackageCell")
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
        
        return CGSize(width: width, height: 60)
    }
}



extension AMMainViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            if let count = self.packageList?.unCheck?.count {
                return count
            }
            return 0
        case 2:
            if let count = self.packageList?.check?.count {
                return count
            }
            return 0
        default:
            return 0
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AMPackageCell", for: indexPath) as! AMPackageCell
        guard let packageList = self.packageList else { return cell }
        
        if indexPath.section == 1,
            let packageItem = packageList.unCheck?[indexPath.row]{
            
            cell.packageItem = packageItem
        }else if indexPath.section == 2,
            let packageItem = packageList.check?[indexPath.row]{
            
            cell.packageItem = packageItem
        }
        
        
        cell.checkButton.rx.tap
            .map{cell.packageItem!}
            .bind(to:viewModel.tapCheckPackage)
            .disposed(by: cell.disposeBag)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mainHeaderView, for: indexPath) as! AMMainHeaderView
            header.carrierName = self.titleLabel?.text
            return header
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AMPackageHeaderView", for: indexPath) as! AMPackageHeaderView
            if indexPath.section == 1 {
                header.lineView.isHidden = false
            }else{
                header.lineView.isHidden = true
            }
            return header
        }
        
    }
}

