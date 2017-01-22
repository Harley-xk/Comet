//
//  ScrollViewExtension.swift
//  Comet
//
//  Created by Harley on 2017/1/22.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class ScrollViewExtension: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func leftAction(_ sender: Any) {
        scrollView.scrollToLeft()
    }
    
    @IBAction func rightAction(_ sender: Any) {
        scrollView.scrollToRight()
    }
    
    @IBAction func topAction(_ sender: Any) {
        scrollView.scrollToTop()
    }
    
    @IBAction func bottomAction(_ sender: Any) {
        scrollView.scrollToBottom()
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
