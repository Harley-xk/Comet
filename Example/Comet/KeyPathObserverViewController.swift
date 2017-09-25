//
//  KeyPathObserverViewController.swift
//  Comet
//
//  Created by Harley.xk on 2017/8/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Comet

class KeyPathObserverViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.addObserver(for: "contentOffset") { (_, change, _) in
            print("Content Offset: \(self.textView.contentOffset)")
        }        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.removeObserver(for: "contentOffset")
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
