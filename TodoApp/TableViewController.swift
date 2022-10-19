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
    var todoText = [String]()
    //ToDoListのチェックマークをBool型の配列で定義
    var todoCheck = [Bool] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddItemButton(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
       
        //テキスト
        if UserDefaults.standard.object(forKey: "TodoText") != nil {
            todoText = UserDefaults.standard.object(forKey: "Todocheck") as! [String]
        }
        //チェックマーク
        if UserDefaults.standard.object(forKey: "TodoCheck") != nil {
            todoCheck = UserDefaults.standard.object(forKey: "TodoCheck") as! [Bool]
        }
        //UserDefaultsにデータを保存する
        UserDefaults.standard.set(todoText, forKey: "TodoText")
        //UserDefaultsに保存したデータを取得する
        todoText = UserDefaults.standard.object(forKey: "TodoText") as! [String]

    }
    //セルの数を設定する
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoText.count
    }
    //チェックマークをつける
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        todoCheck[indexPath.row] = !todoCheck[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        UserDefaults.standard.set(todoCheck, forKey: "TodoCheck")
    }
    //セクションの設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの内容を設定する
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TodoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        TodoCell.textLabel!.text = todoText[indexPath.row]
        
        let accessory: UITableViewCell.AccessoryType = todoCheck[indexPath.row] ? .checkmark: .none
        TodoCell.accessoryType = accessory
        
        return TodoCell
    }
    //アクションシートを使用する
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "追加する項目",
            message: "ToDoリストに新しい内容を追加します.",
            preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text
            {
                self.addNewToDoItem(title: title)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    //テキストを追加する
    func addNewToDoItem(title: String) {
        let newIndex = todoText.count
        todoText.append(title)
        todoCheck.append(false)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
        UserDefaults.standard.set(todoText, forKey: "TodoText")
    }
    
    //セルを削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,  forRowAt indexPath: IndexPath) {
        todoText.remove(at: indexPath.row)
        todoCheck.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .top)
        UserDefaults.standard.set(todoText, forKey: "TodoText")
        UserDefaults.standard.set(todoCheck, forKey:"TodoText")
    }
}
