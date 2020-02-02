//
//  LeaderTwoViewController.swift
//  Xinyuan(Victor)_Huang_matchingApp
//
//  Created by Victor Huang on 2018/12/5.
//  Copyright © 2018年 Period Four. All rights reserved.
//

import UIKit

class LeaderTwoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // create dictionaries and arrays that store leaderBoards
    var namesT: [String] = []
    var scoresT: [Int] = []
    
    // set the number of elements to UITableView rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesT.count
    }
    
    // create title "LeaderBOard for timed mode"
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LeaderBoard for Timed Mode"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create UITableViewCell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "LB1", for: indexPath)
        // cell text is namesT
        myCell.textLabel?.text = namesT[indexPath.row]
        // cell subtext is scoresT
        myCell.detailTextLabel?.text = String(scoresT[indexPath.row])
        // return cell
        return myCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // let myLeaderBoard to decode save leaderBoard
        if let myLeaderBoard = UserDefaults.standard.value(forKey: "leaderBoardTimeMode") as? Dictionary<String, Int> {
            someLeaderBoard = myLeaderBoard
            print(someLeaderBoard)
        }
        
        // let newLeaderBoard to sort someLeaderBOard from top value to bottom value
        let newLeaderBoard = someLeaderBoard.sorted(by: {$0.value > $1.value})
        
        // for loop that append kes and values from high to lowest
        for index in newLeaderBoard{
            namesT.append(index.key)
            scoresT.append(index.value)
        }
        
        print(namesT,scoresT)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}
