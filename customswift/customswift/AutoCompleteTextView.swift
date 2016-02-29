//
//  AutoCompleteTextView.swift
//  customswift
//
//  Created by Luis Sergio da Silva Junior on 2/23/16.
//  Copyright © 2016 Luis Sergio. All rights reserved.
//
import Contacts
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
    var contactList : [Contact] = []
    var currentInputString :  String?
    
    var paramString : String! = ""
    var selectedString : String?
    var contactPermission : Bool = false
    var contactView : ContactView?
    
    var contactStore : CNContactStore?
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
        self.contactStore = self.accessContacts()
        self.initSubview()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contactStore = self.accessContacts()
        self.initSubview()
    }
    
    private func accessContacts() -> CNContactStore{
        let contactStore = CNContactStore()
        switch CNContactStore.authorizationStatusForEntityType(.Contacts){
        case .Authorized:
            print("Authorized")
            contactPermission = true
        case .NotDetermined:
            print("Not Determined")
            contactStore.requestAccessForEntityType(.Contacts){succeeded, err in
                guard err == nil && succeeded else{
                    return
                }
            }
        default:
            print("Not Authorized")
            contactPermission = false
        }
        return contactStore
    }
    
    private func getContactList(prefix: String,store: CNContactStore){
        NSOperationQueue().addOperationWithBlock({
            if self.contactPermission{
                let predicate = CNContact.predicateForContactsMatchingName(prefix)
                let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey,CNContactEmailAddressesKey, CNContactImageDataKey]
                
                do{
                    let contacts = try store.unifiedContactsMatchingPredicate(
                        predicate, keysToFetch: toFetch)
                    var myContacts = [Contact]()
                    
                    for contact in contacts{
                        let myContact = Contact()
                        myContact.name = contact.givenName
                        myContact.familyName = contact.familyName
                        myContact.thumbImage = contact.imageData
                        myContact.id = contact.identifier
                        myContacts.append(myContact)
                        self.contactList.append(myContact)
                        self.subSetQueryItems.append(myContact.name!)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView?.reloadData()
                    })
                    print("contact read")
                    
                } catch let err{
                    print(err)
                }
            }
        })
    }

    private func initSubview(){
        self.clipsToBounds = true
        
        self.textField = UITextField(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: frame.width, height: 30))
        
        self.textField!.placeholder = "Enter your contact name here"
        self.textField!.delegate = self
        self.textField!.enabled = true
        self.textField!.hidden = false
        self.textField!.clipsToBounds = true
        self.textField!.becomeFirstResponder()
        
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
    
    private func addContactView(name: String, image: UIImage?){
        if let currentContactView = self.contactView{
            currentContactView.removeFromSuperview()
        }
        self.contactView = ContactView(frame: CGRect(x: (textField?.frame.origin.x)!*2, y: (textField?.frame.origin.y)!, width: ((textField?.bounds.width)!/5), height: (textField?.frame.height)!))
        self.contactView!.hidden = false
        self.contactView!.name.text = name
        if let myImage = image{
            self.contactView!.image.hidden = false
            self.contactView!.image.image = myImage
            self.contactView!.firstLetter.hidden = true
        }else{
            self.contactView!.image.hidden = true
            self.contactView!.firstLetter.text = String(name.characterAtIndex(0)!).uppercaseString
            self.contactView!.firstLetter.hidden = false
        }
        self.addSubview(self.contactView!)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: TextUITableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:  indexPath) as! TextUITableViewCell
        

        self.selectedString = cell.label.text
        self.textField!.text = selectedString
        self.tableView!.hidden = true
        
        if let string = self.selectedString{
            print(string)
        }
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:  indexPath) as! TextUITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        cell.label.text = contactList[indexPath.row].name
        
        if let thumbImage = contactList[indexPath.row].thumbImage{
             cell.currentImage.image = UIImage(data: thumbImage)
        }
        return cell
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        return true

    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        return true
    }
    
//    private func updateSubsetWords(word: String){
//        self.subSetQueryItems.removeAll()
//        for currentString in queryItems{
//            if currentString.hasPrefix(word) {//||  word.hasPrefix(currentString){
//                subSetQueryItems.append(currentString)
//            }
//        }
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textField!.endEditing(true)
        self.tableView!.hidden = true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.tableView!.hidden = false
        self.addContactView("teste", image: nil)
        if (range.length==1 && string.characters.count==0){
            print("backspace Pressed")
            self.paramString = self.paramString.substringToIndex(self.paramString.endIndex.predecessor())
        }else{
            self.paramString = self.paramString! + string

        }
        self.subSetQueryItems.removeAll()
        getContactList(self.paramString, store: self.contactStore!)
       
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subSetQueryItems.count
    }
}