//
//  FeedViewController.swift
//  parstagram
//
//  Created by Osama Soliman on 3/5/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource=self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                print("found posts")
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.uerNameLable.text = user.username
        cell.captionLable.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let URLString = imageFile.url!
        let url = URL(string: URLString)!
        cell.photoView.af_setImage(withURL: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let comment = PFObject(className: "Comments")
        comment["text"] = "this is a random comment"
        comment["post"] = post
        comment["author"] = PFUser.current()!
        post.add(comment, forKey: "comments")
        post.saveInBackground { (success, error) in
            if success{
                print("comment saved successfully")
            }else{
                print("error saving comment")
            }
        }
    }
    
    @IBAction func onLogoutBtutton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = LoginViewController
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
