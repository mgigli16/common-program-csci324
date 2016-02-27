//: Playground - noun: a place where people can play

import Cocoa

var word1 = "love"
var word2 = "live"

var stringArray: [String] = ["matt", "apple", "orange", "pear", "jt","Abby", "king", "huh", "TRUE", "Laurie", "Laurie King"]
stringArray.count

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
	while j < highIndex  {
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

//Test Cases
stringLessThan(word1, y: word2)
stringLessThan("hat", y: "hats")
stringLessThan("Matt's", y: "Matts")
stringLessThan("Matt", y: "matt")

StringQuickSort(&stringArray, low: 0, high: stringArray.count-1)
stringArray.sort()

