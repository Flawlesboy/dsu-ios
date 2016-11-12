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
    
    var News = ["sdf", "sdfs"]

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://dgu.ru/", method: .get).responseString { response in
            
            let html = response.data
            
            do {
                let doc = try HTMLDocument(data: html!)
                print(doc.root?.children(tag: "body"))
            } catch {
                print(error)
            }
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return News.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 

}

