//
//  ViewController.swift
//  TodoApp
//
//  Created by ユウ・カザマ on 2022/10/12.
//

//コメントを追加

import UIKit

class TableViewController: UITableViewController {
    
    // ToDoListに書いた文章を配列で定義
    var todotext = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            // NavigationBarの背景色の設定
            appearance.backgroundColor = UIColor.systemOrange
            //NavigationBarのタイトルの文字色設定
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            // Do any additional setup after loading the view.
        }
        
    }
    //セルの数を設定する
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todotext.count
    }
    
    //セクションの設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの内容を設定する
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TodoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Todocell", for :indexPath)
        TodoCell.textLabel!.text = todotext[indexPath.row]
        
        return TodoCell
    }
    
    
}
