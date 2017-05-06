//
//  ViewController.swift
//  Movie
//
//  Created by 王巍 on 2/27/17.
//  Copyright © 2017 王巍. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITabBarDelegate, WKNavigationDelegate{
    
    var tempview: UIView!
    var webView: WKWebView!
    var theData: [MovieInfo] = []
    var theImageCache: [UIImage] = []
    var detailedData: DetailedData!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var Searchbar: UISearchBar!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var loading: UIActivityIndicatorView!


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.imageView?.image = theImageCache[indexPath.item]
        cell.titleLabel?.text = theData[indexPath.item].name
    
        
        return cell
    }
    
    private func fetchDataForCollectionView(searchText:String) {
        let searchText2 = searchText.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let json = getJSON("http://www.omdbapi.com/?s=\(searchText2)")
        for result in json["Search"].arrayValue {
            let name = result["Title"].stringValue
            let url = result["Poster"].stringValue
            let imdbID = result["imdbID"].stringValue
            theData.append(MovieInfo(name: name, imageurl: url, imdbID: imdbID))
        }
        let json2 = getJSON("http://www.omdbapi.com/?s=\(searchText2)&page=2")
        for result in json2["Search"].arrayValue {
            let name = result["Title"].stringValue
            let url = result["Poster"].stringValue
            let imdbID = result["imdbID"].stringValue
            theData.append(MovieInfo(name: name, imageurl: url, imdbID: imdbID))
        }
        
        
    }
    
    private func getJSON(_ url: String) -> JSON {
        
        if let url = URL(string: url){
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                return json
            } else {
                return JSON.null
            }
        } else {
            return JSON.null
        }
        
        
    }
    
    private func cacheImages() {
        
        for item in theData {
            if let url = URL(string: item.imageurl){
                if let data = try? Data(contentsOf: url){
                    if let image =  UIImage(data: data){
                        theImageCache.append(image)
                    }
                    
                    
                }else{
                    let noimageurl = URL(string: "https://www.collisionclaims.com/wp-content/uploads/2012/09/no-image5510.jpg")
                    let data = try? Data(contentsOf: noimageurl!)
                    let image = UIImage(data: data!)
                    theImageCache.append(image!)

                }
            }
            
            
            
            
        }
        
    }
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        loading.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.theData.removeAll()
            self.theImageCache.removeAll()
            
            self.fetchDataForCollectionView(searchText: searchBar.text!)
            self.cacheImages()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.loading.stopAnimating()
            }
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailedVC") as! Detailed
        detailedVC.theName = theData[indexPath.item].name
        detailedVC.theImage = theImageCache[indexPath.item]
        fetchDataforDetailedInfo(imdbID: theData[indexPath.item].imdbID)
        detailedVC.score = detailedData.score
        detailedVC.rating = detailedData.rating
        detailedVC.yearReleased = detailedData.yearReleased
        detailedVC.eachruntime = detailedData.runtime
        
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func fetchDataforDetailedInfo(imdbID: String){
        let json = getJSON("http://www.omdbapi.com/?i=\(imdbID)")
        let score = json["Metascore"].stringValue
        let rating = json["Rated"].stringValue
        let yearReleased = json["Year"].stringValue
        let runtime = json["Runtime"].stringValue
        
        detailedData = DetailedData(score: score, rating: rating, yearReleased: yearReleased, runtime: runtime)
        

    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "AMC", style: .default, handler: openPage))
        
        ac.addAction(UIAlertAction(title: "Back", style: .default, handler: back))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        present(ac,animated: true, completion: nil)
        
    }
    
    func back(action: UIAlertAction) {
        view = tempview
    }

    func openPage(action: UIAlertAction){
        let url = URL(string: "https://" + action.title! + "theatres.com")!
        webView = WKWebView()
        webView.navigationDelegate = self
        
        webView.allowsBackForwardNavigationGestures = true
    
        webView.load(URLRequest(url: url))
        
        view = webView
        
    }

  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Movies"
        Searchbar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        tempview = view
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tickets", style: .plain, target: self, action: #selector(openTapped))
        
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

