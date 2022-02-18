//
//  ViewController.swift
//  WordsGame2
//
//  Created by Влад Мади on 07.02.2022.
//

import UIKit

class StartController: UIViewController {
    
    @IBOutlet weak var longWordTF: UITextField!
    @IBOutlet weak var firstPlayerTF: UITextField!
    @IBOutlet weak var secondPlayerTF: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews() {
        
        let roundedViews: [UIView] = [longWordTF,
                                      firstPlayerTF,
                                      secondPlayerTF,
                                      startButton]
        
        for roundedView in roundedViews {
            roundedView.layer.cornerRadius = 12
        }
        
        firstPlayerTF.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 12,
                                                      height: 0))
        firstPlayerTF.leftViewMode = .always
        secondPlayerTF.leftView = UIView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: 12,
                                                       height: 0))
        secondPlayerTF.leftViewMode = .always
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToGame" {
            
            let player1 = Player(name: firstPlayerTF.text! != "" ? firstPlayerTF.text! : "Игрок 1")
            let player2 = Player(name: secondPlayerTF.text! != "" ? secondPlayerTF.text! : "Игрок 2")
            
            let destVC = segue.destination as! GameController
            destVC.player1 = player1
            destVC.player2 = player2
            destVC.bigWord = longWordTF.text!
            
            firstPlayerTF.text = ""
            secondPlayerTF.text = ""
            longWordTF.text = ""
        }
        
    }
    
    @IBAction func startTap(_ sender: UIButton) {
        
        guard let word = longWordTF.text, word.count > 7 else {
            
            presentAlert("Исходное слово должно быть длиннее 7 символов")
            return
        }
        
        performSegue(withIdentifier: "ToGame", sender: nil)
        
        
    }
    
}

