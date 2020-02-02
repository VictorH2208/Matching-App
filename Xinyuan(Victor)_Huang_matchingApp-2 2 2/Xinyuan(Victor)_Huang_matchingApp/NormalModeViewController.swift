//
//  ViewController.swift
//  Xinyuan(Victor)_Huang_matchingApp
//
//  Created by Period Four on 2018-11-20.
//  Copyright © 2018 Period Four. All rights reserved.
//

import UIKit

class NormalModeViewController: UIViewController {
    
    // declare all the outlets that are necessary in this viewController
    @IBOutlet var Buttons: [UIButton]!
    
    @IBOutlet weak var trialLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var normalScoreLabel: UILabel!
    @IBOutlet weak var normalTrialLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var revealAllButton: UIButton!
    
    @IBOutlet weak var playerNameTM: UILabel!
    
    @IBOutlet weak var leaderBoardLeft: UIButton!
    @IBOutlet weak var leaderBoardRight: UIButton!
    
    // create playerN string that stores player name
    var playerN = ""
    
    // a function to be called in timer
    func updateTimer() {
        // seconds increase by 1
        seconds += 1
        // display seconds on timerLabel
        timerLabel.text = String(seconds)
    }
    
    // a function that check whether a game is over or not
    func checkForGameOver() {
        
        // only occurs when all the buttons's tags are 2
        if Buttons[0].tag == 2 && Buttons[1].tag == 2 && Buttons[2].tag == 2 && Buttons[3].tag == 2 && Buttons[4].tag == 2 && Buttons[5].tag == 2 && Buttons[6].tag == 2 && Buttons[7].tag == 2 && Buttons[8].tag == 2 && Buttons[9].tag == 2 && Buttons[10].tag == 2 && Buttons[11].tag == 2 && Buttons[12].tag == 2 && Buttons[13].tag == 2 && Buttons[14].tag == 2 && Buttons[15].tag == 2 {
            
            // if the tags are 2, revealAllButton is hidden
            revealAllButton.isHidden = true
            
            // newGameButton is revealed
            newGameButton.isHidden = false
            
            // timers is stopped
            timer.invalidate()
            
            // if the user tapped is practice mode
            if GameMode == 0 {
                // the score is the total score subtract a fifth of total tries.
                normalModeScore = normalModeScore - totalTrials/5
                // add the palyer name and score to leaderBoard dictionary
                leaderBoard.updateValue(normalModeScore, forKey: playerN)
            
                print("Practice Mode")
                print(leaderBoard)
                // save the leaderBoard dictionary
                UserDefaults.standard.set(leaderBoard, forKey: "leaderBoard")
            
            // if the user tapped is timer mode
            } else if GameMode == 1 {
                // their score is their total score subtract a fifth of the total tries and a fifth of the time
                normalModeScore = normalModeScore - totalTrials/5 - seconds/5
                // add the player name and score to leaderBoardTimeMode
                leaderBoardTimeMode.updateValue(normalModeScore, forKey: playerN)
                
                print("Timed Mode")
                print(leaderBoardTimeMode)
                // save leaderBoardTimeMode dictionary
                UserDefaults.standard.set(leaderBoardTimeMode, forKey: "leaderBoardTimeMode")

            }
            
            // create a variable that is the alertBox and input the message of the alert box
            let myReturn = showAlertBox(message: "Your total tries is \(totalTrials). Your final score is \(normalModeScore).")
            // present the alertBox
            present(myReturn, animated: true)
        }
    }
    
    override func viewDidLoad() {

        // reset the arrays of images
        myArray = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "3")]
        shuffleArray = []
        // reset the game mode just in case
        resetGame(label: playerScoreLabel)
        // call the function shuffle array
        shuffleRoutine()
        
        // if the user playing is practice mode
        if GameMode == 0 {
            // the name label is the name user input in mainmenu
            playerNameTM.text = playerN
            // these outlets are hidded
            timerLabel.isHidden = true
            newGameButton.isHidden = true
            leaderBoardRight.isHidden = true
            
        } else if GameMode == 1 {
            
            // the name label display the name user input or "somebody", and the following outlets are hidden
            leaderBoardLeft.isHidden = true
            playerNameTM.text = playerN
            newGameButton.isHidden = true
            // start the timer as soon as the view is loaded
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in self.updateTimer()})
            
        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // all the following buttons' functions are similar, except the corresponding buttons
    @IBAction func button0Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[0])
        Buttons[0].setImage(shuffleArray[0], for: .normal)
        // the tag of the button is set to 1
        Buttons[0].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[1])
        Buttons[1].setImage(shuffleArray[1], for: .normal)
        // the tag of the button is set to 1
        Buttons[1].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button2Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[2])
        Buttons[2].setImage(shuffleArray[2], for: .normal)
        // the tag of the button is set to 1
        Buttons[2].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button3Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[3])
        Buttons[3].setImage(shuffleArray[3], for: .normal)
        // the tag of the button is set to 1
        Buttons[3].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button4Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[4])
        Buttons[4].setImage(shuffleArray[4], for: .normal)
        // the tag of the button is set to 1
        Buttons[4].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button5Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[5])
        Buttons[5].setImage(shuffleArray[5], for: .normal)
        // the tag of the button is set to 1
        Buttons[5].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button6Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[6])
        Buttons[6].setImage(shuffleArray[6], for: .normal)
        // the tag of the button is set to 1
        Buttons[6].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button7Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[7])
        Buttons[7].setImage(shuffleArray[7], for: .normal)
        // the tag of the button is set to 1
        Buttons[7].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button8Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[8])
        Buttons[8].setImage(shuffleArray[8], for: .normal)
        // the tag of the button is set to 1
        Buttons[8].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button9Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[9])
        Buttons[9].setImage(shuffleArray[9], for: .normal)
        // the tag of the button is set to 1
        Buttons[9].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button10Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[10])
        Buttons[10].setImage(shuffleArray[10], for: .normal)
        // the tag of the button is set to 1
        Buttons[10].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button11Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[11])
        Buttons[11].setImage(shuffleArray[11], for: .normal)
        // the tag of the button is set to 1
        Buttons[11].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button12Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[12])
        Buttons[12].setImage(shuffleArray[12], for: .normal)
        // the tag of the button is set to 1
        Buttons[12].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button13Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[13])
        Buttons[13].setImage(shuffleArray[13], for: .normal)
        // the tag of the button is set to 1
        Buttons[13].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button14Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[14])
        Buttons[14].setImage(shuffleArray[14], for: .normal)
        // the tag of the button is set to 1
        Buttons[14].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    @IBAction func button15Pressed(_ sender: Any) {
        // every time a buttons is pressed, the following number increase by 1
        numberOfTimesButtonsTapped += 1
        // with animation, the button image is changed into the corresponding image in the shuffle array
        animation(views: Buttons[15])
        Buttons[15].setImage(shuffleArray[15], for: .normal)
        // the tag of the button is set to 1
        Buttons[15].tag = 1
        // call the matching function to see if matching does occur ot not
        matching(EveryButtons: Buttons, playerLabel: playerScoreLabel)
        // display the tries
        trialLabel.text = String(totalTrials)
        // call the function to check if the game is over or not
        checkForGameOver()
    }
    
    // these variables are needed when tapping the revealAll button
    var resetTimer = Timer()
    var resetIndex = 0
    
    // the function is needed when revealing all buttons
    func resetImageOneEachTime() {
        // the logo image is changed to corresponding image in the shuffle array with animation
        animation(views: Buttons[resetIndex])
        Buttons[resetIndex].setImage(shuffleArray[resetIndex], for: .normal)
        // the button is disabled, and the index increase by one every time
        Buttons[resetIndex].isEnabled = false
        resetIndex += 1
        
        // if the index which is essential seconds in timer reaches 16, the timer is stopped
        if resetIndex == 16 {
            resetTimer.invalidate()
        }
    }
    
    // a function when the revealAll button is tapped
    @IBAction func RevealAllButtonPressed(_ sender: Any) {
        // the Game timer is stopped
        timer.invalidate()
        // the revealAll button is hidden
        revealAllButton.isHidden = true
        // the resetTimer is enabled.
        resetTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {_ in self.resetImageOneEachTime()})
        // using a loop, all the tags of BUttons are set to 2
        for index in 0...15 {
            Buttons[index].tag = 2
        }
        // the newGame button is reveal
        newGameButton.isHidden = false
        
        // if the palyer is playing practice mode,
        if GameMode == 0 {
            // their score is set to 0 since they give up
            normalModeScore = 0
            // the name and score of the player is add in leaderBoard dictionary
            leaderBoard.updateValue(normalModeScore, forKey: playerN)
            
            print("Practice Mode")
            print(leaderBoard)
            // the leaderBoard dictionary is saved
            UserDefaults.standard.set(leaderBoard, forKey: "leaderBoard")
        
        // if the player palying is timerMode
        } else if GameMode == 1 {
            // their score is 0 since they give up
            normalModeScore = 0
            // the name and score of the player is added to the leaderBoardTimeMode dictionary
            leaderBoardTimeMode.updateValue(normalModeScore, forKey: playerN)
            
            print("Timed Mode")
            print(leaderBoardTimeMode)
            // the leaderBoardTimeMode dictionary is saved
            UserDefaults.standard.set(leaderBoardTimeMode, forKey: "TimeMode")
            
        }
    }
    
    @IBAction func NewGamePressed(_ sender: Any) {
        
        // reset the arrays of images
        myArray = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "3")]
        shuffleArray = []
        
        // call the shuffleArray fucntion
        shuffleRoutine()
        
        // the revealAllButton is revealed
        revealAllButton.isHidden = false
        // timerLabel is reset to 0
        timerLabel.text = "0"
        // timer is invalidated
        timer.invalidate()
        // call the resetGame function
        resetGame(label: playerScoreLabel)
        // trialLabel is reset to 0
        trialLabel.text = String(totalTrials)
        // use a loop to set buttons's images back to logo and enable every one of them
        for index in 0...15{
            Buttons[index].isEnabled = true
            Buttons[index].tag = 0
            Buttons[index].setImage(#imageLiteral(resourceName: "logo.jpg"), for: .normal)
        }
        // reset index used in revealAllButton is set to 0
        resetIndex = 0
    }
    
    // the left leaderBoard button is pressed, do the following
    @IBAction func LBLeftPressed(_ sender: Any) {
        // perfor segue leaderBOardPracticeMode
        performSegue(withIdentifier: "leaderBoardPracticeMode", sender: leaderBoardLeft )
    }
    
    // the right leaderBOard button is pressed, do the following
    @IBAction func LBRightPressed(_ sender: UIButton) {
        // perfor segue leaderBoardTimeMode
        performSegue(withIdentifier: "leaderBoardTimedMode", sender: leaderBoardRight)
    }
    
}

