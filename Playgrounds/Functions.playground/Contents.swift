import UIKit

func myFunction(){
    print("my function")
}

myFunction()


func sumFunction(x: Int, y: Int){
    print(x+y)
}

func sumFunction2(x: Int, y: Int) -> Bool {
    if x > y {
        return true
    }else{
        return false
    }
}


sumFunction2(x: 3, y: 5)
sumFunction(x: 3, y: 5)
