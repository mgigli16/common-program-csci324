//
//  common.swift
//  
//
//  Created by JT Kearney on 2/25/16.
//
//

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
	if(FindInDictionary(dict, wordToFind: wordToAdd, verbose:false)){
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
// Searches the dictionary that is parameterized for a word that is also parameterized. 
// Prints an appropriate outcome
func FindInDictionary(dict: WordDictionary, wordToFind: String, verbose: Bool) -> Bool {
	var newKey = "";
	if(wordToFind.characters.count > 0){
		newKey.append(wordToFind[wordToFind.startIndex]); // first letter
		if(wordToFind.characters.count >= 2){
			newKey.append(wordToFind[wordToFind.startIndex.successor()]); // second letter
		}
		
		// If the key already exists check the list, otherwise it cant exist in the dictionary 
		// so return false
		if dict[newKey] != nil {
			for element in dict[newKey]!{
				if element == wordToFind{
					if verbose { print("We have found \(wordToFind) in the dictionary")}
					return true
				}
			}
		}
	}
	if verbose {print("\(wordToFind) was not found in the dictionary")}
	return false
}

// BuildDictionary
// Builds a dictionary from ONE string
func BuildDictionary(documentString: String) -> WordDictionary {
	let stringList = documentString.characters.split{$0 == "\r\n"}.map(String.init);
	var newDict: WordDictionary = [:]
	for element in stringList{
		AddToDictionary(&newDict, wordToAdd: element )
	}
	return newDict
}

// DictionaryToString
// Converts Dictionary into a string and then writes it to a file
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
		
		// If a value was returned, print it.
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



/********************************************
         PROGRAM IMPLEMENTATION
********************************************/

var argArray = Process.arguments
if argArray.count < 2 {
	print("Need to include a file name in the program line")
	print("It should look something like this:")
	print("\n\tswift common.swift infilename outfilename\n")
	exit(0)
}
// Take a file name as a command line argument?
// argArray is the command line arguments
// argArray = ["common.swift", arg1, arg2, arg3, ...]
var longString = ReadFile(argArray[1])
print("Reading \(argArray[1]) and building the program dictionary")
var myDictionary = BuildDictionary(longString)
print("Dictionary Built")

/* Interactive stuff
var keepGoing = true;

while keepGoing {
	print("Which word would you like to search for?")
	var searchWord = input().stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
	if !FindInDictionary(myDictionary, word: searchWord){
		print("Would you like to add \(searchWord)?")
		var choice = input().stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
		if(choice == "yes" || choice == "y"){
			AddToDictionary(&myDictionary, word: searchWord)
		}
	}
	print("Would you like to search again?")
	var choice = input().stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
	if(choice != "yes" && choice != "y"){
		keepGoing = false;
	}
}
*/

// TEST CASES
FindInDictionary(myDictionary, wordToFind: "Matt", verbose: true)
FindInDictionary(myDictionary, wordToFind: "JT", verbose: true)
AddToDictionary(&myDictionary, wordToAdd: "JT")

print("Re-writing dictionary to \(argArray[2])")
DictionaryToString(myDictionary, writeToPath: argArray[2])


