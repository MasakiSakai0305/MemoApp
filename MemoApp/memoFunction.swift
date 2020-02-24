//
//  memoFunction.swift
//  MemoApp
//
//  Created by 境将輝 on 2020/02/24.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import Foundation

class MemoFunction{
    
    init(){}
    
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
    //        array.remove(at: 4)
    //        array.remove(at: 2)
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

    
    //メモのタイトルを記憶するdelegateメソッド
        //addmemoから戻る時に呼ばれる
        func addMemo(content: String){
            
            print("---addMemo---")
    //        memoArray.append(content)
    //        print(memoArray)
            var array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
            array.append(content)
            UserDefaults.standard.set(array, forKey: "memoArray")
            
    //        print("--メモが追加されているかチェック--")
    //        for i in 0 ..< memoArray.count{
    //            print(memoArray[i])
    //        }
    //        print("\n")
            tableview.reloadData()
            print("--addmemo終了--")
            
        }
        
        //メモのタイトルを記憶するdelegateメソッド
        //memoから戻る時に呼ばれる
        func changeMemo(content: String, count:Int){
            
            print("---changeMemo---")
            var array = UserDefaults.standard.object(forKey: "memoArray") as! [String]
            array[count] = content
            UserDefaults.standard.set(array, forKey: "memoArray")
            
    //        print("title: ", title)
    //        print("content: ", content)
    //        print("count: ", count)
    //
    //        memoArray[count] = memo(title: title, content: content)
            
            
            tableview.reloadData()
            print("---changeMemo終了---")
            
        }

    
    
}
