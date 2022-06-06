//
//  FollowUpView.swift
//  MessagingApplication
//
//  Created by Redghy on 6/5/22.
//

import Foundation
import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SecondViewController.touch(sender:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        ref = Database.database().reference()
        textView.text = out
       
        
//        if (addButton.action != nil) {
//            ref?.child("Posts").child(ID).setValue(textView.text)
//            print("Hello mother fucker")
//        }
        
    
    }
    
    @objc func touch(sender: UIBarButtonItem) {
        if textView.text != "" {
            while (textView.text[textView.text.index(before: textView.text.endIndex)] == " ") {
                textView.text.remove(at: textView.text.index(before: textView.text.endIndex))
            }
            let post : [String:Any] = ["key": ID, "text": textView.text!]
            ref?.child("Posts").child(ID).setValue(post)
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let firstVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
