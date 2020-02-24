//
//  memoViewController.swift
//  PracticememoApp
//
//  Created by 境将輝 on 2020/02/10.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

class memoViewController: UIViewController,UINavigationControllerDelegate{

    
    var memoContent = ""
    var memoNumber = Int()
    
    var memoArray = [String]()
    
    var delegate:saveMemoProtocol?
    
    //メモ削除ボタン
    var trashBarButtonItem: UIBarButtonItem!
    
    var alertController: UIAlertController!
    
    var isDelete = Bool()
    
    
    @IBOutlet weak var memoView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(memoArray)
        navigationController?.delegate = self
        
        //memoView.text = memoContent
        memoView.text = memoArray[memoNumber]
        
        trashBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [trashBarButtonItem]
    }
    
    //メモ削除ボタン
    @objc func trashBarButtonTapped(_ sender: UIBarButtonItem) {
        print("trashボタンが押された!")
        //self.dismiss(animated: true, completion: nil)
        alert(title: "メモ削除", message: "メモを削除しますか？")
        
        
            }
    

    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) in
            //OKが押された時の処理
            print("OK was pushed\n")
            self.isDelete = true
            
            //前の画面に戻る処理
            self.navigationController?.popViewController(animated: true)
            
            
            
            
            
        })
        let ngAction = UIAlertAction(title: "NG", style: .destructive, handler: {
            (action: UIAlertAction!) in
            //NGが押された時の処理
            print("NG was pushed\n")
        })
        
        
        alertController.addAction(okAction)
        alertController.addAction(ngAction)
        
          present(alertController, animated: true)
      }

    
    //前の画面に戻るとき,textviewの中身をメモに格納
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        //前の画面に戻るとき
        if viewController is ViewController {
            
            //メモ削除
            if isDelete == true{
                
                memoArray[memoNumber] = ""
                
            } else {
            print("--変更したメモ--")
            //メモのタイトル・内容
            print("content: ", memoView.text)
            print("number: ", memoNumber, "\n")
            
            memoArray[memoNumber] = memoView.text
            print(memoArray)
            
            }
            
            if memoContent == ""{
                print("入ってない")
            }
            
            UserDefaults.standard.set(memoArray, forKey: "memoArray")
            
            //このタイミングでdelegateメソッドを使う
            delegate?.updateMemo(callingFunctionName: "memoVC")

            
        }
    }

    

}
