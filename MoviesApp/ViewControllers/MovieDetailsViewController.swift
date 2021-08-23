//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Hossam on 17/08/2021.
//

import UIKit
import SDWebImage
import Cosmos

import youtube_ios_player_helper
import CoreData


class MovieDetailsViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    
    @IBAction func favBtn(_ sender: Any) {
        

        
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedObjectContext)!
        
        let DBmanager = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        
        DBmanager.setValue(movie.name, forKey: "name")
        DBmanager.setValue(movie.poster, forKey: "poster")
        
        
        
    }
    
    
    
    var appDelegate:AppDelegate!
    var managedObjectContext : NSManagedObjectContext!

    var coreDataMovieArray : [NSManagedObject] = []
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")

    var movie : Movie!
//    var name : String!
//    var image : Any!
//    var id : Int!
    var trailersList : [Trailer] = []
    var reviewsList : [Review] = []
       @IBOutlet var descLabel: UILabel!
       @IBOutlet weak var realase: UILabel!
       @IBOutlet weak var poster: UIImageView!
       @IBOutlet weak var stars: CosmosView!
       @IBOutlet weak var label: UILabel!
       @IBOutlet var trailersCollection: UICollectionView!
       @IBOutlet var reviews: UILabel!
    
    
       @IBAction func seeMoreBtn(_ sender: Any) {
        
        if let rv = storyboard?.instantiateViewController(identifier: "RV") as? ReviewsViewController {
            
            
            
            for i in reviewsList {
                
                rv.value = i.content + rv.value
                
                
                
            }
            
            
            
            


          
            
            self.navigationController?.pushViewController(rv, animated: true)

        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 400, height: 320)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "trail", for: indexPath) as! TrailerCollectionViewCell
        if(trailersList.isEmpty){
            
            
        }
        collection.videoView.load(withVideoId: trailersList[indexPath.row].key)

        return collection
    }
    
    
    


   

    override func viewDidLoad() {
        
        
        fetchData()

      
        
        checkFav()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)

        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        super.viewDidLoad()
        
        
        

        trailersCollection.dataSource = self
        trailersCollection.delegate = self
        trailersCollection.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        
        // Assign Values

        label.text = movie.name
        realase.text = "Relase at : \(movie.date!)"
        stars.rating = movie.voteAverage / 2
               stars.text = "(\(movie.voteCount))"
               poster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(movie.poster!)") , placeholderImage: UIImage(systemName:"exclamationmark.triangle.fill"))
        descLabel.text = movie.description
        reviews.text = String(reviewsList.count)
        //

       

        

    }
    
    
    
    func fetchData(){
        
        Service().fetchVideosData(id: movie.id ){ (unwrappedMealArray, error ) in
            
            
            if unwrappedMealArray != nil {
                
                
             
                
                self.trailersList = unwrappedMealArray!
                
                
                DispatchQueue.main.async {
                    self.trailersCollection.reloadData()
                    
                    
                    
                }
                
            }
            if error != nil {
                
                print( error)
                
            }
        }
        
        
        
        Service().fetchReviewsData(id: movie.id){ (unwrappedMealArray , error) in
            
            
            if unwrappedMealArray != nil {
                
                
                
                
                
                DispatchQueue.main.async {
                    
                    
                    self.reviewsList = unwrappedMealArray!

                    self.reviews.text = String(self.reviewsList[0].content)
                    

                    

                    
                }
                
            }
            if error != nil {
                
                print( error)
                
            }
        }
        
        
        
        
        
        
    }
    
    var objectContext : NSManagedObjectContext!

    
    func checkFav(){
        
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)

        

        objectContext = appDelegate.persistentContainer.viewContext

        
        
        coreDataMovieArray  = try! self.objectContext.fetch(fetchRequest)

           for emo in coreDataMovieArray {
            if(emo.value(forKey: "name") as! String == movie.name){
                
                
                print("Movie in Fav")
                
                
            }








                     }
    }
    
    
    

    

}


    


