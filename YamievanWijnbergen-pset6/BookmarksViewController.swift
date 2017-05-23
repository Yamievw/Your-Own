//
//  BookmarksViewController.swift
//  YamievanWijnbergen-pset6
//
//  Created by Yamie van Wijnbergen on 21/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BookmarksViewController: UIViewController, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    var book: Book?
    var books = [Book]()
    
    var books_database: DatabaseReference!
    var databaseHandle: DatabaseHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        books_database = Database.database().reference()
        
        let user =  Auth.auth().currentUser?.uid
        
        // get name of the book
        books_database?.child(user!).child("Users").child("Bookmarks").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let dictionary = snapshot.value as? NSDictionary
            
            self.book?.title = dictionary?.allKeys as! Any as! String
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: Create TableView.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> BookmarksTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookmarksTableViewCell
        
        cell.bookTitle.text = (book?.title)[indexPath.row]
        
        return cell
    }
}
