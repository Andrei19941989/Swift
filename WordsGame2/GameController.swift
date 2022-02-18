//
//  GameController.swift
//  WordsGame2
//
//  Created by Влад Мади on 07.02.2022.
//

import UIKit

class GameController: UIViewController {
    
    var player1: Player = Player(name: "1", score: 0)
    var player2: Player = Player(name: "2", score: 0)
    var bigWord: String = ""
    
    var upperBigWord: String {
        return bigWord.uppercased()
    }
    
    var isFirst = true
    var beforeWords = [String]()
    
    //1. Игроки ходят по очереди
    //2. Если игрок составляет правильно слово, ему начисляются баллы = количеству букв в составленном слове, и ход переходит к другому игроку
    //3. Если игрок составляет неправильное слово, ход остаэтся у него
    //4. Какие слова неправильные?
    // - Менее 2 букв
    // - Которые были составлены ранее
    // - Исходное слово
    // - Те, которые нельзя составить из букв исходного
    
    @IBOutlet weak var bigWordLabel: UILabel!
    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstStack: UIStackView!
    @IBOutlet weak var secondStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    func wordValidation() -> Bool {
        
        guard let word = wordTextField.text?.uppercased() else {
            presentAlert("Техническая ошибка")
            return false
        }
        
        guard word.count > 1 else {
            presentAlert("Слов из 1 буквы не бывает! Давай длиннее!")
            return false
        }
        
        guard word != bigWord.uppercased() else {
            presentAlert("Эй, умник! Придумай слово, а не спиши его сверху!")
            return false
        }
        
        guard !beforeWords.contains(word) else {
            presentAlert("Будь оригинальнее! Придумай слово, которого ещё не было!")
            return false
        }
        
        return true
    }
    
    func setupViews() {
        
        tableView.backgroundColor = .clear
        firstScoreLabel.text = "0"
        secondScoreLabel.text = "0"
        firstNameLabel.text = player1.name
        secondNameLabel.text = player2.name
        bigWordLabel.text = bigWord
        firstStack.layer.borderColor = UIColor.white.cgColor
        firstStack.layer.borderWidth = 4
        secondStack.layer.borderWidth = 0
        secondStack.layer.borderColor = UIColor.white.cgColor
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func wordToChars(word: String) -> [Character] {
        var chars = [Character]()
        for char in word.uppercased() {
            chars.append(char)
        }
        return chars
    }
    
    func check() -> Int {
        
        guard let word = wordTextField.text?.uppercased() else {
            return 0
        }
        
        guard wordValidation() else {
            return 0
        }
        
        let smallChars = wordToChars(word: word)
        var bigChars = wordToChars(word: upperBigWord)
        var resultString = ""
        
        wordTextField.text = ""
        
        for char in smallChars {
            
            if bigChars.contains(char) {
                resultString.append(char)
                var i = 0
                while bigChars[i] != char {
                    i += 1
                }
                bigChars.remove(at: i)
            } else {
                presentAlert("Такое слово не может быть составлено")
                return 0
            }
            
        }
        beforeWords.append(word)
        return word.count
    }
    
    func updateViews() {
        firstScoreLabel.text = "\(player1.score)"
        secondScoreLabel.text = "\(player2.score)"
        
        firstStack.layer.borderWidth = isFirst ? 4 : 0
        secondStack.layer.borderWidth = isFirst ? 0 : 4
        tableView.reloadData()
    }
    
    @IBAction func readyButtonTap(_ sender: UIButton) {
        
        let score = check()
        guard score > 0 else { return }
        
        if isFirst {
            player1.score += score
        } else {
            player2.score += score
        }
        isFirst.toggle()
        updateViews()
    }
    
    
    
    
    @IBAction func quitTap(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Вы уверены?",
                                            message: "Вы точно хотите завершить игру?",
                                            preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Да",
                                      style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        
        let noAction = UIAlertAction(title: "Нет",
                                     style: .cancel,
                                     handler: nil)
        
        actionSheet.addAction(yesAction)
        actionSheet.addAction(noAction)
        
        present(actionSheet, animated: true)
        
    }
    
    deinit {
        print("Game Controller dismissed!")
    }
    
}

extension GameController: UITableViewDelegate,
                          UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beforeWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as! WordCell
        
        cell.wordLabel.text = beforeWords[indexPath.row]
        cell.scoreLabel.text = "\(beforeWords[indexPath.row].count)"
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .systemRed
        } else {
            cell.backgroundColor = .purple
        }
        
        return cell
    }
    
    
    
    
}
