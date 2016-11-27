//
//  FirstViewController.swift
//  DSU
//
//  Created by мак on 05.11.16.
//  Copyright © 2016 мак. All rights reserved.
//

import UIKit
import Alamofire
import Fuzi

class FirstViewController: UIViewController, UITableViewDataSource {
    class New {
        let title: String
        let previewImageURL: String
        let url: String
        
        init(title: String, previewImageURL: String, url: String) {
            
            self.title = title
            self.previewImageURL = previewImageURL
            self.url = url
            
        }
            
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    var News: Array<String> = []
    
    

    override func viewDidLoad() {
        tableview.dataSource = self
        super.viewDidLoad()
        
        
        Alamofire.request("http://dgu.ru/", method: .get).responseString { response in
            
            let html = response.data
            
            do {
                let doc = try HTMLDocument(data: html!)
                
                let new = doc.root!.firstChild(xpath: "//body/div/div/div/div/div/div/div/div/table/tr/td")!
                
            //body/div/div/div/div/div/div/div/div/table/tr/td
                
              let title = new.firstChild(xpath: "div/a")!["title"]
                
              let previewImageURL = new.firstChild(xpath: "div/p/image")!["scr"]
                
              let url = new.firstChild(xpath: "div/a")!["href"]
                
                print(title)
                print(previewImageURL)
                print(url)
              

                
                self.tableview.reloadData()
               
            } catch {
                print(error)
                print("New array is \(self.News)")
                
                
                
                
            }
            
            
        
           
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return News.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        //cell.textLabel?.text = self.News[indexPath.row]
        //var newws = News[indexPath.row]
        cell.NewsLabel.text = self.News[indexPath.row]
        //cell.imageView?.image = self.
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 

}

