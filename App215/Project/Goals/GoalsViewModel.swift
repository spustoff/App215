//
//  GoalsViewModel.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI
import CoreData

final class GoalsViewModel: ObservableObject {
    
    @Published var goals: [GoalsModel] = []
    
    @Published var colors: [Color] = [Color("red"), Color("gray"), Color("primary")]
    
    @Published var endDate: Date = Date()
    @Published var startDate: Date = Date()
    
    @Published var title: String = ""
    @Published var comment: String = ""
    
    @Published var isAdd: Bool = false
    
    @Published var pie_currentTab: String = "Candle Chart"
    @Published var pie_currentPair: String = "EURUSD"
    
    func addGoal(category: String, completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "GoalsModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "GoalsModel", into: context) as! GoalsModel
        
        trans.end = endDate
        trans.start = startDate
        trans.title = title
        trans.comment = comment
        
        trans.category = category
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchGoals(isFilter: Bool, category: String) {
        
        CoreDataStack.shared.modelName = "GoalsModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GoalsModel>(entityName: "GoalsModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            if isFilter {
                
                self.goals = branch.filter{$0.category == category}
                
            } else {
                
                self.goals = branch
            }
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.goals = []
        }
    }
}
