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
        
        //dto.removeAllDrugs()
        let b1 = dto.createDrug(withName: drug1.name, withQuantities: drug1.quantities)
        let b2 = dto.createDrug(withName: drug2.name, withQuantities: drug2.quantities)
        let b3 = dto.createDrug(withName: drug3.name, withQuantities: drug3.quantities)
        let b4 = dto.createDrug(withName: drug4.name, withQuantities: drug4.quantities)
        
    }
}


