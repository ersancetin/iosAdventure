import UIKit

var myFavoriteMovies = ["Pulp Fiction", "Film2", "Film3", true, 11] as [Any]

myFavoriteMovies[0]
myFavoriteMovies[1]
myFavoriteMovies[2]
myFavoriteMovies[3]
myFavoriteMovies[4]


var testList = ["Test", "Test2", "Test3"]

testList[0].uppercased()

testList[testList.count - 1]

//listenin son elemanını çağırdık bu sayede

testList.last

testList.sort()

// Set

var mySet : Set = [1,2,3,4,5]

//index olayı yok, sıralı dizilmiyor
//sırasız koleksiyonlar da deniliyor

var mySet2 : Set = [0,7,8,9,2,3,4]

var mySet3 = mySet.union(mySet2)

//Dictionary
//key value pairing

var myFavoriteDirectors = ["Pulp Fiction" : "Tarantino", "Lock Stock" : "Guy Ritchie"]

myFavoriteDirectors["Pulp Fiction"]
myFavoriteDirectors["Lock Stock"] = "Quentin Tarantino"

myFavoriteDirectors["Seven Samurai"] = "Akira Kurisowa"

var myDictionary = ["Run" : 100, "Swim" : 200, "Basketball" : 300 ]

myDictionary["Run"]

//internetten veri çekerken çok kullanacağız

