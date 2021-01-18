//
//  ViewController.swift
//  CalApp
//
//  Created by koji nakashima on 2021/01/03.
//

import UIKit

class ViewController: UIViewController {

    var selection:[String] = []    // 次の画面への引き渡し

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func selectionButton1(_ sender: UIButton) {
        guard let sendereName = sender.titleLabel?.text else {
            return
        }
        // 10までの
        selection.append("1桁")
        let selectionCode = selectionCheck(codeName: sendereName )
        selection.append(selectionCode)
        print(selection)
        performSegue(withIdentifier: "QuizView", sender:nil)
    }
    
    
    @IBAction func selectionButton2(_ sender: UIButton) {
        guard let sendereName = sender.titleLabel?.text else {
            return
        }
        // 2桁の
        selection.append("2桁")
        let selectionCode = selectionCheck(codeName: sendereName )
        selection.append(selectionCode)
        print(selection)
        performSegue(withIdentifier: "QuizView", sender:nil)
    }
    
    // Quizへ値を引き渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectionVC = segue.destination as? QuizViewController {
            selectionVC.selection = selection
        }
    }

    
    @IBAction func helpButton(_ sender: UIButton) {
        performSegue(withIdentifier: "HelpView", sender:nil)
    }
    
    
    @IBAction func NoticeView(_ sender: UIButton) {
        performSegue(withIdentifier: "NoticeView", sender:nil)
    }
    
    
    @IBAction func quizButton(_ sender: UIButton) {

    }
    
    @IBAction func backToTitle(sender:UIStoryboardSegue) {
        selection.removeAll()
    }

    func selectionCheck(codeName: String) -> String {
        var selectionCode = ""
        switch codeName {
            case "たし算":
                selectionCode = "+"
            case "ひき算":
                selectionCode = "-"
            case "かけ算":
                selectionCode = "x"
            default:
                selectionCode = "÷"
        }
        return selectionCode
    }
}



