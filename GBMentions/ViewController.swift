//
//  ViewController.swift
//  GBMentions
//
//  Created by Apple on 10/09/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var textDetails = [Details]()
    
    var isFullName: Bool = false
    
    var startIndex: Int? = nil
    var length: Int = 0
    var textMention: String = ""
    
    var detail = Details()
    
    var arrayDetails = [Details]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        textDetails = [Details(startIndex: nil, length: nil, text: "Hello", id: "10"),
                       Details(startIndex: nil, length: nil, text: "Test", id: "10"),
                       Details(startIndex: nil, length: nil, text: "Working", id: "10"),
                       Details(startIndex: nil, length: nil, text: "Singh", id: "10"),
                       Details(startIndex: nil, length: nil, text: "Gurinder", id: "10"),
                       Details(startIndex: nil, length: nil, text: "Batth", id: "10")]
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = textDetails[indexPath.row].text
        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var text = textView.text
        var detail =  textDetails[indexPath.row]
        let textAppend = detail.text!
        detail.length = textAppend.count
        detail.startIndex = (text?.count)! + 1
        self.arrayDetails.append(detail)
        text?.append(textAppend)
        self.textView.text = text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let fullString = textView.text.replacingCharacters(in: Range(range, in: textView.text)!, with: text)
        if text == "@"{
            self.tableView.isHidden = false
            self.isFullName = true
            startIndex = range.location
            detail.startIndex = startIndex
        }else if text == " "{
            self.tableView.isHidden = true
        }
        
        let  char = text.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if isBackSpace == -92 {
            var length = 0
            for detail in arrayDetails{
                length = detail.startIndex! + detail.length!
                if length == (range.location + 2){
                    var string = textView.text
                    let range = string?.range(of: detail.text!)
                    string?.removeSubrange(range!)
                    self.textView.text = string
                    break
                }
            }
            return true
        }
        
        return true
    }
    
    @IBAction func btnMentions(_ sender: Any?){
        for detail in arrayDetails{
            print("Start Index",detail.startIndex)
            print("Length",detail.length)
            print("Text",detail.text)
        }
    }
}

