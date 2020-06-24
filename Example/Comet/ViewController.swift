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

class ViewController: UITableViewController {
    
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
    
    // MARK: - Samples
    func snapshotSample() {
        let image = navigationController?.view.snapshotImage()
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        imageView.borderColor = .black
        imageView.borderWidth = 1
        imageView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        
        UIView.animate(withDuration: 1, delay: 1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (_) in
            imageView.removeFromSuperview()
        }
    }

}

extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1, indexPath.row == 3 {
            snapshotSample()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class LoginViewController: UIViewController {
    
}

