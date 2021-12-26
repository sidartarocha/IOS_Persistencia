    //
    //  ConsolesManager.swift
    //  MyGames
    //
    //  Created by Douglas Frari on 12/4/21.
    //

import CoreData

class ConsolesManager {
    
    // usando singleton
    static let shared = ConsolesManager()
    
    // vai manter na memorias os jogos que foram salvos no CoreData
    var consoles: [Console] = []
    
    
    private init() {
        
    }
    
    
    func loadConsoles(with context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<Console> = Console.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            consoles = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    func deleteConsole(index: Int, context: NSManagedObjectContext) -> Bool {
        
        let console = consoles[index]
        context.delete(console)
        
        do {
            try context.save()
            consoles.remove(at: index)
            return true
        } catch  {
            print(error.localizedDescription)
            return false
        }
    }
    
   
}
