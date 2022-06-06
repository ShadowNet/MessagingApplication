//
//  ViewController.swift
//  MessagingApplication
//
//  Created by Redghy on 5/20/22.
//
import UIKit
import FirebaseDatabase

var ID = String()
var out = String()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var check = true
    
    var postData = [TextModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Sets uo the database reference
        ref = Database.database().reference().child("Posts")
        ref?.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount>0 {
                self.postData.removeAll()
                
                for Posts in snapshot.children.allObjects as! [DataSnapshot] {
                    let postObject = Posts.value as? [String: AnyObject]
                    let text = postObject?["text"]
                    let key = postObject?["key"]
                    
                    let post = TextModel(key: key as! String?, text: text as! String?)
                    self.postData.append(post)
                }
                self.tableView.reloadData()
            }
        })
        
 
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let post: TextModel
        post = postData[indexPath.row]
        cell.textLabel?.text = post.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let post: TextModel
            post = postData[indexPath.row]
            let key = post.key
            ref = Database.database().reference()
            ref?.child("Posts").child(key!).removeValue()
            postData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp:TextModel = postData.remove(at: sourceIndexPath.row)
        
        postData.insert(temp, at: destinationIndexPath.row)
    }
    
    @IBAction func editButton(_ sender: Any) {
        if (check == true) {
            tableView.isEditing = true
            editButtonLabel.title = "Done"
            check = false
        }
        else {
            tableView.isEditing = false
            editButtonLabel.title = "Edit"
            check = true
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // moves to next ViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
        
        // Sends key
        let post: TextModel
        post = postData[indexPath.row]
        out = post.text!
        ID = post.key!
    }
}

