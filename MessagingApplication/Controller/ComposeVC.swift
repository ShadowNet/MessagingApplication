//
//  ComposeVC.swift
//  MessagingApplication
//
//  Created by Redghy on 6/5/22.
//

import Foundation
import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPost(_ sender: Any) {
        // TODO: Post the data to Firebase
        if textView.text != "" {
            while (textView.text[textView.text.index(before: textView.text.endIndex)] == " ") {
                textView.text.remove(at: textView.text.index(before: textView.text.endIndex))
            }
            let key = ref?.childByAutoId().key
            let post = ["key": key, "text": textView.text]
            ref?.child("Posts").child(key!).setValue(post)
        }
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

}
