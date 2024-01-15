//
//  PanierViewController.swift
//  workout
//
//  Created by Mac Mini on 15/1/2024.
//

import UIKit
import CoreData
class PanierViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var tabcoll: UICollectionView!
    
    var exercices = [String]()
    var categories = [String]()
    var setss = [Int32]()
    var repss = [Int32]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exercices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let imageView = contentView.viewWithTag(1) as! UIImageView
        let name = contentView.viewWithTag(2) as! UILabel
        let cat = contentView.viewWithTag(3) as! UILabel

        let st = contentView.viewWithTag(4) as! UILabel

        let rp = contentView.viewWithTag(5) as! UILabel

        
        imageView.image = UIImage(named: exercices[indexPath.row])
        name.text = exercices[indexPath.row]
        cat.text = categories[indexPath.row]
        st.text = String(setss[indexPath.row])
        rp.text = String(repss[indexPath.row])

        
        return cell
    }
    
    
    
    func fetchExercice()  {
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let request=NSFetchRequest<NSManagedObject>(entityName: "Workout")
        
        do{
           let result = try managedContext.fetch(request)
            for item in result{
            
              
                exercices.append(item.value(forKey: "name") as! String)
                categories.append(item.value(forKey: "categorie") as! String)
                setss.append(item.value(forKey: "sets") as! Int32)
                repss.append(item.value(forKey: "reps") as! Int32)

               
            }

        }catch{
            print("topPlayers fetching error")
        }
    }
    
    
    
    //..
    func getByCreateria(name: String) -> NSManagedObject{
        
        var exExist:NSManagedObject?
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                exExist = (result[0] as! NSManagedObject)
                print("exercice exists !")
                
            }
            
        } catch {
            
            print("Fetching by criteria error !")
        }
        
        
        return exExist!
    }
    
    
    //..
    
    func deleteElements() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        for item in exercices {
            
            let object = getByCreateria(name: item)
            managedContext.delete(object)
        }
        

        
                
    }
    
    
    
    @IBAction func supp(_ sender: Any) {
        deleteElements()
        exercices.removeAll()
        tabcoll.reloadData()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExercice()
        tabcoll.reloadData()

    }
    

 

}
