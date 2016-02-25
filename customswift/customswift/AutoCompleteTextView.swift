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
    @IBInspectable var tablePercentageSize : CGFloat = 1 {
        didSet{
            layer.borderColor = borderColor.CGColor
        }
    }
    
    let defaultTableViewSize :  Int = 3
    var textField: UITextField?
    var tableView : UITableView?
    var queryItems: [String] = []
    var subSetQueryItems: [String] = []
    var currentInputString :  String?
    
    var paramString : String! = ""
    var selectedString : String?
    
    @IBInspectable var borderColor: UIColor = UIColor.whiteColor(){
        didSet{
            layer.borderColor = borderColor.CGColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
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
        self.clipsToBounds = false
        
        self.textField = UITextField(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: frame.width, height: frame.height))
        self.textField!.backgroundColor = UIColor.yellowColor()
        
        self.textField!.placeholder = "orra diabo"
        self.textField!.delegate = self
        self.textField!.enabled = true
        self.textField!.hidden = false
        self.textField!.clipsToBounds = true
       
        let tableY = bounds.origin.y + (textField?.frame.height)!
        let rect = CGRect(x: bounds.origin.x, y: tableY, width: bounds.width, height:  CGFloat( UIScreen.mainScreen().bounds.height))
        self.tableView = UITableView(frame: rect)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.scrollEnabled = true
        self.tableView!.allowsSelection = true
        self.tableView!.hidden = true
        self.tableView!.registerClass(TextUITableViewCell.self, forCellReuseIdentifier: "Cell")

        self.addSubview(textField!)
        self.addSubview(tableView!)

    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: TextUITableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! TextUITableViewCell
        
        self.selectedString = cell.label.text
        
        print(self.selectedString)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:  indexPath) as! TextUITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray

        cell.label.text = queryItems[indexPath.row]
        return cell
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textField!.endEditing(true)
        self.tableView!.hidden = true
        queryItems.removeAll()
        
        queryItems.append("d")
        queryItems.append("d")
        queryItems.append("d")
        queryItems.append("d")
        self.tableView!.reloadData()
    }
    
    func searchAutocompleteEntriesWithSubstring(text: String){
        queryItems.removeAll()
        self.tableView!.reloadData()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.tableView!.hidden = false

        self.paramString = self.paramString! + string
        print(paramString)
       
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}