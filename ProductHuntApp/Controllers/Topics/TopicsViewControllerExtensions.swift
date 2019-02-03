

import Foundation
import UIKit

extension TopicsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.topicsTableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicCell
        let selectedTopic: Topic = topicsToShow[indexPath.row]
        //configure the cell:
        cell.nameLabel.text = selectedTopic.name
        cell.descriptionLabel.text = selectedTopic.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
