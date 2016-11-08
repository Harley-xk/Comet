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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Path.applicationSupport().resource("data.Sqlite").string
        print(path)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

