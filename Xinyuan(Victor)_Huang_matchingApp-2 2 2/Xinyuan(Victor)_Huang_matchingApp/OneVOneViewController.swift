//
//  OneVOneViewController.swift
//  Xinyuan(Victor)_Huang_matchingApp
//
//  Created by Period Four on 2018-11-28.
//  Copyright © 2018 Period Four. All rights reserved.
//

import UIKit

class OneVOneViewController: UIViewController {
    
    // declare all the outlet
    @IBOutlet var buttonsOnevOne: [UIButton]!
    @IBOutlet weak var pOneName: UILabel!
    @IBOutlet weak var pTwoName: UILabel!
    
    @IBOutlet weak var pOneScoreLabel: UILabel!
    @IBOutlet weak var pTowScoreLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assign palyerName label to text that players entered in main menu
        pOneName.text = FirstString
        pTwoName.text = SecondString
        
        // call the shuffle routine
        myArray = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "3")]
        shuffleArray = []
        
        shuffleRoutine()
        
        // a function that random choose players to begin with
        randomBegin()
        
        // newGameBUttons is hidder at first
        newGameButton.isHidden = true
    }
    
    // create all the variables that is needed in this view controller
    
    // someNumber is the number of times when two buttons failed to be the same
    var someNumber = 0
    
    var numbersOfPressed = 0
    
    var playerOneScore = 0
    var playerTwoScore = 0
    
    var continueSuccessForOne = 0
    var continueSuccessForTwo = 0
    
    var FirstString = ""
    var SecondString = ""
    
    var randomNum = 0
    
    // function that randomly choose a player to begin with
    func randomBegin() {
        
        // assign a random value of 0 or 1 to randomNum
        randomNum = Int.random(in: 0...1)
        // if is 0, player one begins
        if randomNum == 0 {
            arrowImage.image = #imageLiteral(resourceName: "rA-1")
        // if is 1, player two begins
        } else {
            arrowImage.image = #imageLiteral(resourceName: "rA")
        }
    }
    
    // function that determine whose turn is it when there is a succes matching.
    func matchingSuccesDetermineTurnsCase0() {
        
        // if someNumber is even
        if someNumber % 2 == 0 {
            // playerOne get the point and his continueSucces increase by one, and call his scoring function
            pOneName.textColor = UIColor.yellow
            continueSuccessForOne += 1
            scoringForP1()
            
        // if someNumber is odd
        } else if someNumber % 2 == 1 {
            // it is playerTwo who gets the point and his continueSuccess increases by one, and call p2 scoring function
            pTwoName.textColor = UIColor.yellow
            continueSuccessForTwo += 1
            scoringForP2()
        }
    }
    
    // function that determine whose turn is it when there is a success matching. This function's code is opposite to the above function, as different player begin the game
    func matchingSuccesDetermineTurnsCase1() {
        
        // if someNumber is even
        if someNumber % 2 == 0 {
            // it is playerTwo who gets the point and his continueSuccess increases by one, and call p2 scoring function
            pTwoName.textColor = UIColor.yellow
            continueSuccessForTwo += 1
            scoringForP2()
            
        // if someNumber is odd
        } else if someNumber % 2 == 1 {
            // playerOne get the point and his continueSucces increase by one, and call his scoring function
            pOneName.textColor = UIColor.yellow
            continueSuccessForOne += 1
            scoringForP1()
        }
    }
    
    // functions that determine turns when the matching fails. Case0 is for situation that p1 starts the game
    func matchingFailDetermineTurnsCase0() {
        
        // if someNumber is even, its playerOne's turn
        if self.someNumber % 2 == 0 {
            self.arrowImage.image = #imageLiteral(resourceName: "rA-1")
        // vice versa
        } else {
            self.arrowImage.image = #imageLiteral(resourceName: "rA")
        }
    }
    
    // functions that determine turns when the matching fails. Case1 is for situation that p2 starts the game
    func matchingFailDetermineTurnsCase1() {
        // if someNumber is even, its palyerTwo's turn
        if self.someNumber % 2 == 0 {
            self.arrowImage.image = #imageLiteral(resourceName: "rA")
        // vice versa
        } else {
            self.arrowImage.image = #imageLiteral(resourceName: "rA-1")
        }
    }
    
    // function that find the first button's position
    func FirstButtonFound(buttons: [UIButton]) -> Int {
        
        // variable that stores the position
        var something = 1000
        
        // loop 16 times to find which button has an tag of 3 and return the position
        for index in 0...15 {
            if buttons[index].tag == 3{
                something = index
                return something
            }
        }
        
        // return a value of 1000 if the above code fail to work
        return something

    }
    
    // finc the second button's position
    func SecondButtonFound(buttons: [UIButton]) -> Int {
        
        // a variable that stores the second position
        var anotherSomething = 1000
        
        // loop 15 times backwards
        for index in (0...15).reversed() {
            // if the button's tag is 3, return the position
            if buttons[index].tag == 3{
                anotherSomething = index
                return anotherSomething
            }
        }
        
        // return a value of 1000 if the above code does not work
        return anotherSomething
        
    }
    
    // matching function
    func matchingOccurs() {
        
        // if the total number of buttons presses if even
        if numbersOfPressed % 2 == 0 {
            // find the position of the buttons
            let OnePos = FirstButtonFound(buttons: buttonsOnevOne)
            let TwoPos = SecondButtonFound(buttons: buttonsOnevOne)
            
            // if the positions are not 1000, call the compare function
            if OnePos != 1000 && TwoPos != 1000 {
                compareButtons(first: buttonsOnevOne[OnePos], second: buttonsOnevOne[TwoPos])
            }
        }
    }
    
    // create function that compareButtons image
    func compareButtons(first: UIButton, second: UIButton) {
        
        // if the images are the same
        if first.image(for: .normal) == second.image(for: .normal) {
            
            // the two buttons are disabled and tags are set to 2
            first.isEnabled = false
            second.isEnabled = false
            first.tag = 2
            second.tag = 2
            
            // if the randomNum is 0, the following code determine whose turn is it.
            if randomNum == 0 {
                matchingSuccesDetermineTurnsCase0()
            // else if the randomNum is 1. the folloing function determine the turn
            } else if randomNum == 1{
                matchingSuccesDetermineTurnsCase1()
            }
        
        // if the images are not the same
        } else  {
            // set the text color back to white. and reset the continueSuccess variable's to 0
            pOneName.textColor = UIColor.white
            pTwoName.textColor = UIColor.white
            continueSuccessForTwo = 0
            continueSuccessForOne = 0
            // someNumber increase by 1, because this is the time when player switch turns
            someNumber += 1
            // reset the buttons tag to 0
            first.tag = 0
            second.tag = 0
            // use delay function to change back buttons images to logo
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                animation(views: first)
                animation(views: second)
                first.setImage(#imageLiteral(resourceName: "logo.jpg"), for: .normal)
                second.setImage(#imageLiteral(resourceName: "logo.jpg"), for: .normal)
            }
        }
    }
    
    // socring system for playerOne
    func scoringForP1() {
        // increase exponentially with base 2
        playerOneScore += Int((pow(2.0, Double(continueSuccessForOne))))
        // assign player one score to playerOneScore label
        pOneScoreLabel.text = String(playerOneScore)
    }
    
    // scoring system for PlayerTwo
    func scoringForP2() {
        // increase exponentially with base 2
        playerTwoScore += Int((pow(2.0, Double(continueSuccessForTwo))))
        // assign palyer two score to playerTwoScore label
        pTowScoreLabel.text = String(playerTwoScore)
    }
    
    // the following function check if every button is matched
    func checkForGameOver() {
        // if all the buttons' tags are 2, do the following
        if buttonsOnevOne[0].tag == 2 && buttonsOnevOne[1].tag == 2 && buttonsOnevOne[2].tag == 2 && buttonsOnevOne[3].tag == 2 && buttonsOnevOne[4].tag == 2 && buttonsOnevOne[5].tag == 2 && buttonsOnevOne[6].tag == 2 && buttonsOnevOne[7].tag == 2 && buttonsOnevOne[8].tag == 2 && buttonsOnevOne[9].tag == 2 && buttonsOnevOne[10].tag == 2 && buttonsOnevOne[11].tag == 2 && buttonsOnevOne[12].tag == 2 && buttonsOnevOne[13].tag == 2 && buttonsOnevOne[14].tag == 2 && buttonsOnevOne[15].tag == 2 {
            
            // newGameButtons is revealed
            newGameButton.isHidden = false
            
            // if the playerOne score is bigger, the alert box show playerOne win
            if playerOneScore >= playerTwoScore{
                let myReturn = showAlertBox(message: "\(FirstString) win!")
                present(myReturn, animated: true)
            // if the playerTwo score is bigger, the alert box show playerTwo win
            } else {
                let myReturn = showAlertBox(message: "\(SecondString) win!")
                present(myReturn, animated: true)
            }
        }
        
    }
    
    // the function is a collection of action for buttons pressed
    @IBAction func buttonsPressedIn1v1(_ sender: UIButton) {
        // every press of buttons, this number increases by one
        numbersOfPressed += 1
        // the tag of the buttons press is 1
        sender.tag = 1
        // call the findButtonsPostion to find the buttons pressed
        let positionOfButton = findFirstButtonPressed(allButtons: buttonsOnevOne)
        // change the button image to the corresponding image in the shuffle array
        animation(views: sender)
        sender.setImage(shuffleArray[positionOfButton], for: .normal)
        // change the buttons tag to 3
        sender.tag = 3
        // call function to deter wheter a button occus or not
        matchingOccurs()
        
        // the following code determine the turn and change the arrow image correspondingly
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.randomNum == 0 {
                self.matchingFailDetermineTurnsCase0()
            } else if self.randomNum == 1 {
                self.matchingFailDetermineTurnsCase1()
            }
        }
        
        // check whether the game is over or not
        checkForGameOver()
            
    }
 
    // newGame button pressed
    @IBAction func newGamePressed(_ sender: Any) {
        
        // reassign the shuffle array
        myArray = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "3")]
        shuffleArray = []
        
        // shuffle the array
        shuffleRoutine()
        
        // reset all variable in this viewController to 0
        someNumber = 0
        
        numbersOfPressed = 0
        
        playerOneScore = 0
        playerTwoScore = 0
        
        continueSuccessForOne = 0
        continueSuccessForTwo = 0
        
        // reset score labels' text to 0
        pOneScoreLabel.text = "0"
        pTowScoreLabel.text = "0"
        
        // reset score labels' colors to white
        pOneName.textColor = UIColor.white
        pTwoName.textColor = UIColor.white
        
        // call function random begin to start a new turn
        randomBegin()
        
        // reset all the buttons to logo and tags to 0 and enable all of them
        for index in 0...15 {
            buttonsOnevOne[index].isEnabled = true
            buttonsOnevOne[index].tag = 0
            buttonsOnevOne[index].setImage(#imageLiteral(resourceName: "logo.jpg"), for: .normal)
        }
        
        // reset alertBox image
        _ = showAlertBox(message: "")
        
        // newGameButton is hidden
        newGameButton.isHidden = true
    }
    
    
    

 
 

}
