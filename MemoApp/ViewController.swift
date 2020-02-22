//
//  ViewController.swift
//  PracticememoApp
//
//  Created by 境将輝 on 2020/02/10.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

//メモアプリ開発日 2/11~12
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,saveMemoProtocol {

    //メモ構造体(タイトルと中身)
    struct memo{
        var title: String
        var content: String
        
           init(title: String, content: String) {
               self.title = title
               self.content = content
           }
    }
    var memoArray = [memo]()

    @IBOutlet weak var memoCountLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    //プラスボタン宣言
    var addBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableview.delegate = self
        tableview.dataSource = self
        
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        
        
    }
    
    
    //メモ追加ボタン
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        print("【+】ボタンが押された!")
        
        //メモがこ５個以上の時は何もしない
            if memoArray.count > 10{
                print("これ以上メモは作れません")
            }
            else{
            
        
            //タップした時にその配列の中身を表示させる
            let addmemoVC = storyboard?.instantiateViewController(withIdentifier: "add")  as! addMemoViewController
                
                addmemoVC.delegate = self
            
            //画面遷移
            navigationController?.pushViewController(addmemoVC, animated: true)
            }
    }

    
    //中身がないメモを消す
    func removeEmptyMemo(){
        var emptyMemoNumber = [Int]()
        for i in 0 ..< memoArray.count{
            if memoArray[i].title == "" {
                print("中身がないメモ発見", i)
                print(memoArray[i])
                emptyMemoNumber.append(i)
            }
        }
        for i in emptyMemoNumber{
            memoArray.remove(at: i)
            }
    
        print("--removeEmptyMemo終了--")
        print(memoArray, "\n")
    }
    
    
    //セルの数を決めるメソッド
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            removeEmptyMemo()
            let Count = memoArray.count
            print("メモの数: ", Count)
            
            //ラベルに現在のメモの数を表示
            memoCountLabel.text = "現在: " + String(Count)
            return Count
        }
        
    //セクションの数を定義
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    //セルを構築するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //セルのハイライトについて
        //cell.selectionStyle = .none
        
        cell.textLabel?.text = memoArray[indexPath.row].title
        
        print("---cell:\(String(indexPath.row))---")
        print("title: ", memoArray[indexPath.row].title)
        print("content: ", memoArray[indexPath.row].content)
        
        return cell
    }
    
    
    
    //セルが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //タップした時にメモの中身を渡す
        let memoVC = storyboard?.instantiateViewController(withIdentifier: "memo")  as! memoViewController
        
        memoVC.delegate = self
        
        //中身とセルの順番を渡す
        memoVC.memoString = memoArray[indexPath.row].content
        memoVC.cellCount = indexPath.row
        
        //画面遷移
        navigationController?.pushViewController(memoVC, animated: true)
    }
    
    
    //セルの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/10
    }

        
    //メモのタイトルを記憶するdelegateメソッド
    //addmemoから戻る時に呼ばれる
    func addMemo(title: String, content: String){
        
        print("---addMemo---")
        print(title, content)
        
        memoArray.append(memo(title: title, content: content))
        
        print("--メモが追加されているかチェック--")
        for i in 0 ..< memoArray.count{
            print(memoArray[i])
        }
        print("\n")
        tableview.reloadData()
    }
    
    //メモのタイトルを記憶するdelegateメソッド
    //memoから戻る時に呼ばれる
    func changeMemo(title: String, content: String, count:Int){
        
        print("---changeMemo---")
        print("title: ", title)
        print("content: ", content)
        print("count: ", count)
        
        memoArray[count] = memo(title: title, content: content)
        tableview.reloadData()
    }

    
//    //新規メモ作成
//    @IBAction func plusAction(_ sender: Any) {
//        //メモがこ５個以上の時は何もしない
//            if memoArray.count > 10{
//                print("これ以上メモは作れません")
//            }
//            else{
//
//
//            //タップした時にその配列の中身を表示させる
//            let addmemoVC = storyboard?.instantiateViewController(withIdentifier: "add")  as! addMemoViewController
//
//                addmemoVC.delegate = self
//
//            //画面遷移
//            navigationController?.pushViewController(addmemoVC, animated: true)
//            }
//        }
    
}

