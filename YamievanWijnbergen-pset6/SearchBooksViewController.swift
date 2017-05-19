//
//  SearchGIFViewController.swift
//  YamievanWijnbergen-pset6
//
//  Created by Yamie van Wijnbergen on 19/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import Firebase

class SearchBooksViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var results = [] as! [[String:Any]]
    
    @IBOutlet weak var BookCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // When user inputs searchitem, search it, disable keyboard and make searchbar empty
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchbook = searchBar.text!.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        print(searchbook)
        searchBook(search: searchbook)
        view.endEditing(true)
    }
    
    // insert GoogleBooks API to get database of books
    func searchBook(search: String){
        
        let search = search.components(separatedBy: " ").joined(separator: "+")
        let request = String("https://www.googleapis.com/books/v1/volumes?q="+search )
        let url = URL(string: request!)
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            print(json)
            if json["Search"] != nil{
                let searchResults = json["Search"] as! [[String : Any]]
                print(searchResults)
                self.results = searchResults
                print(self.results)
                
                DispatchQueue.main.async {
                    self.BookCollectionView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    // MARK: Create Collection View.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! BookCollectionViewCell
        
        // get bookImage
        let link = NSURL(string: self.results[indexPath.row]["imageLinks"] as! String)
        if let data = NSData(contentsOf: link as! URL) {
            cell.BookImage.image = UIImage(data: data as Data)
        }

       
        
        return cell
    }
}
