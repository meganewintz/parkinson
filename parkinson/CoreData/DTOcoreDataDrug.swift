//
//  DTOcoreDataDrog.swift
//  parkinson
//
//  Created by Thierry WINTZ on 25/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData

class DTOcoreDataDrug {
    
    let request : NSFetchRequest<DrugData> = DrugData.fetchRequest()
    let dtoDrugQuantity = DTOcoreDataDrugQuantity()
    
    func save() {
        CoreDataManager.save()
    }
    
    /// get all the drugs from the CoreData
    ///
    /// - Returns: [String] or nil if there is no drug in the CoreData
    func getAllDrugsName() -> [String]? {
        do{
            let drugsData = try CoreDataManager.context.fetch(self.request)
            var drugs : [String] = []
            for drug in drugsData {
                drugs.append(drug.name!)
            }
            return drugs
        }
        catch{
            return nil
        }
    }
    
    /// get all the drugs from the CoreData
    ///
    /// - Returns: [Drug] or nil if there is no drug in the CoreData
    func getAllDrugs() -> [Drug]? {
        do{
            let drugsData = try CoreDataManager.context.fetch(self.request)
            var drugs : [Drug] = []
            for drug in drugsData {
                let quantities = getQuantities(drug: drug.name!)
                if quantities != nil && quantities!.count > 0 {
                    drugs.append(Drug(name: drug.name!, quantities: quantities!))
                }
            }
            return drugs
        }
        catch{
            return nil
        }
    }
    
    /// Search a Drug in the CoreData
    ///
    /// - Parameter drug
    /// - Returns: true if the quantity is in the coreData
    func search(drug: String) -> Bool {
        self.request.predicate = NSPredicate(format: "name == %@", drug)
        do{
            let result = try CoreDataManager.context.fetch(request) as [DrugData]
            if result.count != 0 { return true }
            else { return false }
        }
        catch{
            print("Error during Drug search")
            return false
        }
    }
    
    /// get a Drug from the CoreData
    ///
    /// - Parameter drug, the name of the drug
    /// - Returns: DrugData if the drug with the name enter exist, nil if not.
    func getDrug(drug: String) -> DrugData? {
        self.request.predicate = NSPredicate(format: "name == %@", drug)
        do{
            let result = try CoreDataManager.context.fetch(request)
            if result.count != 0 { return result[0] }
            else { return nil }
        }
        catch{
            print("Error during Drug search")
            return nil
        }
    }
    
    /// create a drug in the CoreData, with his name and hos quantities associeted
    ///
    /// - Parameters:
    ///   - name
    ///   - quantities
    /// - Returns: true if the drug was successfully added, false if it is already present
    func createDrug(withName name: String, withQuantities quantities: [Float]) {//-> Bool {
        
        // Case 1: drug name already exist in CoreData, we don't add it
        if search(drug: name) {
            return //false
        }
            // Case 2: drug name doesn't exist, we create it.
        else {
            let drugData = DrugData(context: CoreDataManager.context)
            drugData.name = name
            
            for quantity in quantities {
                guard let quantityData = dtoDrugQuantity.getDrugQuantity(quantity: quantity) else { return }//false }
                drugData.addToQuantities(quantityData)
            }
            self.save()
            //return true
        }
    }
    
    /// create a drug in the CoreData, with his name and hos quantities associeted
    ///
    /// - Parameters:
    ///   - name
    ///   - quantities
    /// - Returns: true if the drug was successfully added, false if it is already present
    func createDrug(withName name: String, withQuantity quantity: Float) -> Bool {
        
        // Case 1: drug name already exist in CoreData, we don't add it
        if search(drug: name) {
            return false
        }
            // Case 2: drug name doesn't exist, we create it.
        else {
            let drugData = DrugData(context: CoreDataManager.context)
            drugData.name = name
            
            guard let quantityData = dtoDrugQuantity.getDrugQuantity(quantity: quantity) else {
                return false
            }
            drugData.addToQuantities(quantityData)
            
            self.save()
            return true
        }
    }
    
    /// get all the quantites associeted to a drug
    ///
    /// - Parameter drug
    /// - Returns: [Float] containing all the quantities for a drug. Nil if there isn't quantity
    func getQuantities(drug: String) -> [Float]? {
        self.request.predicate = NSPredicate(format: "name == %@", drug)
        do{
            let result = try CoreDataManager.context.fetch(request) as [DrugData]
            var quantities = [Float]()
            if result.count != 0 {
                guard let quantitiesData = result[0].quantities else { return nil }
                for quantity in quantitiesData {
                    quantities.append((quantity as! DrugQuantityData).quantity)
                }
                return quantities
            }
            else { return nil }
        }
        catch{
            print("Error during Drug search")
            return nil
        }
    }
    
    /// add multiple quantities to the drug enter in parameter.
    ///
    /// - Preconditions : The drug must already exist in the CoreData
    ///
    /// - Parameters:
    ///   - drug: the name of the drug
    ///   - quantities: the quantities associeted
    /// - Returns: true if we successfully added the quantitites to the drug, false if the drug was not found.
    func addQuantitiesToDrug(drug: String, quantities: [Float]) -> Bool {
        
        guard let drugData = getDrug(drug: drug) else{
            return false
        }
        for quantity in quantities {
            
            guard let quantityData = dtoDrugQuantity.getDrugQuantity(quantity: quantity) else { return false }
            drugData.addToQuantities(quantityData)
        }
        self.save()
        return true
    }
    
    /// add a quantity to the drug enter in parameter.
    ///
    /// - Preconditions : The drug must already exist in the CoreData
    ///
    /// - Parameters:
    ///   - drug: the name of the drug
    ///   - quantity: the quantity we wanted to add
    /// - Returns: true if we successfully added the quantitity to the drug, false if the drug was not found.
    func addQuantityToDrug(drug: String, quantity: Float) -> Bool {
        guard  let drugData = getDrug(drug: drug) else{
            return false
        }
        guard let quantityData = dtoDrugQuantity.getDrugQuantity(quantity: quantity) else {return false}
        drugData.addToQuantities(quantityData)
        self.save()
        return true
    }
    
    /// remove multiple quantities to the drug enter in parameter.
    ///
    /// - Preconditions : The drug must already exist in the CoreData
    ///
    /// - Parameters:
    ///   - drug: the name of the drug
    ///   - quantities: the quantities associeted
    /// - Returns: true if we successfully removed the quantitites to the drug, false if the drug was not found.
    func removeQuantitiesToDrug(drug: String, quantities: [Float]) -> Bool {
        
        guard  let drugData = getDrug(drug: drug) else{
            return false
        }
        for quantity in quantities {
            guard let quantityData = dtoDrugQuantity.getDrugQuantity(quantity: quantity) else { return false }
            drugData.removeFromQuantities(quantityData)
        }
        self.save()
        return true
    }
    
    /// remove a quantity to the drug enter in parameter.
    ///
    /// - Preconditions : The drug must already exist in the CoreData
    ///
    /// - Parameters:
    ///   - drug: the name of the drug
    ///   - quantity: the quantity we wanted to remove
    /// - Returns: true if we successfully removed the quantitity to the drug, false if the drug was not found.
    func removeQuantityToDrug(drug: String, quantity: Float) -> Bool {
        guard  let drugData = getDrug(drug: drug) else{
            return false
        }
        guard let quantityData = dtoDrugQuantity.getDrugQuantity(quantity: quantity) else { return false }
        drugData.removeFromQuantities(quantityData)
        self.save()
        return true
    }
    
    
    /// remove the drug from the CoreData
    ///
    /// - Parameter drug: `
    /// - Returns: <#return value description#>
    func removeAllDrugs() {
        let context = CoreDataManager.context
        // Creates a request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DrugData")
        // Creates new batch delete request with a specific request
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        // Asks to return the objectIDs deleted
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            // Executes batch
            _ = try context.execute(deleteRequest) as? NSBatchDeleteResult
            
        } catch {
            fatalError("Failed to execute request: \(error)")
        }
        
        // ------------ Ajouter la suppr du treatment en plus ----------------------------
        // -------------------------------------------------------------------------------
    }
    
    
    /// remove the drug from the CoreData
    ///
    /// - Parameter drug: <#drug description#>
    /// - Returns: <#return value description#>
    func removeDrug(drug: String) -> Bool {
        // Get the DrugData
        guard let drugToRemove = getDrug(drug: drug) else {
            return false
        }
        // Delete it
        CoreDataManager.context.delete(drugToRemove)
        self.save()
        return true
        // ------------ Ajouter la suppr du treatment en plus ----------------------------
        // -------------------------------------------------------------------------------
    }
}

