import Foundation

extension Array {
    
    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
        }
    }
    
    private func comparingBy<C : Comparable>(value: Element -> C, compare: (C, C) -> Bool) -> Element? {
        if isEmpty { return nil }
        var (r, vr) = (first!, value(first!))
        for e in self {
            let ve = value(e)
            if compare(ve, vr) {
                (r, vr) = (e, ve)
            }
        }
        
        return r
    }
    
    /// 
    /// Returns the tail of this array
    ///
    var tail: [Element] {
        if self.isEmpty { return [] }
        return Array(self[1..<count])
    }
    
    ///
    /// Returns the first element as array of one element
    ///
    var firsts: [Element] {
        if self.isEmpty { return [] }
        return [self[0]]
    }
    
    ///
    /// fold left
    ///
    func foldLeft<B>(zero: B, f: (Element, B) -> B) -> B {
        var result = zero
        for x in self {
            result = f(x, result)
        }
        return result
    }

    ///
    /// Return minimum element by applying ``value`` to each element to determine
    /// its comparable value
    ///
    func minBy<C : Comparable>(value: Element -> C) -> Element? {
        return comparingBy(value) { $0 < $1 }
    }
    
    ///
    /// Returns the maximum element by applying ``value`` to each element to determine
    /// its comparable value
    ///
    func maxBy<C : Comparable>(value: Element -> C) -> Element? {
        return comparingBy(value) { $0 > $1 }
    }
    
    ///
    /// Returns the index of the first element that satisfies ``predicate``
    ///
    func indexOf(predicate: Element -> Bool) -> Int? {
        for (i, e) in enumerate(self) {
            if predicate(e) { return i }
        }
        return nil
    }
    
    
    ///
    /// Finds the first element that satisfies ``predicate``
    ///
    func find(predicate: Element -> Bool) -> Element? {
        for e in self {
            if predicate(e) { return e }
        }
        
        return nil
    }
    
    ///
    /// Apply the function ``f`` to every element
    ///
    func foreach(f: Element -> Void) -> Void {
        for e in self { f(e) }
    }
    
    ///
    /// Returns ``true`` if ``predicate`` evaluates to ``true`` for all elements.
    ///
    func forall(predicate: Element -> Bool) -> Bool {
        for e in self {
            if !predicate(e) { return false }
        }
        
        return true
    }
    
    ///
    /// Returns ``true`` if the ``predicate`` evalues to ``true`` for at least
    /// one element in this array
    ///
    func exists(predicate: Element -> Bool) -> Bool {
        return find(predicate) != nil
    }
    
    ///
    /// Constructs a new array, which contains the original elements
    /// tupled with their index.
    ///
    func zipWithIndex() -> [(Int, Element)] {
        var r: [(Int, Element)] = []
        for i in 0..<self.count {
            r += [(i, self[i])]
        }
        return r
    }
    
}