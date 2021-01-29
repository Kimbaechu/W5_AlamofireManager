//
//  APIManager.swift
//  W5_Alamofire
//
//  Created by Beomcheol Kwon on 2021/01/28.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        return Session(configuration: configuration)
    }()
    
    func getPost(board: String, post: String, completion: @escaping (SinglePost?) -> Void) {
        sessionManager.request(Router.getPost(board, post))
            .responseDecodable(of: SinglePost.self) { response in
                guard let singlePost = response.value else {
                    return completion(nil)
                }
                completion(singlePost)
            }
    }
    
    func addPost(board: String, parameters: [String: String], completion: @escaping (AFDataResponse<Data?>) -> Void) {
        print(#function)
        sessionManager.request(Router.addPost(board, parameters))
            .response { response in
                completion(response)
            }
    }
    
    func editPost(board: String, post: String, parameters: [String: String], completion: @escaping (AFDataResponse<Data?>) -> Void) {
        sessionManager.request(Router.editPost(board, post, parameters))
            .response { response in
                completion(response)
            }
    }
    
    func deletePost(board: String, post: String, completion: @escaping (AFDataResponse<Data?>) -> Void) {
        sessionManager.request(Router.deletePost(board, post))
            .response { response in
                completion(response)
            }
    }
    
   
    
}
