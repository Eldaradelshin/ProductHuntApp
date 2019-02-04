
import UIKit

class TopicsViewController: UIViewController {
    
    var topicsToShow = [Topic]()
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var topicsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topicsTableView.rowHeight = 120
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            topicsTableView.refreshControl = refreshControl
        } else {
            topicsTableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshTopics(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading popular topics.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        loadPopularTopics()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPostsForTopic" {
            let cell = sender as! TopicCell
            let selectedTopic: [Topic]
            selectedTopic = topicsToShow.filter({$0.name == cell.nameLabel.text})
            
            if selectedTopic.count == 0 {
                fatalError()
            }
            
            let postVC = segue.destination as! PostsViewController
            postVC.topicButton.setTitle(selectedTopic.first!.name, for: .normal)
            postVC.setupPosts(slug: selectedTopic.first!.slug)
            postVC.topicToDisplay = selectedTopic.first!.slug
            
        }
    }
    
    func loadPopularTopics() {
        
        RequestService.shared.getPopularTopics() { [weak self] recievedTopics in
            self?.topicsToShow = recievedTopics
            //print(self!.topicsToShow)
            self?.topicsTableView.reloadData()
            if self!.refreshControl.isRefreshing {
                print("Updated topics")
                self!.refreshControl.endRefreshing()
            }
            
        }
    }
    
    @objc private func refreshTopics(_ sender: Any) {
        //Fetch topics
        loadPopularTopics()
        
    }
}
