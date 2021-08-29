//
//  IntentHandler.swift
//  AquariumLifeIntents
//
//  Created by Sahil Satralkar on 07/08/21.
//

import Intents
import CoreData

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler : SelectAquariumIntentHandling {
    
    func getResults() -> [AddAquarium] {
        
        let container = StorageProvider.standard.persistentContainer
        
        //Fetch request
        let requestAquarium = NSFetchRequest<NSFetchRequestResult>(entityName: "AddAquarium")
        //sorting results according to date
        requestAquarium.sortDescriptors = [NSSortDescriptor(keyPath: \AddAquarium.date, ascending: false)]
        
        do {
            let results = try container.viewContext.fetch(requestAquarium) as! [AddAquarium]
            return results
        }
        catch {
            fatalError("Could not fetch AddAquarium\(error)")
        }
    }
    
    func provideAquariumOptionsCollection(for intent: SelectAquariumIntent, with completion: @escaping (INObjectCollection<Aquarium>?, Error?) -> Void) {
        
        let results = getResults()
        
        let aquariums : [Aquarium] = results.map { aquarium in
            let tempAquarium = Aquarium(identifier: aquarium.aquariumName, display: aquarium.aquariumName!)
            return tempAquarium
        }
        let collection = INObjectCollection(items: aquariums)
        
        completion(collection, nil)
    }
    
    func defaultAquarium(for intent: SelectAquariumIntent) -> Aquarium? {
        let results = getResults()

        let resultsFirst = results.last

        let aquarium = Aquarium(identifier: resultsFirst?.aquariumName, display: resultsFirst?.aquariumName ?? "No Aquariums" )

        return aquarium


    }
}
