
import UIKit

class TopicsViewController: UIViewController {
    
    var topicsToShow = [Topic]()

    @IBOutlet weak var topicsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topicsTableView.rowHeight = 120
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let requestService = RequestService()
        requestService.getPopularTopics() { [weak self] recievedTopics in
            self?.topicsToShow = recievedTopics
            //print(self!.topicsToShow)
            self?.topicsTableView.reloadData()
            
        }
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
}
