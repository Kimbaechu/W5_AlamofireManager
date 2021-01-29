//
//  Model.swift
//  W5_Alamofire
//
//  Created by Beomcheol Kwon on 2021/01/28.
//

import UIKit

//MARK:- Post
struct Like: Codable {
    let likeID, likeCount: Int?

    enum CodingKeys: String, CodingKey {
        case likeID = "like_id"
        case likeCount = "like_count"
    }
}

struct PhotoContent {
    var photo: UIImage?
    var content: String?
}

struct PostAttach: Codable {
    var attachId: Int?
    var content: String?
    var photoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case attachId = "attach_id"
        case content
        case photoURL = "image_url"
    }
}

struct UploadedFile: Codable {
    let url: String?
    let attachId: Int?
    let fileName: String?
    
    
    enum CodingKeys: String, CodingKey {
        case url
        case attachId = "attach_id"
        case fileName = "file_name"
    }
}

struct User: Codable {
    let id: Int?
    let name: String
    let profileImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImageUrl = "profile_image_url"
    }
}
struct SinglePost: Codable {
    let post: Post
}

struct Post: Codable {
    let id: Int
    let boardId: Int
    let title: String
    let content: String
    let createdAt: String
    let user: User
    let tag: String?
    let postAttachs: [PostAttach]?
    let thumbnail: String?
    let attachCount: Int
    let likeCount: Int
    let scrapCount: Int
    let commentCount: Int
    let isLike: Bool
    var likeId: Int?
    let isScrap: Bool
    let scrapId: Int?
    let isPushAllow: Bool
    let isMine: Bool
    let anonymous: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case boardId = "board_id"
        case title
        case content
        case createdAt = "created_at"
        case user
        case tag
        case postAttachs = "post_attachs"
        case thumbnail = "thumnail"
        case attachCount = "attach_count"
        case likeCount = "like_count"
        case scrapCount = "scrap_count"
        case commentCount = "comment_count"
        case isLike = "is_like"
        case likeId = "like_id"
        case isScrap = "is_scrap"
        case scrapId = "scrap_id"
        case isPushAllow = "is_push_allow"
        case isMine = "is_mime"
        case anonymous
    }
}

struct PostList: Codable {
    let posts: [Post]
    let count: Int
    let isNext: Bool
    
    enum CodingKeys: String, CodingKey {
        case posts, count
        case isNext = "is_next"
    }
}

struct Tag: Codable {
    let id: Int
    let name: String
}

struct TagList: Codable {
    let tags: [Tag]
}

struct Board: Codable {
    let id: Int
    let name: String
    let content: String?
    let isFavorite: Bool
    let isTag: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case content
        case isFavorite = "is_favorite"
        case isTag = "is_tag"
    }
}

struct Category: Codable {
    let id: Int
    let name: String
    let boards: [Board]
}

struct CategoryList: Codable {
    let categories: [Category]
}

struct MainBoard {
    let boardName: String
    let filter: String
}
