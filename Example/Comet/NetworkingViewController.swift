//
//  NetworkingViewController.swift
//  Comet_Example
//
//  Created by Harley.xk on 2018/2/4.
//

import UIKit
import Comet

class NetworkingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let server = Server(scheme: "http", host: "wthrcdn.etouch.cn")
        TaskCenter.main.server = server
        let task = Task(method: .get, api: "weather_mini", params: ["citykey": "101010100"])
        task.start()
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
