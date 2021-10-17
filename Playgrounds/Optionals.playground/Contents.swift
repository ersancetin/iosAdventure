import UIKit

//optionals

var myName : String? = "ersan"

myName?.uppercased()

// ? or !

var myAge = "1"

var myInteger = (Int(myAge) ?? 0 ) * 5

if let myNumber = Int(myAge){
    print(myNumber * 5)
}else{
    print("wrong input")
}

// ?? sonucunda varsayılan default değer işliyor kullanıcı hatalı değer girerse
// if let de ise kullanıcıya bir hata mesajı döndürebiliyoruz



