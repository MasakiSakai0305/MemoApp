//
//  memoViewController.swift
//  PracticememoApp
//
//  Created by 境将輝 on 2020/02/10.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

class memoViewController: UIViewController,UINavigationControllerDelegate{


//    struct memo{
//        var title: String
//        var content: String
//
//           init(title: String, content: String) {
//               self.title = title
//               self.content = content
//           }
//    }
    //var memoStruct = memo(title:"", content:"")
    
    var memoString = ""
    var memoTitle = ""
    var memoContent = ""
    var cellCount = Int()
    
    var delegate:saveMemoProtocol?
    
    
    @IBOutlet weak var memoView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.delegate = self
        
        memoView.text = memoString
        
    
    }
    
    //前の画面に戻るとき,textviewの中身をメモに格納
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        //前の画面に戻るとき
        if viewController is ViewController {
            print("--変更したメモ--")
            //メモのタイトル・内容
            memoContent = memoView.text
            memoTitle = String(memoView.text.prefix(10))
            
            print("content: ", memoContent)
            print("number: ", cellCount, "\n")
            
            if memoContent == ""{
                print("入ってない")
            }
            
            //このタイミングでdelegateメソッドを使う
            delegate?.changeMemo(title: memoTitle, content: memoContent, count:cellCount)
        }
    }

    

}
