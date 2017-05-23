//
//  BookInfoViewController.swift
//  YamievanWijnbergen-pset6
//
//  Created by Yamie van Wijnbergen on 21/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookDescription: UITextView!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.update()
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
    @IBAction func bookmarkBook(_ sender: Any) {
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
