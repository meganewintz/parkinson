//
//  ManageDrugs.swift
//  parkinson
//
//  Created by Thierry WINTZ on 25/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData

// A drug must have at least one quantity
class Drug {
    let name        : String
    let quantities  : [Float]
    
    
    init(name: String, quantities: [Float]) {
        self.name = name
        self.quantities = quantities
    }
    
    init(name: String, quantity: Float) {
        self.name = name
        self.quantities = [quantity]
    }
    
}

class DrugsManager {
    private var pset : [Drug]
    let dto = DTOcoreDataDrug()
    
    init() {
        self.pset = []
    }
    
    init(drugs: [Drug]) {
        self.pset = drugs
    }
    
    init(drug: Drug) {
        self.pset = [drug]
    }
    
    func displayDrugs() {
        let names = dto.getAllDrugsName()
        guard let drugs = self.dto.getAllDrugs() else {
            return
        }
        for drug in drugs {
            for quant in drug.quantities {
                print (drug.name, " : ", quant)
            }
        }
    }
    
    func addDrugs() {
        let drug1 = Drug(name: "MODOPAR", quantities: [62.5,125,250])
        let drug2 = Drug(name: "MODOPAR LP", quantity: 125)
        let drug4 = Drug(name: "SINEMET", quantities: [100,125])
        let drug3 = Drug(name: "MODOPAR DISPERSIBLE", quantity: 125)
        
        
        var drugs = [Drug]()
        drugs.append(drug1)
        drugs.append(drug2)
        drugs.append(drug3)
        drugs.append(drug4)
        
        dto.createDrug(withName: drug1.name, withQuantities: drug1.quantities)
        dto.createDrug(withName: drug2.name, withQuantities: drug2.quantities)
        dto.createDrug(withName: drug3.name, withQuantities: drug3.quantities)
        dto.createDrug(withName: drug4.name, withQuantities: drug4.quantities)
        dto.createDrug(withName: "SINEMET LP", withQuantities: [100, 200])
        dto.createDrug(withName: "STALEVO", withQuantities: [50, 75, 100, 125, 150, 175, 200])
        dto.createDrug(withName: "PARLODEL", withQuantities: [2.5, 5, 10])
        dto.createDrug(withName: "TRIVASTAL", withQuantities: [20])
        dto.createDrug(withName: "TRIVASTAL LP", withQuantities: [50])
        dto.createDrug(withName: "SIFROL", withQuantities: [0.18, 0.7])
        dto.createDrug(withName: "SIFROL LP", withQuantities: [0.26, 0.52, 1.05, 2.1])
        dto.createDrug(withName: "REQUIP", withQuantities: [0.25, 0.5, 1, 2, 5])
        dto.createDrug(withName: "REQUIP SP", withQuantities: [2, 4, 8])
        dto.createDrug(withName: "NEUROPRO (PATCH)", withQuantities: [2, 4, 6, 8])
        dto.createDrug(withName: "MANTADIX", withQuantities: [100])
        dto.createDrug(withName: "ALZILECT", withQuantities: [1])
        dto.createDrug(withName: "COMTAN", withQuantities: [200])
        dto.createDrug(withName: "ARTANE", withQuantities: [2, 5])
        dto.createDrug(withName: "PARKINANE LP", withQuantities: [2, 5])
        dto.createDrug(withName: "LEPTICUR", withQuantities: [10])
        dto.createDrug(withName: "LEPONEX", withQuantities: [25, 100])
        dto.createDrug(withName: "EXELON", withQuantities: [1.5, 3, 4.5, 6])
        dto.createDrug(withName: "EXELON (PATCH)", withQuantities: [4.6, 9.5])
    }
}


