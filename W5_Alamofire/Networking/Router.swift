//
//  Router.swift
//  W5_Alamofire
//
//  Created by Beomcheol Kwon on 2021/01/28.
//

import Foundation
import Alamofire

let token = "835203117e6c49d84e6f938d3ac19d1f12fb50030dacd09ed6dba8407666c5b4"

enum Router {
    case getPost(String, String)
    case addPost(String, [String: String])
    case editPost(String, String, [String: String])
    case deletePost(String, String)
    
    var baseURL: String {
        switch self {
        default:
            return "http://api.pandagom.kr/v1"
        }
    }
    
    var path: String {
        switch self {
        case .getPost(let boardNum, let postNum),
             .editPost(let boardNum, let postNum, _),
             .deletePost(let boardNum, let postNum):
            return "/boards/\(boardNum)/posts/\(postNum)"
        case .addPost(let boardNum, _):
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
        case .addPost(_, let param):
            return param
        case .editPost(_,  _, let param):
            return param
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
