//
//  ArticlesFeedViewController.swift
//  NY Times Articles
//
//  Created by loai elayan on 6/24/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import SDWebImage

class ArticlesFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        getpopularArticles()

    }
    
    func getpopularArticles()
    {
        RequestManager.sharedInstance.getpopularArticles(success: { (articles) in
            
            self.articles = articles ?? [Article]()
            self.tableView.reloadData()
            
        }, failed: { (error) in
            
        }) {
            
        }
    }
    
    var selectedArticle: Article?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowArticle"{
            if let vc = segue.destination as? ArticleDetailsViewController{
                vc.article = selectedArticle
            }
        }
    }
    
    

    

}

extension ArticlesFeedViewController: UITableViewDelegate, UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell")
        let imageView = cell?.viewWithTag(101) as! UIImageView
        let title = cell?.viewWithTag(102) as! UILabel
        let subTitle = cell?.viewWithTag(103) as! UILabel
        let date = cell?.viewWithTag(104) as! UILabel
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        //let m = articles[indexPath.row].media?[0]
        if articles[indexPath.row].media?.count != 0{
            
            if let mediaMetadata = articles[indexPath.row].media?[0]["media-metadata"] as? [[String:Any]]{
                
                if let urlString = mediaMetadata[0]["url"] as? String{
                    print(urlString)
                    if let url = URL(string: urlString){
                        imageView.sd_setImage(with: url) { (image, error, sdimagecahetype, url) in
                            
                        }
                    }
                }
            }
        }
        
        if imageView.image == nil{
            imageView.image = UIImage(named: "png-transparent-new-york-city-the-new-york-times-company-logo-newspaper-t-uuml-rkiye-miscellaneous-company-monochrome-thumbnail")
        }
        
        
        
        title.text = articles[indexPath.row].title
        subTitle.text = articles[indexPath.row].byline
        date.text = articles[indexPath.row].published_date
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 145
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedArticle = articles[indexPath.row]
        self.performSegue(withIdentifier: "ShowArticle", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
