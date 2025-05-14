//  Left Leaning Red-Black BSTs
//
//  Created by Денисов Семён  on 13.05.2025.
//
enum Color {
    case black
    case red
}
class Node < Key : Comparable, Value > {
    let key: Key
    var value: Value
    var left: Node?
    var right: Node?
    var color: Color
    
    init(key: Key, value: Value, color: Color) {
        self.key   = key
        self.value = value
        self.color = color
        self.left  = nil
        self.right = nil
    }
}
public class LeftLeaningRedBlackTree < Key : Comparable, Value > {
    private var root: Node<Key, Value>?
    
    
    public func insert(key: Key, value: Value) {
        root = insert(node: root, key: key, value: value)
        root?.color = .black
    }
    private func insert(node:  Node<Key, Value>? , key: Key, value: Value) -> Node<Key, Value> {
        /*# Рекурсивная вставка
         if key < h.key:
         h.left = insert(h.left, key, value)
         elif key > h.key:
         h.right = insert(h.right, key, value)
         else:
         h.value = value  # Обновление значения*/
        guard let h = node else {
            return Node(key: key, value: value, color: .red)
        }
        if key < h.key {
            h.left = insert(node: h.left, key: key, value: value)
        }
        else if key > h.key {
            h.right = insert(node: h.right, key: key, value: value)
        }
        else {
            h.value = value
        }
        /* # Балансировка:
         if isRed(h.right) and not isRed(h.left):
         h = rotateLeft(h)
         if isRed(h.left) and isRed(h.left.left):
         h = rotateRight(h)
         if isRed(h.left) and isRed(h.right):
         flipColors(h)
         
         return h */
        return h
    }
    
    public func get(key: Key) -> Value? {
        return get(node: root, key: key)
    }
    private func get(node: Node<Key, Value>?, key: Key) -> Value? {
        guard let node = node else { return nil }
        if (key < node.key) {
            return get(node: node.left, key: key)
        }
        else if (key > node.key) {
            return get(node: node.right, key: key)
        }
        else {
            return node.value
        }
    }
    private func isRed(_ node: Node<Key, Value>?) -> Bool {
        guard let node = node else { return false }
        return node.color == .red
    }
    
    private func rotateLeft(_ h: Node<Key, Value>) -> Node<Key, Value> {
        let x = h.right!
        h.right = x.left
        x.left = h
        x.color = h.color
        h.color = .red
        return h
    }
    
    private func rotateRight(_ h: Node<Key, Value>) -> Node<Key, Value> {
        let x = h.left!
        h.left = x.right
        x.right = h
        x.color = h.color
        h.color = .red
        return x
    }
    
    private func flipColors(_ h: Node<Key, Value>) {
        h.color = .red
        h.left?.color  = .black
        h.right?.color = .black
    }
}
    

