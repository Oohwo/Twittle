//
//  LoginViewController.swift
//  Twitter
//
//  Created by Rachel Sacdalan on 2/8/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "userLoggedIn") == true) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        let myURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myURL, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
        }, failure: { (Error) in
            print("User failed to log in!")
        })
    }
    
    

}
