//
//  ViewController.swift
//  workout
//
//  Created by Mac Mini on 15/1/2024.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var exercices = ["Barbell back squat", "Barbell good morning", "Bench-press", "Bent over row", "Chin up", "Dumbbell triceps extension", "Glute bridge", "Incline dumbbell bench press", "Incline dumbbell flye", "Overhead press", "Rack pull", "Seated dumbbell curl", "Seated dumbbell press", "Triceps-dip"]
    
    var categories = ["Legs And Abs", "Legs And Abs", "Chest And Triceps", "Back And Biceps", "Back And Biceps", "Chest And Triceps", "Legs And Abs", "Chest And Triceps", "Chest And Triceps", "Shoulders", "Back And Biceps", "Back And Biceps", "Shoulders", "Chest And Triceps"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "mCell")
        let cv=cell?.contentView
        
        let imageex=cv?.viewWithTag(1) as! UIImageView
        let exercicename=cv?.viewWithTag(2) as! UILabel
        let exercicat=cv?.viewWithTag(3) as! UILabel

        
        
        imageex.image=UIImage(named: exercices[indexPath.row])
        exercicename.text=exercices[indexPath.row]
        exercicat.text = categories[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "firstSegue", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! DetaisViewController
            destination.exercicename = exercices[indexPath.row]
            destination.catexercice = categories[indexPath.row]
            
        }
    }
    
    
    
    @IBAction func showPanier(_ sender: Any) {
        
        performSegue(withIdentifier: "secondSegue", sender: sender)

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

