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
    
    
    @IBOutlet weak var memoView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.delegate = self
        
        //memoView.text = memoContent
        memoView.text = memoArray[memoNumber]
        
        trashBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [trashBarButtonItem]
    }
    
    //メモ削除ボタン
    @objc func trashBarButtonTapped(_ sender: UIBarButtonItem) {
        print("trashボタンが押された!")
        
        
            }

    
    //前の画面に戻るとき,textviewの中身をメモに格納
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        //前の画面に戻るとき
        if viewController is ViewController {
            print("--変更したメモ--")
            //メモのタイトル・内容
            
            print("content: ", memoView.text)
            print("number: ", memoNumber, "\n")
            
            memoArray[memoNumber] = memoView.text
            print(memoArray)
            
            if memoContent == ""{
                print("入ってない")
            }
            
            UserDefaults.standard.set(memoArray, forKey: "memoArray")
            
            //このタイミングでdelegateメソッドを使う
            delegate?.updateMemo(callingFunctionName: "memoVC")

            
        }
    }

    

}
