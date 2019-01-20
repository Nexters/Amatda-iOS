//
//  AMPresentAnimateViewController.swift
//  Amatda-iOS
//
//  Created by Haehyeon Jeong on 06/01/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class AMPresentAnimateViewController: AMBaseViewController {
    fileprivate var isPresenting     = false
    lazy var animateSetting : AMPresentAnimateSetting = AMPresentAnimateSetting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate  = self
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    }
    
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    
    func onWillPresentView(){
        self.view.layoutIfNeeded()
        //override
    }
    
    func performCustomPresentationAnimation() {
        self.view.layoutIfNeeded()
        //override
    }
    
    
    func onWillDismissView(){
        //override
    }
    
    
    func performCustomDismissingAnimation() {
        //override
    }
}


extension AMPresentAnimateViewController : UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}



extension AMPresentAnimateViewController : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? 0 : animateSetting.animation.present.duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let fromView = fromViewController.view
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = toViewController.view
        
        if isPresenting{
            
            containerView.addSubview(toView!)
            
            containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            toView?.frame = fromView?.bounds ?? CGRect.zero
            toView?.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            
            transitionContext.completeTransition(true)
            presentView(animationDuration: animateSetting.animation.present.duration, completion: { complted in
                
            })
            
        }else{
            
            
            dismissView(fromView!, presentingView: toView!, animationDuration: animateSetting.animation.dismiss.duration) { completed in
                if completed {
                    fromView?.removeFromSuperview()
                }
                transitionContext.completeTransition(completed)
            }
        }
    }
    
    
    func presentView(animationDuration: Double, completion: ((_ completed: Bool) -> Void)?) {
        onWillPresentView()
        self.view?.layoutIfNeeded()
        let animationSettings = animateSetting.animation.present
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationSettings.delay,
                       usingSpringWithDamping: animationSettings.damping,
                       initialSpringVelocity: animationSettings.springVelocity,
                       options: animationSettings.options.union(.allowUserInteraction),
                       animations: { [weak self] in
                        
                        self?.performCustomPresentationAnimation()
                        self?.view?.layoutIfNeeded()
            },
                       completion: {  finished in
                        completion?(finished)
                        
        })
    }
    
    
    
    func dismissView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?) {
        onWillDismissView()
        let animationSettings = animateSetting.animation.dismiss
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationSettings.delay,
                       usingSpringWithDamping: animationSettings.damping,
                       initialSpringVelocity: animationSettings.springVelocity,
                       options: animationSettings.options.union(.allowUserInteraction),
                       animations: { [weak self] in
                        if let _ = self?.animateSetting.animation.scale {
                            presentingView.transform = CGAffineTransform.identity
                        }
                        self?.performCustomDismissingAnimation()
                        self?.view?.layoutIfNeeded()
            },
                       completion: { _ in
                        completion?(true)
        })
    }
}
