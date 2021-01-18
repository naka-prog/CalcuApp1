//
//  ResultViewController.swift
//  MathTr
//
//  Created by koji nakashima on 2020/12/28.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var result:[String] = []

    @IBOutlet weak var resultView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.dataSource = self
        resultView.delegate = self
                
        print(result)

        // Do any additional setup after loading the view.
    }

    // テーブルの行数を指定するメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("result.count= \(result.count)")
        return result.count
    }
    
    // セルの中身を設定するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"Mycell", for:indexPath)
        // セルに値を設定する
        cell.textLabel!.text = result[indexPath.row]
//      cell.textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight.regular)
//      cell.textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium)
        cell.textLabel?.font = UIFont(name:"Menlo", size: 20)
        return cell
    }
    
    // セルの高さを一定の値にする
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
//        return 32
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can recreated.
    }

}

