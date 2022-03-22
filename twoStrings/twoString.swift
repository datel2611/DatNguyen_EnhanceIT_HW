import Swift


func twoStrings(s1: String, s2: String) -> String {
    
    for char1 in s1{
        for char2 in s2{
            if(char1 == char2){
                return "YES"
                }
        }
    }
    return "NO"
}

//test

print(twoStrings(s1: "hello",s2: "world"))
print(twoStrings(s1: "hi",s2: "world"))

