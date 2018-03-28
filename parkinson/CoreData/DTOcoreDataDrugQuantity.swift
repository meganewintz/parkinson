//
//  DTOcoreDataDrugQuantity.swift
//  parkinson
//
//  Created by Thierry WINTZ on 25/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import CoreData

class DTOcoreDataDrugQuantity {
    
    let request : NSFetchRequest<DrugQuantityData> = DrugQuantityData.fetchRequest()
    
    func save() {
        CoreDataManager.save()
    }
    
    /// Get all the drugQuantities from the coreData
    ///
    /// - Returns: an array of Float, nil if there is no drugQuantity in the coreData
    func getAllQuantities() -> [Float]? {
        do{
            let quantitiesData = try CoreDataManager.context.fetch(self.request)
            var quantities = [Float]()
            for quant in quantitiesData {
                quantities.append(quant.quantity)
            }
            return quantities
        }
        catch{
            return nil
        }
    }
    
    /// Search a drugQuantity in the CoreData
    ///
    /// - Parameter quantity: <#quantity description#>
    /// - Returns: true if the quantity is in the coreData
    func search(quantity: Float) -> Bool {
        self.request.predicate = NSPredicate(format: "quantity == %@", quantity)
        do{
            let result = try CoreDataManager.context.fetch(request) as [DrugQuantityData]
            if result.count != 0 { return false }
            else { return true }
        }
        catch{
            print("Error during drugQuantity search")
            return false
        }
    }
    
    /// get a drugQuantity from the CoreData, if a drugQuantity with the quantity enter doesn't exist, we create it.
    ///
    /// - Parameter quantity
    /// - Returns: DrugQuantity with the quantity enter in paramter
    func getDrugQuantity(quantity: Float) -> DrugQuantityData? {
        //self.request.predicate = NSPredicate(format: "quantity == %@", quantity)
        do{
            let result = try CoreDataManager.context.fetch(request) as [DrugQuantityData]
            if result.count != 0 { return result[0] }
            else {
                let drugData = DrugQuantityData(context: CoreDataManager.context)
                drugData.quantity = quantity
                
                self.save()
                return drugData
            }
        }
        catch{
            print("Error during drugQuantity search")
            return nil
        }
    }
    
    /// Create a drug quantity in the coreData (if it not already exist)
    ///
    /// - Parameters:
    ///   - quantity: Float
    /// - Returns: True if the quantity was created. False if the quantity is already in the CoreData
    func createDrugQuantity(quantity: Float) -> Bool {
        
        // Case 1: this drugQuantity already exist in CoreData, we don't add it
        if !search(quantity: quantity) {
            return false
        }
        // Case 2: drug name doesn't exist, we create it.
        else {
            let drugData = DrugQuantityData(context: CoreDataManager.context)
            drugData.quantity = quantity
            
            self.save()
            return true
        }
    }
    
    /// remove the activity enter in paraamter from the CoreData
    ///
    /// - Parameter quantity:
    /// - Returns: true if the quantity was successfully delete.
    func removeQuantity(quantity: Float) -> Bool {
        self.request.predicate = NSPredicate(format: "quantity == %@", quantity)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as [DrugQuantityData]
            if result.count != 0 {
                CoreDataManager.context.delete(result[0])
                return true
            } else { return false }
        }
        catch{
            print("Error during drugQuantity delete")
            return false
        }
    }
}

