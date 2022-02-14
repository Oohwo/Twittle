//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Rachel Sacdalan on 2/8/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var liked : Bool = false
    var tweetId : Int = -1
    var retweeted : Bool = false
    
    func setLike(_ isLiked : Bool) {
        liked = isLiked
        if (liked) {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted : Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        let toBeLiked = !liked
        if (toBeLiked) {
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {
                self.setLike(true)
            }, failure: { (error) in
                print("User failed to like the tweet: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {
                self.setLike(false)
            }, failure: { (error) in
                print("User failed to unlike the tweet: \(error)")
            })
        }
    }
    
    @IBAction func retweetButtonTapped(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("User failed to retweet: \(error)")
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
