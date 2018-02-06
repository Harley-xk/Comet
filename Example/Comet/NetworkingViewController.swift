//
//  NetworkingViewController.swift
//  Comet_Example
//
//  Created by Harley.xk on 2018/2/4.
//

import UIKit
import Comet

typealias Model = (ModelDecodable & Codable)

public struct User: Model {
}

public struct LoginContent: Model {
    
}

public class AuthTask {
    
    public class func login() -> Task<LoginContent> {
        return Task(method: .post, api: "api/login", params: [:])
    }
    
    public class func userInfo() -> Task<User> {
        return Task(api: "xxx")
    }
    
}


class NetworkingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let server = Server(scheme: "http", host: "wthrcdn.etouch.cn")
        TaskCenter.main.server = server
        let task = Task<String>(method: .get, api: "weather_mini", params: ["citykey": "101010100"])
        self.record(task: task)
        TaskCenter.main.startTask(task) { (resp) in
            
        }
        
        let userTask = AuthTask.userInfo()
        self.record(task: userTask)
        TaskCenter.main.startTask(userTask) { (res) in
            let user = res.model
            print(user.debugDescription)
        }
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
