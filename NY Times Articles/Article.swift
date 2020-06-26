//
//  Article.swift
//  NY Times Articles
//
//  Created by loai elayan on 4/5/20.
//  Copyright © 2020 Aya Irshaid. All rights reserved.
//

import Foundation

class Article
{
    
    var published_date: String?
    var title: String?
    var abstract: String?
    var byline: String?
    var media: [[String:Any]]?

    
    
    static func getArticle(dir: Dictionary<String, Any>)->Article
    {
        
        let article = Article()
        
        article.published_date = dir["published_date"] as? String
        article.title = dir["title"] as? String
        article.abstract = dir["abstract"] as? String
        article.byline = dir["byline"] as? String
        article.media = dir["media"] as? [[String:Any]]
        

        return article
    }
    
}
