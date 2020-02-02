
import UIKit

class MainMenuVC: UIViewController {
    
    // outlets created
    @IBOutlet var modeButtons: [UIButton]!
    
    @IBOutlet weak var rulesButton: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var playerNameTextField: UITextField!
    
    // declare variables for names in different mode
    var playerOneName = ""
    var playerTwoName = ""
    
    var PlayerNameTM = ""
    
    override func viewDidLoad() {
        
        // reload the saved data back to leaderboard dictionary
        if let lb1 = UserDefaults.standard.value(forKey: "leaderBoard") as? Dictionary<String, Int>{
            leaderBoard = lb1
            print(leaderBoard)
        }
        
        // reload the saved data of time mode back to leaderboardTimeMOde dictionary
        if let lbtm = UserDefaults.standard.value(forKey: "TimeMode") as? Dictionary<String, Int> {
            leaderBoardTimeMode = lbtm
            print(leaderBoardTimeMode)
        }
        
        super.viewDidLoad()
    }
    
    // function that prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let sender = sender as? UIButton else {return}
        
        // if modeButtons[0] is pressed do the following
        if sender == modeButtons[0] {
            // title of destination changed to practice mode
            segue.destination.navigationItem.title = "Practice Mode"
            
            // and the value of PlayerNameTm is assigned to palyerN in that viewController
            let normalMode = segue.destination as? NormalModeViewController
            normalMode!.playerN = PlayerNameTM
            
        // else if modeButtons[1] is pressed
        } else if sender == modeButtons[1] {
            
            // title of destination changes into Time mode
            segue.destination.navigationItem.title = "Time Mode"
            
            // and the value of playerTm is assigned to sting PlayerN in the NormalModeViewController
            let timeMode = segue.destination as?NormalModeViewController
            timeMode!.playerN = PlayerNameTM
            
        // or modeButtons[2] is pressed
        } else if sender == modeButtons[2] {
            
            // title of destination is changed into 1v1
            segue.destination.navigationItem.title = "1 v 1"
            
            // assign string playerNames to the conrresponding strings in the OneVOneViewController
            let OneVOne = segue.destination as? OneVOneViewController
            
            OneVOne!.FirstString = playerOneName
            OneVOne!.SecondString = playerTwoName
            
        // or the rulesBUtton is pressed
        } else if sender == rulesButton {
            // change title of destination into RUles
            segue.destination.navigationItem.title = "Rules"
        } 
    }
        
    @IBAction func normalButtonPressed(_ sender: UIButton) {
        // if modeBUttons[0] pressed, gameMode is assigned 0
        GameMode = 0
        
        // if the playerNameTextField is not empty, assign the string in the text field to the PlayerNameTm
        if playerNameTextField.text != "" {
            PlayerNameTM = playerNameTextField.text!
        // Otherwise, playerNameTM is assigned string Somebody
        } else {
            PlayerNameTM = "Somebody"
        }
        
        // perfor the segue ModeSegue
        performSegue(withIdentifier: "ModeSegue", sender: modeButtons[0])
    }
    
    @IBAction func timeModePressed(_ sender: UIButton) {
        // if modeBUttons[1] is pressed, gameMode is assign to 1
         GameMode = 1
        
        // if the playerNameTextFIeld is not empty, assign the string in the textfield to string PlayerNameTM
        if playerNameTextField.text != "" {
            PlayerNameTM = playerNameTextField.text!
        // otherwise assign somebody to palyerNameTM
        } else {
            PlayerNameTM = "Somebody"
        }
        
        // perform segue ModeSegue
        performSegue(withIdentifier: "ModeSegue", sender: modeButtons[1])
        
    }
    
    @IBAction func v1Pressed(_ sender: UIButton) {
        
        // if modeButtons[2] is pressed
        // if both of the textfields are not empty, assign the strings in the textfield to correspongding variable of playerNames
        if textFields[0].text != "" && textFields[1].text != "" {
            playerOneName = textFields[0].text!
            playerTwoName = textFields[1].text!
        // otherwise, those playerNames are default values to PlayerOne and PlayerTwo
        } else {
            playerOneName = "Player One"
            playerTwoName = "Player Two"
        }
        
        // perform segue 1v1Segue
        performSegue(withIdentifier: "1v1Segue", sender: modeButtons[2])
    }
    
    @IBAction func rulesButtonPressed(_ sender: UIButton) {
        // if rulesBUtton is pressed, perfor segue rulesSegue
        performSegue(withIdentifier: "rulesSegue", sender: rulesButton)
    }
    
    
}
