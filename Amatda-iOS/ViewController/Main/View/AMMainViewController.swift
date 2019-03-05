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
import RxDataSources

class AMMainViewController: AMBaseViewController, AMViewControllerNaviSetAble, AMViewControllerBottomUISetAble, AMCanShowAlert {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var dataSource : RxCollectionViewSectionedAnimatedDataSource<SectionOfPackage>?
    private var isExpanded = [Bool]()
    var leftButton              : UIButton? = UIButton()
    var rightButton             : UIButton? = UIButton()
    var titleLabel              : UILabel?  = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    var subTitleLabel           : UILabel?  = UILabel()
    var rightBarButtonItem      : UIBarButtonItem? = UIBarButtonItem()
    var centerButton            : UIButton? = UIButton()
    var isFirstAccess           : Bool = false
    
    var carrierItem    = BehaviorSubject(value: CarrierModel(carrier: nil, options: nil))
    
    var carrierID  :Int{
        return AMCarrierStack().carrierAt(index: CarrierInfo.currentCarrierIndex)?.carrierID ?? 0
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
        self.centerButton?.rx.tap.subscribe(onNext:{ [weak self] in
            guard let self = self else { return }
            self.pressedCenterButton()
        }).disposed(by: self.disposeBag)
        
        
        
        self.leftButton?.rx.tap.subscribe(onNext:{ [weak self] in
            guard let self = self else { return }
            self.pressedMenuButton()
        }).disposed(by: self.disposeBag)
        
        
        
        self.carrierItem
            .do(onNext:{ [weak self] in
                guard let self = self else { return }
                self.titleLabel?.text = $0.carrier?.carrierName ?? ""
            })
            .bind(to: viewModel.completeCarrierInfo)
            .disposed(by: disposeBag)
    }
    
    
    
    private func bindOutput(){
        guard let dataSource = dataSource else { return }
        self.viewModel.detailCarrier?
            .drive(carrierItem)
            .disposed(by: disposeBag)
        
        
        self.viewModel.packageList?
            .drive(self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        self.viewModel.checkPackage?
            .map{ _ in AMCarrierStack().carrierAt(index: CarrierInfo.currentCarrierIndex)?.carrierID ?? 0 }
            .drive(self.viewModel.viewDidLoad)
            .disposed(by: disposeBag)
        
        
        self.viewModel.apiError
            .asDriver(onErrorJustReturn: "")
            .drive(onNext:{ [weak self] _ in
                guard let self = self else { return }
                self.showAlert(title: "오류", message: String.errorString)
            }).disposed(by: disposeBag)
    }
    
    
    
    private func pressedCenterButton() {
        let viewController2 = AMWriteViewController()
        viewController2.modalPresentationStyle = .overCurrentContext
        viewController2.view.backgroundColor   = .clear
        viewController2.carrierItem = AMCarrierStack().carrierAt(index: CarrierInfo.currentCarrierIndex)
        viewController2.writeEventBus?
            .asDriver(onErrorJustReturn: ())
            .map{ AMCarrierStack().carrierAt(index: CarrierInfo.currentCarrierIndex)?.carrierID ?? 0 }
            .drive(self.viewModel.viewDidLoad)
            .disposed(by: disposeBag)

        
        self.present(viewController2, animated: true, completion: nil)
    }
    
    
    
    private func pressedMenuButton(){
        let vc = AMMenuViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor   = .clear
        vc.carrierEventBus?.do(onNext:{
            CarrierInfo.currentCarrierIndex = $0.row
        }).map{ _ in self.carrierID }
            .drive(self.viewModel.viewDidLoad)
            .disposed(by: disposeBag)
        
        
        vc.goWriteEventBus?.debug().drive(onNext:{ [weak self] _ in
            vc.dismiss(animated: true, completion: {
                guard let self = self else { return }
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let makeVC = mainStoryboard.instantiateViewController(withIdentifier: "AMMakeCarrierViewController")
                
                self.present(makeVC, animated: true, completion: nil)
            })
        }).disposed(by: disposeBag)
        
        self.present(vc, animated: true, completion: nil)
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
        self.rx.viewWillAppear.map{ self.carrierID }
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)

        self.showCompleteMakeCarrier()
        self.isExpanded = Array(repeating: false, count: 3)
    }
    
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.reloadData()
    }
    
    
    
    private func setupCollectionView() {
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: collectionViewDataSourceUI().0,
            configureSupplementaryView: collectionViewDataSourceUI().1
        )
        
        if #available(iOS 11.0, *) {
            self.collectionView.contentInsetAdjustmentBehavior = .never
        }
        self.collectionView.backgroundColor = .white
        self.collectionView.register(AMPackageCell.self, forCellWithReuseIdentifier: "AMPackageCell")
        self.collectionView.register(AMMainHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: mainHeaderView)
        self.collectionView.register(UINib(nibName: "AMPackageHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AMPackageHeaderView")
    }
    
    
    
    private func setupCollectionViewLayout() {
        let layout = AMMainHeaderLayout()
        layout.delegate = self
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        self.collectionView.collectionViewLayout = layout
    }
}


extension AMMainViewController{
    func collectionViewDataSourceUI() -> (
        CollectionViewSectionedDataSource<SectionOfPackage>.ConfigureCell,
        CollectionViewSectionedDataSource<SectionOfPackage>.ConfigureSupplementaryView){
            return (
                { (dataSource, collectionView, indexPath, item) in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AMPackageCell", for: indexPath) as! AMPackageCell
                    
                    cell.packageItem = item
                    cell.checkButton.rx.tap
                        .map{cell.packageItem!}
                        .bind(to:self.viewModel.tapCheckPackage)
                        .disposed(by: cell.disposeBag)
                    cell.isHidden = self.isExpanded[indexPath.section]
                    return cell
            },
                { (dataSource ,collectionView, kind, indexPath) in
                    
                    switch indexPath.section {
                    case 0:
                        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mainHeaderView, for: indexPath) as! AMMainHeaderView
                        header.carrierName = self.titleLabel?.text
                        return header
                        
                    default:
                        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AMPackageHeaderView", for: indexPath) as! AMPackageHeaderView
                        header.headerTitle.text = dataSource[indexPath.section].header
                        header.lineView.isHidden = indexPath.section == 1 ? false : true
                        header.tapExpandableButton?.drive(onNext:{
                            self.isExpanded[indexPath.section] = !self.isExpanded[indexPath.section]
                            self.collectionView.reloadSections(IndexSet(integer: indexPath.section))
                        }).disposed(by: header.disposeBag)
                        return header
                    }
            }
            )
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


extension AMMainViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 164)
        }
        
        return CGSize(width: view.frame.width, height: 38)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isExpanded[indexPath.section] {
            return CGSize(width: collectionView.frame.width, height: 0)
        }
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}
