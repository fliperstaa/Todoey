//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Никита Гагаринов on 26/11/2018.
//  Copyright © 2018 nikita. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
        
        guard let categoryColour = UIColor(hexString: (categoryArray?[indexPath.row].colour)!) else {fatalError()}
        cell.backgroundColor = categoryColour
        cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        
        return cell
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toItemsSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            dvc.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        
        
        if let categoryForDeletion = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print(error)
            }
//            tableView.reloadData()
        }
    }
    
}


