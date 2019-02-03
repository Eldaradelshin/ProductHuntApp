
import Foundation

struct Post: Codable {
    let name: String
    let tagline: String
    let votes_count: Int
    let thumbnail: Thumbnail
    let screenshot_url: Screenshot
}
