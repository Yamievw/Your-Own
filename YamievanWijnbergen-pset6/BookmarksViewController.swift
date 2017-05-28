//
//  BookmarksViewController.swift
//  YamievanWijnbergen-pset6
//
//  ViewController with a list of bookmarked books, with option to delete book.
//
//  Created by Yamie van Wijnbergen on 21/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    
    var books_database: DatabaseReference!
    var databaseHandle: DatabaseHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        books_database = Database.database().reference()
        
        let user =  Auth.auth().currentUser?.uid
        
        // get elements of the book
        books_database?.child(user!).child("Users").child("Bookmarks").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String : [String : Any]] else {
                return
            }
            
            for id in dictionary.keys {
                guard let item = dictionary[id] else {
                    return
                }
                
                let book = Book()
                book.id = id
                book.title = item["title"] as? String
                book.imageLink = item["image"] as? String
                self.books.append(book)
            }
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Create TableView.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    // Display book title and cover in tableviewcell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookmarksTableViewCell
        
        cell.bookTitle.text = books[indexPath.row].title
        
        if let imageLink = books[indexPath.item].imageLink {
            cell.bookCover.imageFromURL(url: imageLink)
        }
        return cell
    }
    
    // Delete book from tableview and database.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeBook = books[indexPath.row].id
            removeBook.books_database?.removeValue()
        }
       self.tableView.reloadData()
    }
}
