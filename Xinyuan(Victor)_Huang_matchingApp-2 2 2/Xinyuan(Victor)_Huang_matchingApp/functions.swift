import Foundation
import UIKit

// create dictionaray for two leaderBoards.
var leaderBoard: [String: Int] = [:]
var leaderBoardTimeMode: [String: Int] = [:]
var secondLb: [String: Int] =  [:]
var someLeaderBoard: [String: Int] = [:]

// func created to show alertBox, takes in a string and return an alertBox
func showAlertBox (message: String) -> UIAlertController {
  
    // create the alertBox
    let alertBox = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
    // create an action for the alertBox that do nothing
    alertBox.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    // return the alertBox
    return alertBox
}


// variables created
var time = 0
var seconds = 0
var timer = Timer()

var GameMode: Int = 0

var totalTrials = 0

var numberOfTimesButtonsTapped = 0

var numberOfContinueSuccess = 0

var normalModeScore = 0

// created array of UIImage and an empty array of type Image for shuffle routine
var myArray: [UIImage] = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "3")]
var shuffleArray: [UIImage] = []

// create function for shuffleRoutine
func shuffleRoutine () {
    
    // create a variable that will be the upperLimit of randomNumber
    var limit = 15
    // create a randomNUmber
    var randomNumber = 0
    
    // create a for loop that loop 16 times
    for _ in 1...16 {
        // each time the randomNumber is generates within a range
        randomNumber = Int.random(in: 0...limit)
        // and the newArray append the image at that ramdomNumber index and remove from the old array
        shuffleArray.append(myArray[randomNumber])
        myArray.remove(at: randomNumber)
        // in order for the loop to not crash, the ranger has to decrease 1 every loop.
        limit -= 1
        
    }
}

// create a animation function that takes in any UIView
func animation(views: UIView) {
    // the UIView flip from left with a duration of 1 sec
    UIView.transition(with: views, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
}



// the function find the position of the odd button user pressed.
func findFirstButtonPressed(allButtons: [UIButton]) -> Int {
    
    // create a varible to store the position, default 999
    var myNumber = 999
    
    // create for lopp
    for position in 0...15 {
        // if the tag of the button at the postion is one, assign position to myNumber and return it.
        if allButtons[position].tag == 1 {
            myNumber = position
            return myNumber
        }
    }
    
    // if the above code doesn't work, return 999
    return myNumber
    
}

// the function find the second button's position
func findSecondButtonPressed(allButtons: [UIButton]) -> Int {
    
    // create a varible to store the position, default 999
    var mysecondNumber = 999
    
    // create for loop that loop backwards to avoid finding the same button as function findFIrstButtonPressed
    for positionTwo in (0...15).reversed() {
        // if the tag of the button at the postion is one, assign position to myNumber and return it.
        if allButtons[positionTwo].tag == 1 {
            mysecondNumber = positionTwo
            return mysecondNumber
        }
    }
    
    // if the above code doesn't work, return 999
    return mysecondNumber
}

// funct that determine whether a matching occurs
func matching(EveryButtons: [UIButton], playerLabel: UILabel) {
    
    // if the total number of buttons presses is even, matching occurs
    if numberOfTimesButtonsTapped % 2 == 0 {
        // the trial is set to half of the total since two taps is one trial
        totalTrials = numberOfTimesButtonsTapped/2
        // create constants that store the positions of the 2 buttons
        let posOne = findFirstButtonPressed(allButtons: EveryButtons)
        let posTwo = findSecondButtonPressed(allButtons: EveryButtons)
        // if the positions are not 999, call the compare function
        if posOne != 999 && posTwo != 999 {
            compareButtons(buttonOne: EveryButtons[posOne], buttonTwo: EveryButtons[posTwo], playerLabel: playerLabel)
        }
        
    }
    
}

// function that compare the images of the two buttons the user tapped.
func compareButtons(buttonOne: UIButton, buttonTwo: UIButton, playerLabel: UILabel) {
    
    // if the image of the two buttons is the same
    if buttonOne.image(for: .normal) == buttonTwo.image(for: .normal) {
        
        // these two buttons are disabled and tags of them are changed to 2
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonOne.tag = 2
        buttonTwo.tag = 2
        // numberOfContinueSuccess increase by one
        numberOfContinueSuccess += 1
        // and cal the scoring system
        scoringSystem(playerLabel: playerLabel)
        
    // if they are not the same
    } else {
        
        // the continueSuccess is reset to 0 and tags are reset to 0
        numberOfContinueSuccess = 0
        buttonOne.tag = 0
        buttonTwo.tag = 0
        // use animation to change the buttons back to logo with a delay of 1 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            animation(views: buttonOne)
            animation(views: buttonTwo)
            buttonOne.setImage(#imageLiteral(resourceName: "logo.jpg"), for: .normal)
            buttonTwo.setImage(#imageLiteral(resourceName: "logo.jpg"), for: .normal)
        }
    }
}

// scoring system function
func scoringSystem(playerLabel: UILabel) {
    // the score increase by 2 to the power of COntinueSuccees, in exponential form
    normalModeScore += Int((pow(2.0, Double(numberOfContinueSuccess))))
    // set the label to display the socre
    playerLabel.text = String(normalModeScore)
}

// reset game function
func resetGame(label: UILabel) {
    
    // reset every variable to its original value
    seconds = 0
    numberOfTimesButtonsTapped = 0
    numberOfContinueSuccess = 0
    normalModeScore = 0
    totalTrials = 0
    // change the text of string to 0
    label.text = String(normalModeScore)
}



