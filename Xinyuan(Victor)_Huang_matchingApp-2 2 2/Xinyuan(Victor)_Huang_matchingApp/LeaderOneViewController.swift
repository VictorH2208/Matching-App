//
//  ViewController.swift
//  Xinyuan(Victor)_Huang_matchingApp
//
//  Created by Victor Huang on 2018/12/4.
//  Copyright © 2018年 Period Four. All rights reserved.
//

import UIKit

class LeaderOneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // arrays that store names and scores for leaderBoard
    var names: [String] = []
    var scores: [Int] = []
    
    // the tableView's section is defined by the number of how many names
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    // return title "leaderBoard for Practice Mode" for the table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LeaderBoard for Practice Mode"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create my cell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "LB", for: indexPath)
        // cell text is the names
        myCell.textLabel?.text = names[indexPath.row]
        // cell subtext is string of scores
        myCell.detailTextLabel?.text = String(scores[indexPath.row])
        // return cells
        return myCell
        
    }
    
    // create new dictionary to decode store data

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use if let to decode the dictionary
        if let myLeaderBoard = UserDefaults.standard.value(forKey: "leaderBoard") as? Dictionary<String, Int>{
            // assign the decode dictionary to seondLb
            secondLb = myLeaderBoard
            print(secondLb)
        }
        
        // create constant newLeaderBoard that sort the dictionary
        let newLeaderBoard = secondLb.sorted(by: {$0.value > $1.value})
        
        // create a loop that append the keys and values to names and scores
        for index in newLeaderBoard {
            names.append(index.key)
            scores.append(index.value)
        }
        
        print(names)
        print(scores)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   

}
