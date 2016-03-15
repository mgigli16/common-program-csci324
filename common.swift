//
//  common.swift
//
//  Abby Oliver, Matt Gigliotti, and JT Kearney
// 
//  This program implements a spell checker for a file that the
//  user provides on the command line.

import Foundation

typealias StringArray = [String];
typealias WordDictionary = Dictionary<String, StringArray>;

// AddToDictionary
// Adds a word to the parameterized dictionary
// inout is pass by reference
func AddToDictionary(inout dict: WordDictionary ,wordToAdd: String) {
	
	// Take the word, and the first two letters of the word into a string
	var newKey = "";
	
	// Search to make sure the entry is not a duplicate
	if(FindInDictionary(dict, wordToFind: wordToAdd, verbose:false, caseCheck: false)){
		return
	}
	
	// Add it to the dictionary
	if(wordToAdd.characters.count > 0){
		newKey.append(wordToAdd[wordToAdd.startIndex]); // first letter
		if(wordToAdd.characters.count >= 2){
			newKey.append(wordToAdd[wordToAdd.startIndex.successor()]); // second letter
		}
		
		// Add it to the dictionary if its not there
		if let _ = dict[newKey] {
			dict[newKey]?.append(wordToAdd);
		} else {
			dict[newKey] = [wordToAdd];
		}
	}
	
}

// FindInDictionary
// Searches the dictionary dict for the string wordToFind and returns true if
// the word is found and false otherwise. There are two flags, one for printing
// output if the word is found (verbose) and one for checking the word for
// a match despite bizarre capitalization (caseCheck).
func FindInDictionary(dict: WordDictionary, var wordToFind: String, verbose: Bool, caseCheck: Bool) -> Bool {
	var iter = 1
	if caseCheck {
		iter = 3
	}
	var i = 0
	while i < iter {
		var newKey = "";
		if i == 1 { wordToFind = wordToFind.uppercaseString }
		if i == 2 { wordToFind = wordToFind.lowercaseString }
		if(wordToFind.characters.count > 0){
			newKey.append(wordToFind[wordToFind.startIndex]); // first letter
			if(wordToFind.characters.count >= 2){
				newKey.append(wordToFind[wordToFind.startIndex.successor()]); // second letter
			}
			
			// If the key already exists check the list, otherwise it cant exist in the dictionary
			// so return false
			if dict[newKey] != nil {
				for element in dict[newKey]!{
					var elementCheck = element;
					if i == 1 { elementCheck = element.uppercaseString }
					if i == 2 { elementCheck = element.lowercaseString }
					if elementCheck == wordToFind{
						return true
					}
				}
			}
		}
		if verbose {
			print("\(wordToFind) was not found in the dictionary")
		}
		i++
	}
	return false
}

// BuildDictionary
// Builds a dictionary from a single string that is passed from the ReadFile function
// and splits the string on the new line in order to pick out the words. Calls 
// AddToDIctionary for each word in the string.
func BuildDictionary(documentString: String) -> WordDictionary {
	let stringList = documentString.characters.split{$0 == "\r\n"}.map(String.init);
	var newDict: WordDictionary = [:]
	for element in stringList{
		AddToDictionary(&newDict, wordToAdd: element )
	}
	return newDict
}

// DictionaryToString
// Converts the current data structure with added words to a string to be exported to the
// dictionary txt file.
func DictionaryToString(dict: WordDictionary, writeToPath: String){
	var beWritten = "";
	for currentKey in dict.keys.sort() {
		var arrayString = ""
		for item in dict[currentKey]!.sort(){
			arrayString += item + "\r\n"
		}
		beWritten += arrayString
	}
	WriteFile(writeToPath, toWrite: beWritten)
}

// From http://stackoverflow.com/questions/24004776/input-from-the-keyboard-in-command-line-application
// This function handles keyboard input from the user.
func input() -> String {
	let keyboard = NSFileHandle.fileHandleWithStandardInput()
	let inputData = keyboard.availableData
	return NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
}

// http://www.dotnetperls.com/file-swift
// The next two functions were found and modified from the above link to 
// read and write to/from files
func ReadFile(path:String) -> String {
	let data = ""
	do {
		let data = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding)
		
		// return the string from the file
		return data as String
	} catch {
		print ("Error reading from file")
	}
	return data
}

func WriteFile(path:String, toWrite:String){
	
	// Write the text to the path.
	do{
		try toWrite.writeToFile(path,
			atomically: true,
			encoding: NSASCIIStringEncoding)
		print("Successfully written to the file \(path).")
	}
	catch{
		print("Failed to write to \(path).")
	}
}

// String quicksort functions

func StringQuickSort (inout A: [String], low: Int, high: Int) {
	if low < high {
		let p = QuickSortPartition(&A, lowIndex:low, highIndex: high)
		let oldHigh = high
		let oldLow = low
		StringQuickSort(&A, low:oldLow, high:p-1)
		StringQuickSort(&A, low: p+1, high: oldHigh)
	}
}

func QuickSortPartition(inout A: [String], lowIndex: Int, highIndex: Int) -> Int {
	let pivot = A[highIndex]
	var i = lowIndex
	var j = lowIndex
	while j < highIndex {
		if A[j] < pivot || A[j] == pivot{
			let temp = A[i]
			A[i] = A[j]
			A[j] = temp
			i = i+1
		}
		j++
	}
	let temp = A[i]
	A[i] = A[highIndex]
	A[highIndex] = temp
	return i
}

//returns true if x is less than y
func stringLessThan (let x: String, let y: String) -> Bool {
	let shortLength = min(x.characters.count, y.characters.count)
	var i = 0
	while (i < shortLength) {
		if(x[x.startIndex.advancedBy(i)] < y[y.startIndex.advancedBy(i)]) {
			return true;
		}
		i++ //increment counter
	}
	//check for strings of same word beginning but different lengths
	if( x.characters.count < y.characters.count) {
		return true
	}
	return false
}

// End String Quicksort functions

/********************************************
         PROGRAM IMPLEMENTATION
********************************************/

var argArray = Process.arguments
if argArray.count < 2 {
	print("Need to include a file name in the program line")
	print("It should look something like this:")
	print("\n\tswift common.swift TextFile\n")
	exit(0)
}
// Take a file name as a command line argument?
// argArray is the command line arguments
// argArray = ["common.swift", arg1, arg2, arg3, ...]


// Read in from dicitonary.txt
var longString = ReadFile("dictionary.txt")
print("Reading dictionary.txt and building the program dictionary")
var myDictionary = BuildDictionary(longString)
print("Dictionary Built")

// Read the parameterized file and put each word in an array
var fileToBeRead = ReadFile(argArray[1]);
var splitSet = NSCharacterSet(charactersInString: " \t\r\n!?.,-\"():;")
var stringList = fileToBeRead.componentsSeparatedByCharactersInSet(splitSet)
print("Size of the array created for the file is \(stringList.count)")

// Get rid of items in the list that are null ("")
var i = 0
while i < stringList.count{
	if stringList[i] == "" {
		stringList.removeAtIndex(i)
	} else {
		i++
	}
}

// Search for each word from the file in the dicitonary
var misspelledWords = [String]()
for element in stringList {
	if !FindInDictionary(myDictionary, wordToFind: element, verbose:false, caseCheck: true) {
		if(!misspelledWords.contains(element)){
			misspelledWords.append(element)
		}
	}
}

// After each word has been compared sort the array and print out the misspelled words
StringQuickSort(&misspelledWords, low: 0, high: misspelledWords.count-1)

// Show which misspelled words were found
switch misspelledWords.count {
case 0: print("We didn't find any misspelled words in the text file.")
	break
case 1: print("We found 1 misspelled word in the text file.")
	break
default: print("We found \(misspelledWords.count) misspelled words:")
}

// Print the list of misspelled words
i = 0;
for word in misspelledWords{
	print("\t[\(i+1)]", word)
	i++
}

if misspelledWords.count != 0{
	print("Would you like to add anything to the dictionary? Please type yes if so.")
	var choice = input().stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
	if(choice == "yes"){
		// Print out the array one by one asking the user if they'd like to add it to the dictionary
		for word in misspelledWords{
			print("Would you like to add \"\(word)\" to the dictionary? If so please type yes.")
			var choice = input().stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
			if(choice == "yes"){
				AddToDictionary(&myDictionary, wordToAdd: word)
				print("\"\(word)\" was added to the dictionary")
			}
		}
	}
}

// Rewrite the program dictionary from memory back over dictionary.txt
print("Re-writing dictionary to dictionary.txt")
DictionaryToString(myDictionary, writeToPath: "dictionary.txt")
print("Have a nice day! 😝")


