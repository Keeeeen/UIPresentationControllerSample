//
//  SecondViewController.swift
//  UIPresentationControllerSample
//
//  Created by K.Kawakami on 2016/11/06.
//  Copyright © 2016年 川上健太郎. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonTapped(_ sender: Any) {
        guard let viewController = presentingViewController as? ViewController else {
            return
        }
        self.dismiss(animated: true, completion: {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "modal") as? TableViewController
            controller?.modalPresentationStyle = .custom
            controller?.transitioningDelegate = viewController
            controller?.delegates = viewController
            viewController.present(controller!, animated: true, completion: nil)
        })
    }
}
