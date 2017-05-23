//
//  BookInfoViewController.swift
//  YamievanWijnbergen-pset6
//
//  Created by Yamie van Wijnbergen on 21/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class BookInfoViewController: UIViewController {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookDescription: UITextView!
    
    var book: Book?
    
    var books_database: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.update()
        books_database = Database.database().reference()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Update viewcontroller to elements of selected book.
    func update() {
            bookCover.imageFromURL(url: (book?.imageLink)!)
            bookTitle.text = (book?.title)!
            bookAuthors.text = (book?.authors)!
            bookDescription.text = (book?.description)!
        
        print (book!)
    }
    
    // Add books to bookmarklist.
    @IBAction func bookmarkBook(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Save book", message: " Add to bookmarks", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save",style: .default) { action in
            
            // Check which user is current user.
            let user =  Auth.auth().currentUser?.uid
            
            // Save book to Firebase Database.
            if self.book?.title != ""  {
                
                self.books_database?.child(user!).child("Users").child("Bookmarks").child((self.book?.title)!).child("author").setValue(self.book?.authors)
                self.books_database?.child(user!).child("Users").child("Bookmarks").child((self.book?.title)!).child("image").setValue(self.book?.imageLink)
                self.books_database?.child(user!).child("Users").child("Bookmarks").child((self.book?.title)!).child("description").setValue(self.book?.description)
            }
            else {
                print ("book was not saved properly")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
