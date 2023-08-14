//
//  ListTableViewController.swift
//  Vocabulary
//
//  Created by 陳佩琪 on 2023/8/14.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let urlString = "https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/1%E7%B4%9A.json"
    var vocabulary = [Vocabulary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVocabulary()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
     */
    
    func fetchVocabulary() {
        let urlRequest = URLRequest(url: URL(string: urlString)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let data {
                let decoder = JSONDecoder()
                do {
                    self.vocabulary = try decoder.decode([Vocabulary].self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        fetchVocabulary()
        return vocabulary.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath)

        // Configure the cell...

//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with:url) { data, urlResponse, error in
//                if let data {
//                    let decoder = JSONDecoder()
//                    do {
//                        let vocab = try decoder.decode([Vocabulary].self, from: data)
//                        let word = vocab[indexPath.row].word
//                        DispatchQueue.main.async {
//                            cell.textLabel?.text = word
//                            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
//                        }
//                    } catch {
//                        print(error)
//                    }
//                }
//            }.resume()
//        }
        fetchVocabulary()
        cell.textLabel?.text = vocabulary[indexPath.row].word
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        return cell
    }
    

    
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetailViewController? {
        
        let controller = DetailViewController(coder: coder)
        
        if let index = tableView.indexPathForSelectedRow?.row {
            controller?.vocabulary = vocabulary[index]
        }
        return controller

    }
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
