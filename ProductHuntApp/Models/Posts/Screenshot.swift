
import Foundation

struct Screenshot:Codable {
    let small: String
    let big: String
    
    enum CodingKeys: String, CodingKey {
    case small = "300px"
    case big = "850px"
    
    }

    
}

