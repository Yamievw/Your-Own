//
//  BookmarksViewController.swift
//  YamievanWijnbergen-pset6
//
//  Created by Yamie van Wijnbergen on 21/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BookmarksViewController: UIViewController, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    var book: Book?
    var books = [Book]()
    
    var ref: DatabaseReference!
    ref = Database.database().reference()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        cell.bookCover.imageFromURL(url: books[indexPath.row].imageLink!)
        
        return cell
    }
}
