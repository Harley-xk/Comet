//
//  UIBarbuttonItemClosureSample.swift
//  Comet
//
//  Created by Harley.xk on 2017/3/23.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Comet

class UIBarbuttonItemClosureSample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Action", style: .plain, callback: { [weak self] (sender) in
            let alert = UIAlertController(title: "Action!", message: nil, preferredStyle: .alert)
            alert.addAction(title: "确定", style: .cancel)
            self?.present(alert, animated: true, completion: nil)
        })
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, callback: { [weak self] (_) in
            self?.dismiss(animated: true)
        })
    }
    
    deinit {
        print("UIBarbuttonItemClosureSample deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
