import Swift


func match( n: Int, socks: [Int]) -> Int {
    var pairs = 0
    var s = Set<Int>()
    //var count = 0
    for sock in 0...(n-1){
        let color = socks[sock]
        if s.contains(color){
            s.remove(color)
            pairs += 1
        } else{
            s.insert(color)
        }
        //count += 1
    }
    //print("\(count)")
    return pairs
}

//test
print(match(n:9,socks: [10, 20, 20, 10, 10, 30, 50, 10, 20]))
print(match(n:10,socks: [1, 1, 3, 1, 2, 1, 3, 3, 3, 3]))
