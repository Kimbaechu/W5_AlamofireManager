//
//  Router.swift
//  W5_Alamofire
//
//  Created by Beomcheol Kwon on 2021/01/28.
//

import Foundation
import Alamofire

let token = "non-public"

enum Router {
    case getPost(board: String, post: String)
    case addPost(board: String, title: String, content: String)
    case editPost(board: String, post: String, title: String, content: String)
    case deletePost(board: String, post: String)
    
    var baseURL: String {
        switch self {
        default:
            return "http://api.pandagom.kr/v1"
        }
    }
    
    var path: String {
        switch self {
        case .getPost(board: let boardNum, post: let postNum),
             .editPost(board: let boardNum, post: let postNum, title: _, content: _),
             .deletePost(board: let boardNum, post: let postNum):
            return "/boards/\(boardNum)/posts/\(postNum)"
        case .addPost(board: let boardNum, title: _, content: _):
            return "/boards/\(boardNum)/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPost:
            return .get
        case .addPost:
            return .post
        case .editPost:
            return .put
        case .deletePost:
            return .delete
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .getPost:
            return nil
        case .addPost(board: _, title: let title, content: let content):
            return ["title": title, "content": content, "anonymous": "0"]
        case .editPost(board: _, post: _, title: let title, content: let content):
            return ["title": title, "content": content]
        case .deletePost:
            return nil
        }
    }
}

extension Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
                .encode(parameters, into: request)
        } else if method == .post || method == .put {
            request.httpBody = try URLEncodedFormEncoder().encode(parameters)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Origin")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "X-Requested-With")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
            print(String(data: request.httpBody!, encoding: .utf8))
        }
        
        return request
    }
}
