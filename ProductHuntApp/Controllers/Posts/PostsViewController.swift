

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topicButton: UIButton!
    
    @IBAction func topicButtonAction(_ sender: Any) {
    }
    
    var postsToDIsplay: [Post] = []
    var topicToDisplay: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if topicToDisplay == "" {
        defaultSetup()
        topicButton.setTitle("Tech", for: .normal)
        } else { self.tableView.reloadData() }
        self.tableView.rowHeight = 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "postInfo" {
            let cell = sender as! PostTableViewCell
            let selectedPost: [Post]
            
            selectedPost = postsToDIsplay.filter({$0.name == cell.nameLabel.text})
            if selectedPost.count == 0 {
                fatalError()
            }
            
            let detailVC = segue.destination as! DetailViewController
            
            detailVC.postToDisplay = selectedPost[0]
            
            
        }
    }
    
    func setupTitle(desiredTitle: String) {
        topicButton.setTitle(desiredTitle, for: .normal)
    }
    
    func setupPosts(slug: String) {
        let requestService = RequestService()
        requestService.getPostsForTopic(topicSlug: slug) { [weak self] recievedPosts in
            self!.postsToDIsplay = recievedPosts
            self!.tableView.reloadData()
        }
    }
    
    func defaultSetup(){
    let requestService = RequestService()
        requestService.getPostsForTopic(topicSlug: "tech") { [weak self] recievedPosts in
            self!.postsToDIsplay = recievedPosts
            //print("Было загружено: \(self!.postsToDIsplay.count)")
            self!.tableView.reloadData()
            
        }
    }
    
}
