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
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let tableFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
            self.frame.size.width,
            self.frame.size.height + 300);
        if let contactView = self.contactView{
            if CGRectContainsPoint(contactView.closeButton.frame, point){
                print("closedButton clicked")
                return contactView.closeButton
            }else if CGRectContainsPoint(contactView.frame, point){
                print("contactView clicked")
                return contactView
            }else if (CGRectContainsPoint(tableFrame, point)) &&  tableView!.hidden == false {
                print("tableview clicked")
                return tableView!
            }
        }else{
            if CGRectContainsPoint(self.textField!.frame, point){
                print("textField clicked")
                return self.textField!
            }else if (CGRectContainsPoint(tableFrame, point)) &&  tableView!.hidden == false {
                print("tableview clicked")
                return tableView!
            }else if CGRectContainsPoint(frame, point){
                print("view clicked")
                return self
            }
            return nil
        }
        return nil
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
    
    private func initSubview(){
        self.clipsToBounds = false
        
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
        self.contactView = ContactView(frame: CGRect(x: (textField?.frame.origin.x)!*2, y: (textField?.frame.origin.y)!, width: ((textField?.bounds.width)!/3), height: (textField?.bounds.height)!))
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: TextUITableViewCell =  tableView.cellForRowAtIndexPath(indexPath) as! TextUITableViewCell
        
        if let currentSelectedString = cell.label.text{
            self.selectedString = currentSelectedString
            self.tableView!.hidden = true
            self.addContactView(self.selectedString!, image: nil)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:  indexPath) as! TextUITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        cell.label.text = contactList[indexPath.row].name! + String(" ") + contactList[indexPath.row].familyName!
        
        if let thumbImage = contactList[indexPath.row].thumbImage{
             cell.currentImage.image = UIImage(data: thumbImage)
        }
        return cell
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textField!.endEditing(true)
        self.tableView!.hidden = true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
          self.contactList.removeAll()
        self.tableView?.reloadData()
        self.tableView!.hidden = false
       
        if (range.length==1 && string.characters.count==0){
          
            self.paramString = self.paramString.substringToIndex(self.paramString.endIndex.predecessor())
            if self.paramString.characters.count == 0{
                self.contactList.removeAll()
                self.paramString = ""
            }else{
                 self.getContactList(self.paramString, store: self.contactStore!)
            }
            
        }else{
            self.paramString = self.paramString! + string
            self.getContactList(self.paramString, store: self.contactStore!)
        }
        print(self.paramString)
      

       
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    private func fillStringArrayWithContactInfo(prefix: String, contacts: [Contact]) -> [Contact]{
        var filteredContacts = [Contact]()
        for contact in contacts{
            if contact.name!.startsWith(prefix) == true {
                filteredContacts.append(contact)
            }
        }
        return filteredContacts
    }
    
    private func getContactList(prefix: String,store: CNContactStore){
        NSOperationQueue().addOperationWithBlock({
            if self.contactPermission{
                let predicate = CNContact.predicateForContactsMatchingName(prefix)
                let toFetch = [CNContactGivenNameKey, CNContactIdentifierKey,CNContactFamilyNameKey,CNContactEmailAddressesKey, CNContactImageDataKey]
                
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
                        myContact.email = contact.emailAddresses
                        myContacts.append(myContact)
                    }
                    self.contactList = self.fillStringArrayWithContactInfo(prefix, contacts: myContacts)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView?.reloadData()
                    })
                    
                } catch let err{
                    print(err)
                }
            }
        })
    }

}