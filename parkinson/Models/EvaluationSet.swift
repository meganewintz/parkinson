//
//  EvaluationSet.swift
//  parkinson
//
//  Created by Florent BERLAND on 16/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class EvaluationSet {
    
    private var evaluations : [Evaluation]
    private var delegates : [EvaluationSetDelegate]
    
    
    init() {
        evaluations = [Evaluation]()
        delegates = [EvaluationSetDelegate]()
    }
    
    
    /// add
    @discardableResult
    func addEvaluation(evaluation : Evaluation) -> EvaluationSet {
        evaluations.append(evaluation)
        for d in delegates {
            d.evaluationAdded(at : self.count-1)
        }
        return self
    }
    
    
    /// update
    @discardableResult
    func updateEvaluation(old : Evaluation, new : Evaluation) -> EvaluationSet {
        if let index = evaluations.index(where : { $0 === old }) {
            evaluations[index] = new
            for d in delegates {
                d.evaluationUpdated(at : index)
            }
        }
        return self
    }
    
    
    /// delete
    @discardableResult
    func removeEvaluation(evaluation : Evaluation) -> EvaluationSet {
        if let index = evaluations.index(where : { $0 === evaluation }) {
            evaluations.remove(at : index)
            for d in delegates {
                d.evaluationRemoved(at : index)
            }
        }
        return self
    }
    
    
    /// count
    public var count : Int {
        return evaluations.count
    }
    
    
    /// contains
    func contains(evaluation : Evaluation) -> Bool {
        return evaluations.contains(where : {$0 === evaluation })
    }
    
    
    /// addDelegate
    @discardableResult
    func addDelegate(delegate : EvaluationSetDelegate) -> EvaluationSet {
        if !delegates.contains(where : {$0 === delegate }){
            delegates.append(delegate)
        }
        return self
    }
    
    
    /// removeDelegate
    @discardableResult
    func removeDelegate(delegate : EvaluationSetDelegate) -> EvaluationSet {
        if let index = delegates.index(where : { $0 === delegate }){
            delegates.remove(at : index)
        }
        return self
    }
}
