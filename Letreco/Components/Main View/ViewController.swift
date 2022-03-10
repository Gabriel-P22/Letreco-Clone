//
//  ViewController.swift
//  Letreco
//
//  Created by Gabriel Paschoal on 09/03/22.
//

import UIKit

class ViewController: UIViewController {

    let answers = [
        "after", "later", "block", "there", "ultra"
    ]
    
    var answer = ""
    
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    
    let boardVC = BoardViewController()
    let keyboardVC = KeyboardViewController()
    
    let nameApp: UILabel = {
       
        let name = UILabel()
        
        name.text = "LETRECO DARK MODE"
        name.textAlignment = .center
        name.textColor = .white
        name.font = .systemFont(ofSize: 22, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        return name
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        answer = answers.randomElement() ?? "after"
        
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        addChildren()
    }

    private func addChildren() {
        addChild(boardVC)
        view.addSubview(boardVC.view)
        boardVC.didMove(toParent: self)
        boardVC.datasource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(keyboardVC)
        view.addSubview(keyboardVC.view)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(nameApp)
        
        setconfig()
    }
    
    func setconfig() {
     
        NSLayoutConstraint.activate([
        
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: nameApp.topAnchor, constant: 15),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            nameApp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameApp.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nameApp.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

        ])
    }

}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        
        var stop = false
        
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            
            if stop {
                break
            }
            
        }
        
        boardVC.reloadData()
    }
    
}

extension ViewController: BoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        
        let rowIndex = indexPath.section
        
        let count = guesses[rowIndex].compactMap({ $0 }).count
        
        guard count == 5 else {
            return nil
        }
        
        let indexedAnswer = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return nil
        }
        
        
        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        
        return .systemOrange
        
    }
}
