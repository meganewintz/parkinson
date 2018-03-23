//
//  DTOcoreDataFrequency.swift
//  parkinson
//
//  Created by Thierry WINTZ on 22/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData

class DTOcoreDataFrequency {
    let request : NSFetchRequest<FrequencyData> = FrequencyData.fetchRequest()
    
    func save() {
        CoreDataManager.save()
    }
    
    func search(day: String, hour: Date) -> FrequencyData? {
        self.request.predicate = NSPredicate(format: "day == %@ AND hour == %@", day, hour as CVarArg)
        do{
            let result = try CoreDataManager.context.fetch(request) as [FrequencyData]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func fetchAll() -> [FrequencyData]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
}
