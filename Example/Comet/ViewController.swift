//
//  ViewController.swift
//  Comet
//
//  Created by Harley.xk on 11/07/2016.
//  Copyright (c) 2016 Harley.xk. All rights reserved.
//

import UIKit
import Comet

class CustomView: UIView {
    
}

class ViewController: UIViewController {

    @IBOutlet weak var line: HairLine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let _ = UIStoryboard.main.create() as ViewController
        
        let vc = ViewController.createFromStoryboard(.main)
        print(vc)
        
        DispatchQueue.global().asyncAfter(delay: 2, execute:{
            print("延迟两秒执行")
        })
        
        DispatchQueue.global().asyncAfter(delay: .nanoseconds(10)) {
            print("延迟两纳秒执行")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let date = Date(string: "2013-10-24 12:24:56")
        
        _ = date?.add(.day(2))
        
        let nextMonth = Date() + .month(1)
        print(nextMonth.dateString())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class LoginViewController: UIViewController {
    
}

