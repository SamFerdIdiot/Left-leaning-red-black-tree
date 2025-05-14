import Foundation
func testLLRBTree() {
    let tree = LeftLeaningRedBlackTree<Int, String>()
    
    tree.insert(key: 5, value: "Пять")
    tree.insert(key: 2, value: "Два")
    tree.insert(key: 8, value: "Восемь")
    tree.insert(key: 1, value: "Один")
    tree.insert(key: 10, value: "Десять")
    tree.insert(key: 7, value: "Сем")
    tree.insert(key: 22, value: "Двадва")
    tree.insert(key: 88, value: "Восемьвосем")
    tree.insert(key: 11, value: "Одинодин")
    tree.insert(key: 33, value: "Тритри")
    
    print(tree.get(key: 5) ?? "Не найдено") // Пять
    print(tree.get(key: 2) ?? "Не найдено") // Два
    print(tree.get(key: 8) ?? "Не найдено") // Восемь
    print(tree.get(key: 10) ?? "Не найдено") // Дес
    print(tree.get(key: 22) ?? "Не найдено") // Двадва

}

testLLRBTree()

