//: Playground - noun: a place where people can play

import Cocoa
import Foundation

var str = "Hello, playground"


var fileString:String = "This is a test of the misspelling program we are riting for computer science 324, programming languages. We are especially testing for punctuation and other spleling mistakes. I wonder what will happen if I hit enter\r\nright here? Does that mess up the splits? Who kknows."

var splitSet = NSCharacterSet(charactersInString: " \r\n")
let stringList3 = fileString.componentsSeparatedByCharactersInSet(splitSet)
stringList3

var realFileArray = ["This", "is", "","a", "test", "of", "the", "misspelling", "program", "we", "are", "riting", "for", "computer", "science", "324", "", "programming", "languages", "", "We", "are", "especially", "testing", "for", "punctuation", "and", "other", "spleling", "mistakes", "", "I", "wonder", "what", "will", "happen", "if", "I", "hit", "enter", "right", "here", "", "Does", "that", "mess", "up", "the", "splits", "", "Who", "kknows", "", ""]

var i = 0
while i < realFileArray.count{
	if realFileArray[i] == "" {
		realFileArray.removeAtIndex(i)
	}
	i++
}
realFileArray