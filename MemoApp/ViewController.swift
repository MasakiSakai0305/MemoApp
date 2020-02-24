//
//  ViewController.swift
//  PracticememoApp
//
//  Created by MasakiSakai on 2020/02/10.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,saveMemoProtocol {
    
    
    var memoArray = [String]()

    @IBOutlet weak var memoCountLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    //ナビゲーションアイテムのプラスボタン宣言
    var addBarButtonItem: UIBarButtonItem!
    var memoCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableview.delegate = self
        tableview.dataSource = self
        
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        //var memoArray = UserDefaults.standard.set(memoArray, forKey: "memoArray")
        
        
        
        
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableview.reloadData()
//    }
    
    
    //メモ追加ボタン
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        print("【+】ボタンが押された!")
        
        //メモがこ５個以上の時は何もしない
            if memoArray.count > 10{
                print("これ以上メモは作れません")
            }
            else{
            
                
            let array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
            //タップした時にその配列の中身を表示させる
            let addmemoVC = storyboard?.instantiateViewController(withIdentifier: "add")  as! addMemoViewController
                
                addmemoVC.delegate = self
            
                //メモの番号
                memoCount = array.count
                
                addmemoVC.memoArray = array
                //addmemoVC.memoNumber = array.count
            
                //画面遷移
                navigationController?.pushViewController(addmemoVC, animated: true)
                    
              
                
                               
            }
        
      
                     
            
    }

    
    //中身がないメモを消す
    func removeEmptyMemo() -> [String] {
        
        print("--removeEmptyMemo--")
        var array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
        var emptyMemoNumber = [Int]()
        
        for i in 0 ..< array.count{
            
            let memo = array[i]
            print(i, memo)
            if memo == "" {
                print("中身がないメモ発見", i)
                emptyMemoNumber.append(i)
            }
        }

        for i in emptyMemoNumber{
            print(array[i])
            print(i)
            array.remove(at: i)
            }
//
        UserDefaults.standard.set(array, forKey: "memoArray")
        print("--removeEmptyMemo終了--")
    //    print(memoArray, "\n")
        return array
    }
    
    
    //セルの数を決めるメソッド
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("--tableView numberOfRowsInSection--")
            var Count = 0
            if let array = UserDefaults.standard.array(forKey: "memoArray"){
                Count = removeEmptyMemo().count
                print("\nメモの数: ", Count)
                print(array, "\n")
                
            }
            //UserDefaultsに何も入っていない時
            else {
                Count = 0
            }
            
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
        
        let array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
        let title = array[indexPath.row].prefix(10)
        cell.textLabel?.text = String(title)

        print("---cell:\(String(indexPath.row))---")
        print(array)
        
        return cell
    }
    
    
    //セルが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   
        //画面遷移する
//        performSegue(withIdentifier: "selectMemo", sender: nil)
        
        
        //タップした時にメモの中身を渡す
        let memoVC = storyboard?.instantiateViewController(withIdentifier: "memo")  as! memoViewController

        memoVC.delegate = self

        //中身とセルの順番を渡す
        print("\(String(indexPath.row)) is selected")
        let array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
        print(array)
        //memoVC.memoContent = array[indexPath.row]
        memoVC.memoArray = array
        //memoVC.memoString = memoArray[indexPath.row].content
        memoVC.memoNumber = indexPath.row

        //画面遷移
        navigationController?.pushViewController(memoVC, animated: true)
        
    }
    
    
    //セルの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/10
    }

    
    //テーブルを更新するdelegateメソッド
    //viewwillapperでreloadしてもうまくいかないためここで更新する
    func updateMemo(callingFunctionName: String){
        print("called by \(callingFunctionName)\n")
        tableview.reloadData()

    }
    
   
              
       
//      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//        if segue.identifier == "selectMemo"{
//            let memoVC = segue.destination as! memoViewController
//
//            memoVC.delegate = self
//
//            //中身とセルの順番を渡す
//            print("\(String(memoNum)) is selected")
//            let array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
//            print(array)
//            //memoVC.memoContent = array[indexPath.row]
//            memoVC.memoArray = array
//            //memoVC.memoString = memoArray[indexPath.row].content
//            memoVC.memoNumber = memoNum
//
//        }
//
//
//      }
//
        
    
    
//    //メモのタイトルを記憶するdelegateメソッド
//    //addmemoから戻る時に呼ばれる
//    func addMemo(content: String){
//
//        print("---addMemo---")
////        memoArray.append(content)
////        print(memoArray)
////        var array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
////        array.append(content)
////        UserDefaults.standard.set(array, forKey: "memoArray")
////
//////        print("--メモが追加されているかチェック--")
//////        for i in 0 ..< memoArray.count{
//////            print(memoArray[i])
//////        }
//////        print("\n")
//        tableview.reloadData()
//        print("--addmemo終了--")
//
//    }
//
//    //メモのタイトルを記憶するdelegateメソッド
//    //memoから戻る時に呼ばれる
//    func changeMemo(content: String, count:Int){
//
//        print("---changeMemo---")
////        var array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
////        array[count] = content
////        UserDefaults.standard.set(array, forKey: "memoArray")
//
////        print("title: ", title)
////        print("content: ", content)
////        print("count: ", count)
////
////        memoArray[count] = memo(title: title, content: content)
//
//
//        tableview.reloadData()
//        print("---changeMemo終了---")
//
//    }
//


    

    
}

