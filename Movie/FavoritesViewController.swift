//
//  FavoritesViewController.swift
//  Movie
//
//  Created by 王巍 on 3/4/17.
//  Copyright © 2017 王巍. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {

    var favorites: [String] = []
    var score: [String] = []
    var runtime: [String] = []
    let usersdefaults = UserDefaults()
    @IBOutlet weak var theTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        myCell.textLabel?.text = favorites[indexPath.row]
        myCell.detailTextLabel?.text = runtime[indexPath.row] + "        Your Score: " + score[indexPath.row]
  
        return myCell
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if( editingStyle == UITableViewCellEditingStyle.delete){
            favorites.remove(at: indexPath.row)
            score.remove(at: indexPath.row)
            runtime.remove(at: indexPath.row)
            usersdefaults.set(favorites, forKey: "title")
            usersdefaults.set(score, forKey: "score")
            usersdefaults.set(runtime, forKey: "runtime")
            theTableView.reloadData()
        }
    }
    
    
    
    func load(){
        favorites = usersdefaults.object(forKey: "title") as? [String] ?? [String]()
        score = usersdefaults.object(forKey: "score") as? [String] ?? [String]()
        runtime = usersdefaults.object(forKey: "runtime") as? [String] ?? [String]()
        theTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        load()
        theTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
