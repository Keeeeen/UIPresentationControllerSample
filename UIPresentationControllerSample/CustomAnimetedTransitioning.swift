//
//  CustomAnimetedTransitioning.swift
//  UIPresentationControllerSample
//
//  Created by K.Kawakami on 2016/11/06.
//  Copyright © 2016年 川上健太郎. All rights reserved.
//

import UIKit

class CustomAnimetedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresent: Bool
    let transitionDuration: TimeInterval
    
    init(isPresent: Bool, transitionDuration: TimeInterval) {
        self.isPresent = isPresent
        self.transitionDuration = transitionDuration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            animatePresentTransition(transitionContext)
        } else {
            animateDissmissalTransition(transitionContext)
        }
    }
    
    func animatePresentTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentingController = transitionContext.viewController(forKey: .from)
        let presentedController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(presentedController!.view, belowSubview: presentingController!.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            presentedController?.view.frame.origin.y -= containerView.bounds.size.height
            presentingController?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion:  { finished in
            transitionContext.completeTransition(true)
            
        })
    }
    
    func animateDissmissalTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentedController = transitionContext.viewController(forKey: .from)
        let presentingController = transitionContext.viewController(forKey: .to)
        
        let containerView = transitionContext.containerView
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            presentedController?.view.frame.origin.y = containerView.bounds.size.height
            presentingController?.view.transform = CGAffineTransform.identity
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}
