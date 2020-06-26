//
//  RequestManager.swift
//  NY Times Articles
//
//  Created by loai elayan on 2/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation
import UIKit
import Alamofire



class RequestManager: NSObject {
    
    static let sharedInstance = RequestManager()
    
    
    
    
    func getpopularArticles(success: @escaping ((_ response: [Article]?)->Void), failed:@escaping ((_ error:NSError?)->Void), finally:(()->Void)?)
    {
        
        
        
        AF.request(Constants.url + Constants.apiKey, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            //
            switch response.result {
            case .success(let value):
                
                if let resultArr = (value as! Dictionary<String, Any>)["results"] as? Array<Dictionary<String, Any>>{ //Dictionary<String, Any>
                    
                    //if let data = resultDir["brands"] as? Array<Dictionary<String, Any>>{
                    
                    var result : [Article] = []
                    for item in resultArr{
                        result.append(Article.getArticle(dir: item))
                    }
                    success(result)
                    
                    if(finally != nil){
                        finally!()
                    }
                    
                }else{
                    success(nil)
                    if(finally != nil){
                        finally!()
                    }
                }
                
                
                if(finally != nil){
                    finally!()
                }
                
                
            case .failure(let error):
                
                self.callFailer(error: response.error!, failed: failed)
                
                if(finally != nil){
                    finally!()
                }
                
            }
            //
            
            
        }
        
        
        
    }
    
    
    func callFailer(error: Error,failed:((_ error:NSError?)->Void)?)
    {
        if(failed == nil){
            return
        }
        
        var resp : Dictionary<String,AnyObject> = [:]
        let xxx = error._userInfo
        
        
        if(xxx is Array<Dictionary<String, Any>>){
            let ar = error._userInfo as! Array<Dictionary<String,AnyObject>>
            resp = ar.first!
        }else{
            resp = error._userInfo as! Dictionary<String, AnyObject>
        }
        
        if(resp.keys.contains("com.alamofire.serialization.response.error.data")){
            let respData = resp["com.alamofire.serialization.response.error.data"] as! Data
            do{
                
                let info = try JSONSerialization.jsonObject(with: respData, options: []) as! Dictionary<String, Any>
                print(info)
                let data = info["data"] as! Dictionary<String, Any>
                let message = data["message"] as! String
                failed!(NSError.init(domain: message, code: data["status_code"] as! Int, userInfo: data))
            }catch{
                failed!(NSError.init(domain: "Unknown", code: -2, userInfo: nil))
            }
        }else{
            failed!(NSError.init(domain: error.localizedDescription, code: -1, userInfo: nil))
        }
        
    }
    
    
    
}


