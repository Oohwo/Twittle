//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Rachel Sacdalan on 2/13/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userInfo = [NSDictionary]()
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var numTweetsLabel: UILabel!
    
    @objc func loadUser() {
        let myUrl = "https://api.twitter.com/1.1/users.show.json?"
        let myParams = ["userId" : "rs4cd4"]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (userInfo: [NSDictionary]) in
        print(userInfo)
            
        }, failure: { (Error) in
            print("Error in loading user information")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
