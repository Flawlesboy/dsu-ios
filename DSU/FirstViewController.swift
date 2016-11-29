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

    
    @IBOutlet weak var tableview: UITableView!
    
    var news = [New]()
    
    

    override func viewDidLoad() {
        tableview.dataSource = self
        super.viewDidLoad()
        
        
        Alamofire.request("http://dgu.ru/", method: .get).responseString { response in
            
            let html = response.data
            
            do {
                let doc = try HTMLDocument(data: html!)
                
                let newsArray = doc.root!.firstChild(xpath: "//body/div/div/div/div/div/div/div/div/table/tr/td")!
                
                for news in newsArray.children {
                    let title = news.firstChild(xpath: "div/a")!["title"]!
                    
                    let hostURL: String = "http://dgu.ru"
                    
                    let previewImageURL = hostURL + news.firstChild(xpath: "div")!.children(tag: "div")[1].firstChild(xpath: "p/img")!["src"]!
                    
                    let url = hostURL + news.firstChild(xpath: "div/a")!["href"]!
                    
                    let new = New(title: title, previewImageURL: previewImageURL, url: url)
                    
                    self.news.append(new)
                }
                
                self.tableview.reloadData()
               
            } catch {
                print(error)
            }
            
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        //cell.textLabel?.text = self.News[indexPath.row]
        //var newws = News[indexPath.row]
        cell.NewsLabel.text = self.news[indexPath.row].title
        //cell.imageView?.image = self.
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 

}

