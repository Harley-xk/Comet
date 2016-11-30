//
//  ViewController.swift
//  Comet
//
//  Created by Harley.xk on 11/07/2016.
//  Copyright (c) 2016 Harley.xk. All rights reserved.
//

import UIKit
import Comet

class ViewController: UIViewController {

    @IBOutlet weak var line: HairLine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let _ = UIStoryboard.main.create() as ViewController
        
        let vc = ViewController.fromSB()
        print(vc)
                
//        setupKeyboardManager(withPositionConstraint: <#T##NSLayoutConstraint#>, viewToAdjust: <#T##UIView#>)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let date = Date(string: "2013-10-24 12:24:56")
        
        _ = date?.add(2, .day)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class LoginViewController: UIViewController {
    
}

