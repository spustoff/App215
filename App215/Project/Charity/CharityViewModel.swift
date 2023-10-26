//
//  CharityViewModel.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI
import CoreData

final class CharityViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var text: String = ""
    @Published var need: String = ""
    
    @Published var isAdd: Bool = false
    
    @Published var charities: [CharityModel] = []
    
    func addCharity(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "CharityModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "CharityModel", into: context) as! CharityModel
        
        trans.title = title
        trans.text = text
        trans.need = need
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchCharities() {
        
        CoreDataStack.shared.modelName = "CharityModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CharityModel>(entityName: "CharityModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            self.charities = branch
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.charities = []
        }
    }
}
