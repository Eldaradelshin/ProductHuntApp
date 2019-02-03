
import Foundation
import UIKit

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        let selectedPost: Post = postsToDIsplay[indexPath.row]
        
        //configure the cell:
        cell.nameLabel.text = selectedPost.name
        cell.descriptionLabel.text = selectedPost.tagline
        cell.upvotesLabel.text = "Votes: \(selectedPost.votes_count)"
        cell.thumbnailImg.cacheImage(urlString: selectedPost.thumbnail.image_url)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsToDIsplay.count
    }
    
}

