//
//  QuizViewController.swift
//  CalApp
//
//  Created by koji nakashima on 2021/01/03.
//

import UIKit

class QuizViewController: UIViewController {

    var selection:[String] = [] // Viewからの引き渡し（たし算、ひき算、かけ算、わり算）
    var calculationIndex = ""   // Viewからの引き渡し（ +、-、×、÷）

    var startTime:Date = Date() // 処理時間計測
    var totalTime:Int = 0       // 全問時間計測

    var total = 10              // 問題数
    var correct = 0             // 正解数
    var questionIndex = 0       // 問題の番号

    var result:[String] = []    // resultへの引き渡し
    var resultLine = ""         // resultへの引き渡し
    var answerNum = ""
    let sp = " "

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ヘルプで登録されたtotal値を取得　未登録時は10とする
        let value = (UserDefaults.standard.object(forKey: "text")  as? String ?? "10")
        total = Int(value)!

        // Viewからの引き渡し
        question.text = questionTitle(titleName: selection[1])
        calculationIndex = selection[1]
        calculation.text = selection[1]
        setQuestions()

    }
    
    // Result へ値を引き渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultViewController {
            resultVC.result = result
        }
    }

    // 次の画面へ
    @IBAction func nextNum(_ sender: UIButton) {
        var judgment = ""
        
        if showLabel.text == answerNum {
            judgment = "○"
            correct = correct + 1
        } else {
            judgment = "×"
        }
        // 開始からの経過秒数を取得する
        let timeInterval = Date().timeIntervalSince(startTime)
        let time = Int(timeInterval)
        let timeWk = processTime(timer: time)
        // 全問処理時間計測
        totalTime = totalTime + time

        // result １行分の作成
        let num = Int(answerNum)
        resultLine = sp + judgment + sp +
                    "[" + timeWk + "]" +
                    "(" + String(format: "%4d",num!) + ")" +
                     sp + leftNum.text! +
                     sp + calculationIndex +
                     sp + rightNum.text! +
                     sp + "=" +
                     sp + showLabel.text!

        // result へ追加する
        result.append(resultLine)
        showLabel.text = ""

        questionIndex += 1
        
        // 問題数が最大値を超えたら result 画面へ その他の場合は setQuestions へ
        if questionIndex >= total {
            let timeWk = processTime(timer: totalTime)
            // result へ追加する
            resultLine = sp + sp + "トータル時間：" + timeWk
            totalTime = 0
            result.append(resultLine)
            // result へ追加する
            resultLine = sp + sp + "○：\(correct)   ×：\(total - correct)"
            result.append(resultLine)
            performSegue(withIdentifier: "ResultView", sender: nil)
        } else {
            setQuestions()
        }
    }

    //  経過時間を文字タイプに変換
    func processTime(timer: Int) -> String {
        var times = ""
        let m = timer / 60 % 60
        let s = timer % 60
        if m == 0 {
            times = String(format: "%2d秒", s)
        } else {
            times = String(format: "%d分%d秒", m, s)
        }
        return times
    }
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var leftNum: UILabel!
    @IBOutlet weak var calculation: UILabel!
    @IBOutlet weak var rightNum: UILabel!
    
    @IBOutlet weak var showLabel: UILabel!
    
    // 数値の入力
    @IBAction func inputNum(_ sender: UIButton) {
        guard let showNum = showLabel.text else {
            return
        }
        guard let sendereNum = sender.titleLabel?.text else {
            return
        }
        showLabel.text = showNum + sendereNum
        let showLabelChk = showLabel.text!
        let showLabelInt:Int = Int(showLabelChk)!
        if showLabelInt > 999 {
            var showLabelx:String
            var showLabelxx:String
            if showLabel.text != "" {
                showLabelx = showLabel.text!
                showLabelxx = String(showLabelx.prefix(showLabelx.count - 1))
                showLabel.text = showLabelxx
            }
        }
    }

    // Clearボタン
    @IBAction func allClearButton(_ sender: UIButton) {
        showLabel.text = ""
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        var showLabelx:String
        var showLabelxx:String
        if showLabel.text != "" {
            showLabelx = showLabel.text!
            showLabelxx = String(showLabelx.prefix(showLabelx.count - 1))
            showLabel.text = showLabelxx
        }
    }
       
    // 問題出題
    func setQuestions() {

        var leftNumber = 0
        var rightNumber = 0

        //  処理件数を表示
        number.text = "(" + String(questionIndex + 1) + "/" + String(total) + ")"

        // 開始時点のTimeを用意する
        startTime = Date()

        switch calculationIndex {
            case "+":
                if selection[0] == "1桁" {
                    leftNumber = Int.random(in: 1..<10)
                } else {
                    leftNumber = Int.random(in: 10..<100)
                }
                if selection[0] == "1桁" {
                    rightNumber = Int.random(in: 1..<10)
                } else {
                    rightNumber = Int.random(in: 10..<100)
                }
            case "-":
                if selection[0] == "1桁" {
                    leftNumber = Int.random(in: 1..<10)
                } else {
                    leftNumber = Int.random(in: 10..<100)
                }
                if selection[0] == "1桁" {
                    rightNumber = Int.random(in: 1..<10)
                } else {
                    rightNumber = Int.random(in: 10..<100)
                }
                if calculationIndex == "-" {
                    if leftNumber < rightNumber {
                        let tempNumber = leftNumber
                        leftNumber = rightNumber
                        rightNumber = tempNumber
                    }
                }
            case "x":
                if selection[0] == "1桁" {
                    leftNumber = Int.random(in: 1..<10)
                } else {
                    leftNumber = Int.random(in: 10..<100)
                }
                if selection[0] == "1桁" {
                    rightNumber = Int.random(in: 1..<10)
                } else {
                    rightNumber = Int.random(in: 1..<10)
                }
            default:
                let arg1 = Int.random(in: 1..<10)
                let arg2 = Int.random(in: 1..<10)

                let arg3 = arg1 * arg2
                
                leftNumber = arg3
                rightNumber = arg2
        }

        leftNum.text = String(leftNumber)
        rightNum.text = String(rightNumber)

        switch calculationIndex {
            case "+":
                answerNum = "\(leftNumber + rightNumber)"
            case "-":
                answerNum = "\(leftNumber - rightNumber)"
            case "x":
                answerNum = "\(leftNumber * rightNumber)"
            default:
                answerNum = "\(leftNumber / rightNumber)"
        }
    }
    // 出題タイトル
    func questionTitle(titleName: String) -> String {
        var  questionName = ""
        switch titleName {
            case "+":
                questionName = "たし算"
            case "-":
                questionName = "ひき算"
            case "x":
                questionName = "かけ算"
            default:
                questionName = "わり算"
        }
        return questionName
    }
}


