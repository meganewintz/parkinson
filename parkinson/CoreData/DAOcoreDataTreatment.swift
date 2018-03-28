//
//  DAOcoreDataTreatment.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData

class DAOcoreDataTreatment: DAOtreatmentProtocol {
    
    let context             = CoreDataManager.context
    let request             : NSFetchRequest<TreatmentData> = TreatmentData.fetchRequest()
    let dtoDrugData         = DTOcoreDataDrug()
    let dtoDrugQuantityData = DTOcoreDataDrugQuantity()
    let dtoQuantityHourData = DTOcoreDataQuantityHour()
    
    func save(){
        CoreDataManager.save()
    }
    
    
    // -------------------------------------------------------------------------
    // MARK: - Methods from DAOtreatmentProtocol -
    
    func getTreatments(patient : Patient) -> [Treatment]? {
        
        let treatments: [TreatmentData] = []
        var treatmentSet: [Treatment] = []
        
        // Execute Request
        //        do {
        //            try treatments = context.fetch(self.request)
        //            var dailyDoses: [DailyDose]
        //            for t in treatments{
        //                dailyDoses = getDailyDoses(patient: patient, treatment: t)
        //
        //                treatmentSet.append(Treatment(name: (t.drug?.name!)!, quantity: (t.quantity?.quantity)!, dailyDoses: dailyDoses, endDate: t.endDate!))
        //            }
        //        }
        //        catch let error as NSError {
        //            print (error, error.userInfo)
        //            return nil
        //        }
        return treatmentSet
    }
    
    func addTreatment(patient : Patient, treatment: Treatment) -> Bool {
        // Case 1: treatment with the same drug and quantity already exist in CoreData for this patient, we can't add a new treatment
        if search(withDrug: treatment.name, andQuantity: treatment.quantity) {
            return false
        }
            // Case 2: we can add it
        else {
            let treatmentData = TreatmentData(context: CoreDataManager.context)
            // add endDate
            treatmentData.endDate = treatment.endDate
            
            // add drugName
            guard let drug = dtoDrugData.getDrug(drug: treatment.name) else {
                return false
            }
            treatmentData.drug = drug
            
            // add drugQuantity
//            guard let drugQuantity = dtoDrugQuantityData.getDrugQuantity(quantity: treatment.quantity) else {
//                return false
//            }
//            treatmentData.quantity = drugQuantity
            
            //add dailyDoses
            for freq in treatment.dailyDoses {
                var quantityHourData: QuantityHourData?
                // if the frequency already exist in coreData
                quantityHourData = dtoQuantityHourData.search(quantity: freq.quantity, hour: freq.dailyPeriod)
                if quantityHourData != nil {
                    treatmentData.addToQuantityhours(quantityHourData!)
                }
                    
                    // if the frequency doesn't exist, we need to create it.
                else {
                    quantityHourData = QuantityHourData(context: context)
                    quantityHourData!.quantity = Int16(freq.quantity)
                    quantityHourData!.hour = freq.dailyPeriod
                    treatmentData.addToQuantityhours(quantityHourData!)
                }
            }
            self.save()
            return true
        }
    }
    
    func updateTreatment(patient : Patient, old: Treatment, new: Treatment) -> Bool {
        return false
    }
    
    func removeTreatment(patient : Patient, treatment: Treatment) -> Bool {
        // Get the TreatmentData
        let treatmentToRemove = getTreatmentData(withDrugName: treatment.name)
        
        if treatmentToRemove == nil {
            return false
        }
        
        // Delete the treatment from TreatmentData
        CoreDataManager.context.delete(treatmentToRemove!)
        self.save()
        return true
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Utilities -
    
    /// Give a treatment from the CoreData with a specific name and return an TreatmentData
    ///
    /// - Parameter name: name of the treatment
    /// - Returns: TreatmentData or nil if no treatment correspond to the drugName
    func getTreatmentData(withDrugName drugName: String) -> TreatmentData? {
        
        // Get the drugData corresponding to the name
        guard let drugData = dtoDrugData.getDrug(drug: drugName) else {
            return nil
        }
        
        // Add Predicate
        let predicate = NSPredicate(format: "drug == %@", drugData)
        request.predicate = predicate
        
        // Execute Request
        do {
            let result = try context.fetch(request)
            guard result.count != 0 else {
                return nil
            }
            return result[0]
        }
        catch let error as NSError {
            print (error, error.userInfo)
            return nil
        }
    }
    
    func search(withDrug drugName: String, andQuantity quantity: Float) -> Bool {
        guard let drugData = dtoDrugData.getDrug(drug: drugName) else {
            return false
        }
        guard let drugQuantityData = dtoDrugQuantityData.getDrugQuantity(quantity: quantity) else {
            return false
        }
        self.request.predicate = NSPredicate(format: "drug == %@ AND quantity == %@", drugData, drugQuantityData)
        
        do{
            let result = try CoreDataManager.context.fetch(request) as [TreatmentData]
            if result.count != 0 { return true }
            else { return false }
        }
        catch{
            print("Error during Treatment search")
            return false
        }
    }
    
    func removeAllTreatments() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TreatmentData")
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
    func getDailyDoses(patient: Patient, treatment: TreatmentData) -> [DailyDose]{
        var dailydoses  : [DailyDose] = []
        var dosesData   = treatment.quantityhours!.allObjects // array [Any]
        var doseData   : QuantityHourData
        
        if dosesData.count > 0 {
            for i in 0...dosesData.count-1{
                doseData = dosesData[i] as! QuantityHourData //cast any to QuantityHourData
                dailydoses.append(DailyDose(dailyPeriod: doseData.hour!, quantity: Int(doseData.quantity)))
            }
        }
        return dailydoses
    }
}

