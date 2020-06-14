//
//  ChatViewController.swift
//  HeyChat
//
//  Created by Aman Ilyasovich on 5/25/20.
//  Copyright © 2020 Aman Ilyasovich. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = []
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = C.appName
        
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: C.cellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(C.FStore.collectionName)
            .order(by: C.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data[C.FStore.senderField] as? String, let messageBody = data[C.FStore.bodyField] as? String  {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
                }
            }
        }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signoutError as NSError {
            print("Error signing out: %@", signoutError)
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(C.FStore.collectionName).addDocument(data: [
                C.FStore.senderField : messageSender,
                C.FStore.bodyField : messageBody,
                C.FStore.dateField : Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                    self.messageTextField.text = ""
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        // Message sender
        if message.sender == Auth.auth().currentUser?.email {
            cell.aAvatar.isHidden = true
            cell.cAvatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: C.BrandColors.green)
            cell.messageLabel.textColor = UIColor(named: C.BrandColors.black)
        }
        
        // Message receiver
        else {
            cell.aAvatar.isHidden = false
            cell.cAvatar.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: C.BrandColors.lightGrey)
            cell.messageLabel.textColor = UIColor(named: C.BrandColors.black)
        }
        return cell
    }

}
