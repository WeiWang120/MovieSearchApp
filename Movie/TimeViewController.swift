//
//  TimeViewController.swift
//  Movie
//
//  Created by 王巍 on 3/7/17.
//  Copyright © 2017 王巍. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    var runtime: [String] = []
    let usersdefaults = UserDefaults()
    var totaltime: Float = 0
    
    @IBOutlet weak var timelabel: UILabel!
    private let circleButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 50
        return button
    }()
    
    func buttonPressed(){
        totaltime = 0
        for time in runtime{
            let realtime = Float(time.replacingOccurrences(of: " min", with: ""))
            totaltime = totaltime + realtime!
        }
        timelabel?.text = String(totaltime).replacingOccurrences(of: ".0", with: " min")
        animteLable()
    }
    
    func animteLable() {
        
                UIView.animate(withDuration: 3.5, delay: 1, options: .curveEaseOut, animations: {
        
                    self.timelabel.center = self.view.center
        
                }, completion: nil
                )
        
        

        
    }

    override  func viewWillAppear(_ animated: Bool) {
        runtime = usersdefaults.object(forKey: "runtime") as? [String] ?? [String]()
        timelabel.center = CGPoint(x: view.center.x, y: view.frame.height + 150)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Time" 
        circleButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        circleButton.center = CGPoint(x: view.center.x , y: 200)
        view.addSubview(circleButton)

        
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
