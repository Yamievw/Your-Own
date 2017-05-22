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
    
    var Book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Book != nil {
            bookCover.imageFromURL(url: (Book?.imageURL)!)
            bookTitle.text = (Book?.title)!
            bookAuthors.text = (Book?.authors)!
            bookDescription.text = (Book?.description)!
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
