//
//  ViewController.swift
//  W5_Alamofire
//
//  Created by Beomcheol Kwon on 2021/01/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var boardNumberField: UITextField!
    @IBOutlet weak var postNumberField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func getButtonTapped(_ sender: Any) {
        guard let boardNum = boardNumberField.text,
              let postNum = postNumberField.text else { return }
        
        getPost(board: boardNum, post: postNum)
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let boardNum = boardNumberField.text,
              let title = titleTextField.text,
              let content = contentTextView.text else { return }
//        postTest(board: boardNum, title: title, content: content)
        addPost(board: boardNum, title: title, content: content)
    }
    
    @IBAction func putButtonTapped(_ sender: Any) {
        guard let boardNum = boardNumberField.text,
              let postNum = postNumberField.text,
              let title = titleTextField.text,
              let content = contentTextView.text else { return }
        
        editPost(board: boardNum, post: postNum, title: title, content: content)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let boardNum = boardNumberField.text,
              let postNum = postNumberField.text else { return }
        
        deletePost(board: boardNum, post: postNum)
    }
    
    
    //MARK:- CRUD
    func getPost(board: String, post: String) {
        APIManager.shared.getPost(board: board, post: post) { [weak self] target in
            self?.titleTextField.text = target?.post.title
            self?.contentTextView.text = target?.post.content
        }
    }
    
    func addPost(board: String, title: String, content: String) {
        APIManager.shared.addPost(board: board, title: title, content: content) { [weak self] response in
            if let data = response.data {
                print(String(data: data, encoding: .utf8) ?? "")
            }
            self?.boardNumberField.text = "\(board)"
        }
    }
    
    func editPost(board: String, post: String, title: String, content: String) {
        APIManager.shared.editPost(board: board, post: post, title: title, content: content) { [weak self] response in
            if let data = response.data {
                print(String(data: data, encoding: .utf8) as Any)
            }
            self?.boardNumberField.text = "\(board)"
            self?.postNumberField.text = "\(post)"
        }
    }
    
    func deletePost(board: String, post: String) {
        APIManager.shared.deletePost(board: board, post: post) { response in
            if let data = response.data {
                print(String(data: data, encoding: .utf8) as Any)
            }
        }
    }
    
    func postTest(board: String, title: String, content: String) {
        
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Origin": "application/x-www-form-urlencoded",
            "X-Requested-With": "application/x-www-form-urlencoded",
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/x-www-form-urlencoded"
        ]
        
        let parameters: [String: String] = [
            "title": title,
            "content": content,
            "anonymous": "0"
        ]
        
        AF.request("http://api.pandagom.kr/v1/boards/\(board)/posts", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
            .validate()
            .responseJSON { AFData in
                print(String(data: AFData.data!, encoding: .utf8)!)
            }
    }
}

