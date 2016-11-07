//
//  ViewController.swift
//  UIPresentationControllerSample
//
//  Created by K.Kawakami on 2016/11/06.
//  Copyright © 2016年 川上健太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonTapped(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "modal") as? TableViewController
        controller?.modalPresentationStyle = .custom
        controller?.transitioningDelegate = self
        controller?.delegates = self
        self.present(controller!, animated: true, completion: nil)
    }
}
extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
    

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimetedTransitioning(isPresent: true, transitionDuration: 0.3)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimetedTransitioning(isPresent: false, transitionDuration: 0.3)
    }
}

extension ViewController: TableViewControllerDelegate {
    func didSelectCell() {
        performSegue(withIdentifier: "second", sender: nil)
    }
}
