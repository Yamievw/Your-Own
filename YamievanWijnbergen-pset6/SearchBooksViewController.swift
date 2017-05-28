//
//  SearchBooksViewController.swift
//  YamievanWijnbergen-pset6
//
//  ViewController to search for a book using the Google Books API
//
//  Created by Yamie van Wijnbergen on 19/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import Firebase


class SearchBooksViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var books = [Book]()
    var book: Book?
    
    @IBOutlet weak var BookCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // When user inputs searchitem, search it, disable keyboard and make searchbar empty
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchbook = searchBar.text!.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        searchBook(search: searchbook)
        view.endEditing(true)
    }
    
    // insert GoogleBooks API to get database of books
    func searchBook(search: String){
        
        let search = search.components(separatedBy: " ").joined(separator: "+")
        let request = String("https://www.googleapis.com/books/v1/volumes?q="+search )
        let url = URL(string: request!)
        
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print (json)
            if let rootDictionary = json as? [String: Any],
                let items = rootDictionary["items"] as? [[String:Any]] {
                
                self.books = []
                
                // Get elements from API
                for item in items {
                    if let volumeInfo = item["volumeInfo"] as? [String: AnyObject] {
                        let book = Book()
                        
                        book.title = volumeInfo["title"] as? String
                        
                        if let imageLinks = volumeInfo["imageLinks"] as? [String: String] {
                            book.imageLink = imageLinks["thumbnail"]
                        }
                        
                        if let authors = volumeInfo["authors"] as? [String] {
                            book.authors = authors.joined(separator: ", ")
                        }

                        if let description = volumeInfo["description"] as? String {
                            book.description = description
                        }
                        if let id = item["id"] as? String {
                            book.id = id
                        }
                        
                        self.books.append(book)
                    }
                }
                DispatchQueue.main.async {
                    self.BookCollectionView.reloadData()
                }
            }
        }
        .resume()
    }
    

    // MARK: Create Collection View.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        if let imageLink = books[indexPath.item].imageLink {
            cell.bookImage.imageFromURL(url: imageLink)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        book = books[indexPath.item]
        self.performSegue(withIdentifier: "bookInfo", sender: nil)

    }

    // Segue to next viewcontroller to get info on specific book
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? BookInfoViewController {
            viewController.book = self.book
        }
    }
}

// Function to create image from url.
extension UIImageView {
    
    func imageFromURL(url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print ("Cant load imagesURL \(error)")
                } else {
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }).resume()
        }
    }
}
