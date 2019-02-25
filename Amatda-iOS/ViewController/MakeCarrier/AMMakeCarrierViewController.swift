//
//  AMMakeCarrierViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 16/02/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit


class AMMakeCarrierViewController: AMBaseViewController, AMCanShowAlert{
    private var pageIndex : Int = 0
    private var pageViewController : UIPageViewController!
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPageViewController(index:0),
                self.newPageViewController(index:1),
                self.newPageViewController(index:2)]
    }()
    
    private var progressBackView : UIView      = UIView()
    private var progressFrontView: UIView      = UIView()
    private var zipperImageView  : UIImageView = UIImageView()
    private var disposeBag = DisposeBag()
    
    var cityOfCarrier     = BehaviorSubject<Int>(value: 0)
    var dayOfCarrier      = BehaviorSubject<String>(value: "")
    var timeOfCarrier     = BehaviorSubject<String>(value: "")
    var optionCarrier     = BehaviorRelay<[Int]>(value: [])
    let didTapRegister    = PublishSubject<[Int]>()
    let registerError     = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setPageViewController(index: 0)
    }
    
    
    override func setupUI() {
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "MakePageViewController") as? UIPageViewController
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageIndex = 0

        
        setupProgressView()
        self.view.addSubview(self.zipperImageView)
        self.zipperImageView.image = UIImage(named: "zipper")
        self.zipperImageView.snp.makeConstraints{
            $0.width.equalTo(12)
            $0.height.equalTo(28)
            $0.top.equalTo(self.progressBackView.snp.bottom)
            $0.centerX.equalTo(self.progressFrontView.snp.right)
        }
    }
    
    override func setupBind() {
        self.pageViewController.dataSource = self
        self.pageViewController.delegate   = self
        bindInput()
        bindOutput()
    }
    
    
    private func bindInput(){
        
    }
    
    
    private func bindOutput(){
        
        let date = Observable.combineLatest(dayOfCarrier,timeOfCarrier, resultSelector:{ s1,s2 in
            return "\(s1) \(s2)"
        })
        
        let requiredCarrierInfo = Observable.combineLatest(cityOfCarrier,
                                                           date,
                                                           optionCarrier){($0,$1,$2)}
        
        
        
        didTapRegister
            .bind(to: optionCarrier)
            .disposed(by: disposeBag)
        
        
        
        let register = didTapRegister
            .withLatestFrom(requiredCarrierInfo)
            .flatMapLatest{
                APIClient.registerCarrier(countryID: $0, startDate: $1, options: $2)
                    .do(onError:{ _ in
                        self.registerError.onNext("")
                    }).suppressError()
            }.asDriver(onErrorJustReturn: Carrier(carrierID: 0,
                                                  startDate: "",
                                                  carrierName: "",
                                                  carrierCountryID: 0))
        
        
        
        register.drive(onNext:{
            self.showMain($0)
        }).disposed(by: disposeBag)
        
        
        
        self.registerError
            .asDriver(onErrorJustReturn: "")
            .drive(onNext:{ _ in
                self.showAlert(title: "오류", message: String.errorString)
        }).disposed(by: disposeBag)
    }
    
    
    
    private func setupNavi(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    
    private func setupProgressView() {
        self.view.addSubview(self.progressBackView)
        self.view.addSubview(self.progressFrontView)
        
        self.progressBackView.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        self.progressFrontView.backgroundColor = UIColor(red: 255, green: 87, blue: 54)
        
        self.progressBackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(4)
        }
        
        
        self.progressFrontView.snp.makeConstraints{
            let width = self.view.frame.width - 40
            let progressWidth = width * 1.0 / 3.0
            $0.top.equalTo(self.progressBackView.snp.top)
            $0.left.equalTo(self.progressBackView.snp.left)
            $0.width.equalTo(progressWidth)
            $0.bottom.equalTo(self.progressBackView.snp.bottom)
        }
    }
    
    
    
    func pressedNextButton(){
        self.progressFrontView.superview?.layoutIfNeeded()
        guard self.pageIndex < self.orderedViewControllers.count - 1 else { return }
        self.pageIndex += 1
        setPageViewController(index: self.pageIndex)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.progressFrontView.snp.remakeConstraints{
                let width = self.progressBackView.frame.width
                let progressWidth = width * CGFloat(self.pageIndex+1) / 3.0
                $0.width.equalTo(progressWidth)
                $0.top.equalTo(self.progressBackView.snp.top)
                $0.left.equalTo(self.progressBackView.snp.left)
                $0.bottom.equalTo(self.progressBackView.snp.bottom)
            }
            self.progressFrontView.superview?.layoutIfNeeded()
        }) { (finished) in
            
        }
    }
    
    
    
    private func showMain(_ carrier : Carrier){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let root = mainStoryboard.instantiateViewController(withIdentifier: "AMMainViewController") as! AMMainViewController
        CarrierInfo.currentCarrierIndex = AMCarrierStack().count
        AMCarrierStack().push(carrier)
        root.isFirstAccess = true
        let vc = UINavigationController(rootViewController: root)
        appDelegate?.searchFrontViewController().present( vc, animated: true, completion: nil)
    }
}



extension AMMakeCarrierViewController {
    private func newPageViewController(index: Int) -> UIViewController {
        var vc : UIViewController?
        switch index {
        case 0:
            vc = self.storyboard?.instantiateViewController(withIdentifier: "AMMakeOptionViewController") as! AMMakeCityViewController
            (vc as! AMMakeCityViewController).superPageVC = self
            (vc as! AMMakeCityViewController).disposeBag  = disposeBag
            break
        case 1:
            vc = self.storyboard?.instantiateViewController(withIdentifier: "AMCarrierTimeViewController") as! AMCarrierTimeViewController
            (vc as! AMCarrierTimeViewController).superPageVC = self
            (vc as! AMCarrierTimeViewController).disposeBag  = disposeBag
            break
        case 2:
            vc = self.storyboard?.instantiateViewController(withIdentifier: "AMCarrierOptionViewController") as! AMCarrierOptionViewController
            (vc as! AMCarrierOptionViewController).superPageVC = self
            (vc as! AMCarrierOptionViewController).disposeBag  = disposeBag
            break
        default:
            break
        }
        
        return vc!
    }
    
    
    private func setPageViewController(index : Int){
        guard index < orderedViewControllers.count else { return }
        let mainViewController = orderedViewControllers[index]
        self.pageViewController.setViewControllers([mainViewController],
                                                   direction: .forward,
                                                   animated: true,
                                                   completion: nil)
    }
}



extension AMMakeCarrierViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard orderedViewControllers.count > previousIndex else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        pageViewController.disableSwipeGesture()
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else { return nil }
        guard orderedViewControllersCount > nextIndex else { return nil }
        
        
        return orderedViewControllers[nextIndex]
    }
}



extension AMMakeCarrierViewController  : UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let currentPage = orderedViewControllers.index(of:pendingViewControllers[0])
        self.pageIndex = currentPage ?? 0
        pageViewController.disableSwipeGesture()
    }
}

