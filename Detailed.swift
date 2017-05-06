//
//  Detailed.swift
//  Movie
//
//  Created by 王巍 on 3/3/17.
//  Copyright © 2017 王巍. All rights reserved.
//

import UIKit

class Detailed: UIViewController {

    var theImage: UIImage!
    var theName: String!
    var yearReleased: String!
    var score: String!
    var rating: String!
    var favorites: [String] = []
    var personalScoreArray: [String] = []
    var runtime: [String] = []
    var eachruntime: String!
    let usersdefaults = UserDefaults()
    let alert = UIAlertController(title: "Added!", message: nil, preferredStyle: .alert)
    let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var metascore: UILabel!
    @IBOutlet weak var rated: UILabel!
    
    
    @IBOutlet weak var personalScore: UITextField!
    @IBAction func addToFavorites(_ sender: Any) {
        favorites = usersdefaults.object(forKey: "title") as? [String] ?? [String]()
        favorites.append(theName)
        personalScoreArray = usersdefaults.object(forKey: "score") as? [String] ?? [String]()
        personalScoreArray.append(personalScore.text!)
        runtime = usersdefaults.object(forKey: "runtime") as? [String] ?? [String]()
        runtime.append(eachruntime)
        
        let favoriteVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "favoriteVC") as! FavoritesViewController
        
        favoriteVC.usersdefaults.set(favorites, forKey: "title")
        favoriteVC.usersdefaults.set(personalScoreArray, forKey: "score")
        favoriteVC.usersdefaults.set(runtime, forKey: "runtime")
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        alert.addAction(okaction)
        image.image = theImage
        metascore.text = "Score: \(score!) / 100"
        released.text = "Released: \(yearReleased!)"
        rated.text = "Rating: \(rating!)"
        self.title = theName
        
        
        
        
        
        
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
