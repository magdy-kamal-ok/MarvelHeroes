# MarvelHeroes
#Release notes : Xcode Version : Developed in Xcode 10.0 Swift Version : Swift 4.2 Architecture : MVVM (using RxSwift)

#functionality: 
1- load list of characters
2- support load more for pagination 
3- support pull to refresh 
4- support image zoom in for movie image 
5- support offline mode, but there is no screens that give him note to that there is no 
   internet connection(the project asset does not contain any screens)
6- i used some assets from my side because the asset you sent sizes are not applicable for me
   (so i did what i can do with asset you sent).
7- only comics collection show images because the api of marvel in other collections does not work with 
    the same response
    please check this 3 apis eg.
    a. http://gateway.marvel.com/v1/public/comics/21366?apikey=2dbdf6040ce28166d7df8dd2e6577ccd&ts=0D5C8F59-83C4-4683-AAB6-41C82C0E784F&hash=11ff9794f87bd1709908c5fad13c58c6
      working fine
    b. http://gateway.marvel.com/v1/public/stories/54371?apikey=2dbdf6040ce28166d7df8dd2e6577ccd&ts=0D5C8F59-83C4-4683-AAB6-41C82C0E784F&hash=11ff9794f87bd1709908c5fad13c58c6  
    c. http://gateway.marvel.com/v1/public/series/1945?apikey=2dbdf6040ce28166d7df8dd2e6577ccd&ts=0D5C8F59-83C4-4683-AAB6-41C82C0E784F&hash=11ff9794f87bd1709908c5fad13c58c6
    (b, c) shows different response
    if the response updated to the first one the code will work fine.
