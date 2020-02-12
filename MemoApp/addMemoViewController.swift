//
//  NextViewController.swift
//  PracticememoApp
//
//  Created by 境将輝 on 2020/02/10.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

protocol saveMemoProtocol {
    
    func addMemo(title: String, content: String)
    func changeMemo(title: String, content: String, count:Int)
    
}
class addMemoViewController: UIViewController, UINavigationControllerDelegate {

    
    var memoContent = ""
    var memoTitle = ""
    var delegate:saveMemoProtocol?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        
            }
    
    //前の画面に戻るとき,textviewの中身をメモに格納
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        //前の画面に戻るとき
        if viewController is ViewController {
            print("--追加したメモ--")
            //メモのタイトル・内容
            memoContent = textView.text
            memoTitle = String(textView.text.prefix(10))
            print("content:", memoContent)
            print("title:", memoTitle, "\n")
            
            //このタイミングでdelegateメソッドを使う
            delegate?.addMemo(title: memoTitle, content: memoContent)
            
            
        }
    }

}
