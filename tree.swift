//  Left Leaning Red-Black BSTs
//
//  Created by Денисов Семён  on 13.05.2025.
//
enum Color {
    case black
    case red
}

class Node<Key: Comparable, Value> {
    var key: Key
    var value: Value
    var left: Node?
    var right: Node?
    var color: Color

    init(key: Key, value: Value, color: Color) {
        self.key = key
        self.value = value
        self.color = color
    }
}

public class LeftLeaningRedBlackTree<Key: Comparable, Value> {
    private var root: Node<Key, Value>?

    public init() {}

    // MARK: - Public

    public func insert(key: Key, value: Value) {
        root = insert(node: root, key: key, value: value)
        root?.color = .black
    }

    public func get(key: Key) -> Value? {
        return get(node: root, key: key)
    }

    public func delete(key: Key) {
        if root == nil { return }
        if !isRed(root?.left) && !isRed(root?.right) {
            root?.color = .red
        }
        root = delete(node: root, key: key)
        root?.color = .black
    }
// MARK: private
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
        return x
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
        h.left?.color = .black
        h.right?.color = .black
    }

    private func insert(node: Node<Key, Value>?, key: Key, value: Value) -> Node<Key, Value> {
        guard var h = node else {
            return Node(key: key, value: value, color: .red)
        }

        if key < h.key {
            h.left = insert(node: h.left, key: key, value: value)
        } else if key > h.key {
            h.right = insert(node: h.right, key: key, value: value)
        } else {
            h.value = value
        }

        if isRed(h.right) && !isRed(h.left) {
            h = rotateLeft(h)
        }
        if isRed(h.left) && isRed(h.left?.left) {
            h = rotateRight(h)
        }
        if isRed(h.left) && isRed(h.right) {
            flipColors(h)
        }

        return h
    }

    private func get(node: Node<Key, Value>?, key: Key) -> Value? {
        guard let node = node else { return nil }

        if key < node.key {
            return get(node: node.left, key: key)
        } else if key > node.key {
            return get(node: node.right, key: key)
        } else {
            return node.value
        }
    }

    private func delete(node h: Node<Key, Value>?, key: Key) -> Node<Key, Value>? {
        guard var h = h else { return nil }

        if key < h.key {
            if !isRed(h.left) && !isRed(h.left?.left) {
                h = moveRedLeft(h)
            }
            h.left = delete(node: h.left, key: key)
        } else {
            if isRed(h.left) {
                h = rotateRight(h)
            }
            if key == h.key && h.right == nil {
                return nil
            }
            if !isRed(h.right) && !isRed(h.right?.left) {
                h = moveRedRight(h)
            }
            if key == h.key {
                if let minNode = min(h.right) {
                    h.key = minNode.key
                    h.value = minNode.value
                    h.right = deleteMin(h.right)
                }
            } else {
                h.right = delete(node: h.right, key: key)
            }
        }

        return fixUp(h)
    }

    private func moveRedLeft(_ h: Node<Key, Value>) -> Node<Key, Value> {
        var h = h
        flipColors(h)
        if isRed(h.right?.left) {
            if let right = h.right {
                h.right = rotateRight(right)
            }
            h = rotateLeft(h)
            flipColors(h)
        }
        return h
    }

    private func moveRedRight(_ h: Node<Key, Value>) -> Node<Key, Value> {
        var h = h
        flipColors(h)
        if isRed(h.left?.left) {
            h = rotateRight(h)
            flipColors(h)
        }
        return h
    }

    private func fixUp(_ h: Node<Key, Value>) -> Node<Key, Value> {
        var h = h
        if isRed(h.right) && !isRed(h.left) {
            h = rotateLeft(h)
        }
        if isRed(h.left) && isRed(h.left?.left) {
            h = rotateRight(h)
        }
        if isRed(h.left) && isRed(h.right) {
            flipColors(h)
        }
        return h
    }

    private func deleteMin(_ node: Node<Key, Value>?) -> Node<Key, Value>? {
        guard var h = node else { return nil }
        if h.left == nil {
            return nil
        }
        if !isRed(h.left) && !isRed(h.left?.left) {
            h = moveRedLeft(h)
        }
        h.left = deleteMin(h.left)
        return fixUp(h)
    }

    private func min(_ node: Node<Key, Value>?) -> Node<Key, Value>? {
        var current = node
        while let next = current?.left {
            current = next
        }
        return current
    }
}


