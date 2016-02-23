//
//  AutoCompleteTextView.swift
//  customswift
//
//  Created by Luis Sergio da Silva Junior on 2/23/16.
//  Copyright © 2016 Luis Sergio. All rights reserved.
//

import UIKit

@IBDesignable class AutoCompleteTextView : UIView, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBInspectable var tableViewSize : Int = 0
    
    let defaultTableViewSize :  Int = 3
    var textField: UITextField?
    var tableView : UITableView?
    var queryItems: [String] = []
    var currentInputString :  String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubview()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubview()
    }

    
    private func initSubview(){
        queryItems.append("a")
        queryItems.append("b")
        queryItems.append("c")
        queryItems.append("d")
        self.tableView = UITableView(frame: frame)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.scrollEnabled = true
        self.tableView!.hidden = true
        self.tableView!.registerClass(UITableViewCell(), forCellReuseIdentifier: "Cell")
        self.textField = UITextField(frame: frame)
        self.textField?.delegate = self
        self.addSubview(tableView!)
        self.addSubview(textField!)

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        return cell!
    }
    
    func searchAutocompleteEntriesWithSubstring(text: String){
        queryItems.removeAll()
        self.tableView!.reloadData()
    }
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.tableView!.hidden = false
        if let text = textField.text{
            if !queryItems.contains(text){
                queryItems.append(text)
            }
        }
       
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewSize > 0 {
            return tableViewSize
        }else{
            return defaultTableViewSize
            }
    }
}