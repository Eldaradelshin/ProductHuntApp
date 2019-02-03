
import UIKit

class DetailViewController: UIViewController {
    
    var postToDisplay: Post? = nil

  
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailVotesLabel: UILabel!
    @IBOutlet weak var detailThumbnail: UIImageView!
    @IBOutlet weak var detailScreenshot: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if postToDisplay != nil {
            //print(postToDisplay?.name ?? "Не найдено")
            detailNameLabel.text = postToDisplay?.name
            detailVotesLabel.text = "Votes: \(postToDisplay?.votes_count ?? 0)"
            detailDescription.text = postToDisplay?.tagline
            detailThumbnail.cacheImage(urlString: (postToDisplay?.thumbnail.image_url)!)
            detailScreenshot.cacheImage(urlString: (postToDisplay?.screenshot_url.small)!)
        }
    }
}
