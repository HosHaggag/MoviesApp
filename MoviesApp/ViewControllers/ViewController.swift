//
//  ViewController.swift
//  MoviesApp
//
//  Created by Hossam on 05/08/2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    let userDefults = UserDefaults.standard
    static var MOVIES_KEY = "movies"
    
    
    
    
    
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let vc = storyboard?.instantiateViewController(identifier: "VC") as? MovieDetailsViewController {

            
            vc.movie = moviesList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        
        print(moviesList)
        
        
        collection.img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(moviesList[indexPath.row].poster!)") , placeholderImage: UIImage(systemName:"exclamationmark.triangle.fill"))

        
        return collection
    }
    
    
    var moviesList : [Movie] = [Movie(name: "String", description: "String", voteCount: 5, voteAverage: 5.5, poster: "String", date: "String"  , id: 50 )]
    
    
    

    @IBOutlet weak var moviesCollection: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollection.dataSource = self
        moviesCollection.delegate = self
        moviesCollection.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        
        checkConnect()
        
        
        
    }
    
    
    func checkConnect(){
        
        if(Service.isConnectedToNetwork()){
            
           fetchData()

            
            print("Internet Connected")
        }else{
            
            let decodedData = try? PropertyListDecoder().decode( [Movie].self, from: self.userDefults.value(forKey: ViewController.MOVIES_KEY) as! Data)


            self.moviesList = decodedData!
            print(decodedData)

            DispatchQueue.main.async {
                
                self.moviesCollection.reloadData()
                
            }
            
            print("Internet Not")
        }
    }
    
    
    func fetchData(){
        
        Service().fetchDataFromApiByAlamofire() { (unwrappedMealArray, error ) in
            
            
            if unwrappedMealArray != nil {
                
                
                self.moviesList = unwrappedMealArray!
                
           
                DispatchQueue.main.async {
                    
                    
                    
                    self.moviesCollection.reloadData()
                    
                }
                
            }
            if error != nil {
                
                print( error)
                print("From Error ")
                
            }
        }
    }
    


}




