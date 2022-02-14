//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Rachel Sacdalan on 2/8/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    @objc func loadTweet() {
        numberOfTweet = 20
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count" : numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
        self.tweetArray.removeAll()
        for tweet in tweets {
            self.tweetArray.append(tweet)
        }
            
        self.tableView.reloadData()
        self.myRefreshControl.endRefreshing()

        }, failure: { (Error) in
            print("Error in getting Tweets")
        })
    }
    
    func loadMoreTweets() {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet = numberOfTweet + 20
        let myParams = ["count" : numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
        self.tweetArray.removeAll()
        for tweet in tweets {
            self.tweetArray.append(tweet)
        }
        self.tableView.reloadData()
        }, failure: { (Error) in
            print("Error in getting Tweets")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row + 1 == tweetArray.count) {
            loadMoreTweets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweet()
    }

    @IBAction func logOutTapped(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
        print("User logged out!")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.setLike(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
