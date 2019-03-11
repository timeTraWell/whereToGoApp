//
//  DetailEventViewController.swift
//  
//
//  Created by Nickolay Nickitin on 10/03/2019.
//

import UIKit

class DetailEventViewController: UIViewController {
    
    // MARK: - Properties
    
    private var eventID: Int? = 0

    // MARK: - IBOutlets
    
    @IBOutlet var container: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.eventID)
        // Do any additional setup after loading the view.
    }
    
    public func setEventID(id: Int) {
        self.eventID = id
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
