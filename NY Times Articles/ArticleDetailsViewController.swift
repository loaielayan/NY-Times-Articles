//
//  ArticleDetailsViewController.swift
//  NY Times Articles
//
//  Created by loai elayan on 6/25/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleDetailsViewController: UIViewController {
    
    var article: Article?
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()

    }
    



}

extension ArticleDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleDetails")
        
        let imageView = cell?.viewWithTag(101) as! UIImageView
        let title = cell?.viewWithTag(102) as! UILabel
        let date = cell?.viewWithTag(103) as! UILabel
        let textView = cell?.viewWithTag(104) as! UILabel
        
        if self.article?.media?.count != 0{
            
            if let mediaMetadata = self.article?.media?[0]["media-metadata"] as? [[String:Any]]{
                
                if let urlString = mediaMetadata[2]["url"] as? String{
                    print(urlString)
                    if let url = URL(string: urlString){
                        imageView.sd_setImage(with: url) { (image, error, sdimagecahetype, url) in
                            
                        }
                    }
                }
            }
        }
        
        title.text = article?.title
        date.text = article?.published_date
        textView.text = article?.abstract
                
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
}
