//
//  HistoryViewController.swift
//  UnitConversion
//
//  Created by Isuru Wijesinghe on 2/20/20.
//  Copyright © 2020 Devon Wijesinghe. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    var history : [String]! = [String] ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initHistoryInfo()

        // Do any additional setup after loading the view.
    }
    
    func initHistoryInfo(){
     
        if let vcs = self.navigationController?.viewControllers {
            let previousVC = vcs[vcs.count - 2]
            if previousVC is TempratureViewController {
                loadDefaultData("TemperatureHistory")
            }else{
                loadDefaultData("TemperatureHistory")
            }
        }else{
            loadDefaultData("TemperatureHistory")
        }
    }
    
    func loadDefaultData(_ historyKey: String){
        let defaults = UserDefaults.standard
        history = defaults.object(forKey: "TemperatureHistory") as? [String] ?? [String] ()
        print(history)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.textAlignment = NSTextAlignment.center
        cell?.textLabel!.numberOfLines = 0  
        cell?.textLabel!.lineBreakMode = .byWordWrapping
        cell?.textLabel?.text = history[indexPath.row]
        return cell!
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
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
