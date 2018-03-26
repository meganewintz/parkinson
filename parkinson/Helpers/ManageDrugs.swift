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

class DrugSet {
    private var pset : [Drug]
    
    init(drugs: [Drug]) {
        self.pset = drugs
    }
    
    init(drug: Drug) {
        self.pset = [drug]
    }
    
    func displayDrugs() {
        let dao = DTOcoreDataDrug()
        guard let drugs = dao.getAllDrugs() else {
            return
        }
        for drug in drugs {
            for quant in drug.quantities {
                print (drug.name, " : ", quant)
            }
        }
    }
    
    func addDrugs() {
        
    }
}


