//
//  DetaisViewController.swift
//  workout
//
//  Created by Mac Mini on 15/1/2024.
//

import UIKit
import CoreData
class DetaisViewController: UIViewController {
    var exercicename:String?
    var catexercice:String?

    
    var sets = 0
    var reps = 0
    
    @IBOutlet weak var img1: UIImageView!
    
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var label2: UILabel!
    
    
    @IBOutlet weak var labelsets: UILabel!
    
    @IBOutlet weak var labelreps: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img1.image = UIImage(named: exercicename!)
        label1.text = exercicename!
        label2.text = catexercice!

        // Do any additional setup after loading the view.
    }
    

    @IBAction func setsbtn(_ sender: UIStepper) {
        
        sets = Int(sender.value)
        labelsets.text = String(Int(sender.value))
    }
    

    @IBAction func repsbtn(_ sender: UIStepper) {
        
        reps = Int(sender.value)
        labelreps.text = String(Int(sender.value))
    }
    
    
    
    func isAdded() -> Bool {
        var mBoolean=false
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let request=NSFetchRequest<NSManagedObject>(entityName: "Workout")
        let predicate=NSPredicate(format: "name = %@", exercicename!)
        request.predicate=predicate
        
        do{
           let result = try managedContext.fetch(request)
            if result.count>0{
                mBoolean=true
            }

        }catch{
            print("exercice fetching error")
        }
        
        return mBoolean
    }
    
    
    
    func addExercice() {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let entityDescription=NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let object=NSManagedObject(entity: entityDescription!, insertInto: managedContext)
        object.setValue(exercicename, forKey: "name")
        object.setValue(catexercice, forKey: "categorie")
        object.setValue(sets, forKey: "sets")
        object.setValue(reps, forKey: "reps")

       
        
        do{
            try managedContext.save()
            self.showAlert(title: "INSERT SUCCESSFULLY", message: "exercice  ajouter au panier")
        }catch{
            print("Product adding error")
        }
    }
    
    
    
    func showAlert(title:String,message:String) {
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    
    @IBAction func favories(_ sender: Any) {
        if !isAdded(){
            addExercice()
        }else{
            
            self.showAlert(title: "warning", message: "exercice existed")
        }
    }
    
}
