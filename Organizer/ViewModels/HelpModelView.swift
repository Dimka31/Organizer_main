//
//  HelpModelView.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 05.06.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import Foundation
import Alamofire

struct HelpModelView {
    
    
    func getHelp(completionHandler: @escaping () -> Void) -> [HelpPost] {
        
        var posts: [HelpPost] = []
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            request("http://mindfree.ru/ajax/org_news.php").responseJSON { responseJSON in
                
                switch responseJSON.result {
                case .success(let value):
                    
                    guard let jsonArray = value as? Array<[String: Any]> else { return }
                    
                    for jsonObject in jsonArray {
                        guard
                            let title = jsonObject["title"] as? String,
                            let text = jsonObject["text"] as? String
                            else {
                                return
                        }
                        let post = HelpPost(title: title, text: text)
                        posts.append(post)
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        return posts
    }
}
