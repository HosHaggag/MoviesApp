//
//  FavoriteTableViewController.swift
//  MoviesApp
//
//  Created by Hossam on 22/08/2021.
//

import UIKit
import CoreData
class FavoriteTableViewController: UITableViewController {
    
    
    var favNames : [String] = []
    var favPoters : [String] = []


    var appDelegate :AppDelegate!
    var managedObjectContext :NSManagedObjectContext!
    var coreDataMovieArray : [NSManagedObject] = []


    override func viewWillAppear(_ animated: Bool) {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")


        do {

         coreDataMovieArray  = try managedObjectContext.fetch(fetchRequest)
            favNames.removeAll()
            favPoters.removeAll()

            for emo in coreDataMovieArray {


                          let title  = emo.value(forKey: "name") as! String
                          let poster =  emo.value(forKey: "poster") as! String
                          print(title)
                print(poster)




                favNames.append(title)
                favPoters.append(poster)

                      }

            tableView.reloadData()




        }
        catch let error as NSError {
            
            print("From Error")


            print(error.localizedDescription)
        }








    }


    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favNames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell

        cell.movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(favPoters[indexPath.row])") , placeholderImage: UIImage(systemName:"exclamationmark.triangle.fill"))

        cell.movieLabel.text = favNames[indexPath.row]


        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            favNames.remove(at: indexPath.row)
            favPoters.remove(at: indexPath.row)
            managedObjectContext.delete(coreDataMovieArray[indexPath.row])
            do {
                try   managedObjectContext.save()
            }

            catch let error as NSError {

                print(error.localizedDescription)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }


}
