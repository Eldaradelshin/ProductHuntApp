
import Foundation
import Alamofire

class RequestService {
    
    private let accessToken = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    
    let baseUrl = "https://api.producthunt.com/v1"
    let topicsPath = "/topics"
    let postsPath = "/posts"
    
    func getPopularTopics(completion: @escaping (([Topic]) -> Void)) {
         let fullUrl = baseUrl + topicsPath
        let url = URL(string: fullUrl)!
        let parameters: [String: Any] = [ "access_token"     : accessToken,
                                          "search[trending]": true,
                                          "page"            : 1,
                                          "per_page"        : 10]
            
            
        request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success( _):
                let decoder = JSONDecoder()
                let topics: Result<TopicsResponse> = decoder.decodeResponse(from: response)
                //print(posts.value!.posts)
                completion(topics.value!.topics)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func getPostsForTopic(topicSlug: String, completion: @escaping (([Post]) -> Void)) {
            
            let pathForTopic = "/posts/all"
            let fullUrl = baseUrl + pathForTopic
            let url = URL(string: fullUrl)!
            let parameters: [String: Any] = [ "access_token"    : accessToken ,
                                              "search[topic]"   : topicSlug,
                                              "page"            : 1,
                                              "per_page"        : 25           ]
            
            request(url, method: .get, parameters: parameters).responseData { response in
                switch response.result {
                case .success( _):
                    let decoder = JSONDecoder()
                    let posts: Result<PostsResponse> = decoder.decodeResponse(from: response)
                    //print(posts.value!.posts)
                    completion(posts.value!.posts)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    }
