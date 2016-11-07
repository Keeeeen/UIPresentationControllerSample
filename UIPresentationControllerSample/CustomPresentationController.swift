//
//  CustomPresentationController.swift
//  UIPresentationControllerSample
//
//  Created by K.Kawakami on 2016/11/06.
//  Copyright © 2016年 川上健太郎. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {

    var overlayView = UIView()
    
    // 表示トランジション開始前
    override func presentationTransitionWillBegin() {
        
        guard let containerView = self.containerView else {
            return
        }
        
        overlayView.frame = containerView.frame
        overlayView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(CustomPresentationController.overlayViewDidTapped(_:)))]
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0.0
        containerView.insertSubview(overlayView, at: 0)
        
        // Transition
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlayView.alpha = 0.6
        }, completion: nil)
    }
    
    // 非表示トランジション開始前
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlayView.alpha = 0.0
        }, completion: nil)
    }
    
    // 非表示トランジション開始後
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    // 子コンテナのサイズ
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: 44*4)
    }
    
    // 呼び出し先のViewControllerのFrameを返す
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerBounds = containerView?.bounds else {
            return CGRect.zero
        }
        var presentedViewFrame = CGRect.zero
        presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = containerBounds.size.width - presentedViewFrame.size.width
        presentedViewFrame.origin.y = containerBounds.size.height - presentedViewFrame.size.height
        
        return presentedViewFrame
    }
    
    // レイアウト開始前
    override func containerViewWillLayoutSubviews() {
        guard let containerView = self.containerView, let presentedView = self.presentedView else {
            return
        }
        overlayView.frame = containerView.bounds
        presentedView.frame = frameOfPresentedViewInContainerView
    }
    
    // レイアウト開始後
    override func containerViewDidLayoutSubviews() {
    }
    
    func overlayViewDidTapped(_ sender: UITapGestureRecognizer){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
