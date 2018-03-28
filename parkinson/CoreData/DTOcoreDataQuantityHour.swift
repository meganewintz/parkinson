//
//  DTOcoreDataQuantityHour.swift
//  parkinson
//
//  Created by Thierry WINTZ on 28/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData

class DTOcoreDataQuantityHour {
    let request : NSFetchRequest<QuantityHourData> = QuantityHourData.fetchRequest()
    
    func save() {
        CoreDataManager.save()
    }
    
    func search(quantity: Int, hour: Date) -> QuantityHourData? {

        self.request.predicate = NSPredicate(format:"quantity == %@ AND hour == %@", Int16(quantity), hour as CVarArg)
        do{
            let result = try CoreDataManager.context.fetch(request) as [QuantityHourData]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func fetchAll() -> [QuantityHourData]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    func getQuantityHourDatas(dailyDoses: [DailyDose]) -> NSSet {
        let quantityHoursNSSet: NSSet = []
        var quantityHourData: QuantityHourData
        for d in dailyDoses {
            quantityHourData = QuantityHourData(context: CoreDataManager.context)
            quantityHourData.quantity = Int16(d.quantity)
            quantityHourData.hour = d.dailyPeriod
            save()
            quantityHoursNSSet.adding(quantityHourData)
        }
        return quantityHoursNSSet
    }
}


