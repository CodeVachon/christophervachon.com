component displayname="utilities" hint="I am a group of utilities" {
	public utilities function init() { return this; }


// *******************************************************************************************************
// *** FETCH FUNCTIONS
// *******************************************************************************************************
	public numeric function createTimestampFromDate(required date dateToConvert) {
		if (isDate(ARGUMENTS.dateToConvert)) {
			return dateDiff('s',createDate(1970,1,1),ARGUMENTS.dateToConvert);
		} else {
			throw("value [#ARGUMENTS.dateToConvert#] is not a valid date");
		}
	} // close createTimestampFromDate


// *******************************************************************************************************
// *** VALIDATE FUNCTIONS
// *******************************************************************************************************
	public boolean function isDateBeforeDate(required date checkDate,required date againstDate) {
		checkTimeStamp = this.createTimestampFromDate(ARGUMENTS.checkDate); // generates a timestamp
		againstTimeStamp = this.createTimestampFromDate(ARGUMENTS.againstDate); // generates a timestamp
		if (checkTimeStamp <= againstTimeStamp) {
			return true;
		} else {
			return false;
		}
	} // close isDateBeforeDate


	public boolean function isDateAfterDate(required date checkDate,required date againstDate) {
		checkTimeStamp = this.createTimestampFromDate(ARGUMENTS.checkDate); // generates a timestamp
		againstTimeStamp = this.createTimestampFromDate(ARGUMENTS.againstDate); // generates a timestamp
		if (checkTimeStamp >= againstTimeStamp) {
			return true;
		} else {
			return false;
		}
	} // close isDateAfterDate


	public boolean function isDateBetweenDateAndDate(required date checkDate,required date startDate,required date endDate) {
		if ((this.isDateAfterDate(ARGUMENTS.checkDate,ARGUMENTS.startDate)) && (this.isDateBeforeDate(ARGUMENTS.checkDate,ARGUMENTS.endDate))) {
			return true;
		} else {
			return false;
		}
	} // close isDateBetweenDateAndDat


// *******************************************************************************************************
// *** GENERAL FUNCTIONS
// *******************************************************************************************************
	public array function mergeArrays() hint="merges passed arrays into 1 returned array" {
		var returnArray = arrayNew(1);
		for (arg in ARGUMENTS) {
			if (isArray(ARGUMENTS[arg])) {
				for (key in ARGUMENTS[arg]) {
					arrayAppend(returnArray,key);
				}
			}
		}
		return returnArray;
	} // close mergeArrays


	public struct function mergeStructures() hint="merges passed structures into 1 returned structure" {
		var returnStruct = structNew();
		for (arg in ARGUMENTS) {
			if (isStruct(ARGUMENTS[arg])) {
				for (key in ARGUMENTS[arg]) {
					if (structKeyExists(returnStruct,key)) { throw("key [#key#] is defined in two or more of the passed strutures"); }
					returnStruct[key] = ARGUMENTS[arg][key];
				}
			}
		}
		return returnStruct;
	} // close mergeStructures


	public string function capitolize(required string text) hint="I capitalize the first letter of every word in the sentence giving to me" {
		return reReplaceNoCase(ARGUMENTS.text, "(\w)(\w+)", "\1\L\2\E", "all");
	} // close capitolize


	public string function formatString(required string text) hint="I help to capitalize sentences and paragraphs properly" {
		var string = trim(ARGUMENTS.text);
		string = reReplaceNoCase(string,"(\.\s{1,})",".  ","ALL");
		string = reReplaceNoCase(string,"((^\w)|(\s{2,}\w))","\U\1\E","ALL");
		return string;
	} // close formatString


	public any function converQueryToStruct(required any qry,boolean forceArray = false) {
		var columns = "";
		if (isObject(ARGUMENTS.qry)) {
			columns = ARGUMENTS.qry.getPrefix().columnList;
			ARGUMENTS.qry = ARGUMENTS.qry.getResult();
		} else {
			// if a raw query is passed in, then dig out the column names
			for (property in GetMetaData(ARGUMENTS.qry)) {
				columns = listAppend(columns,property.name);
			}
		}

		var arrayReturn = arrayNew(1);
		for (var i=1;i<=ARGUMENTS.qry.recordCount;i++) {
			var structReturn = structNew();
			for (property in listToArray(columns)) {
				structReturn[property] = trim(ARGUMENTS.qry[property][i]);
			}
			arrayAppend(arrayReturn, structReturn);
		}

		if (ARGUMENTS.forceArray) {
			return arrayReturn;
		} else {
			return ((arrayLen(arrayReturn)==1)?arrayReturn[1]:arrayReturn);
		}
	} // close converQueryToStruct


	public array function sortArrayOfStructByStructKey(required array arrayToSort, required string keyToSortBy, string sortDirection = "asc") {
		if (arrayLen(ARGUMENTS.arrayToSort) <= 1) {
			// if the array is empty or only contains 1 element, just return it
			return ARGUMENTS.arrayToSort;
		}

		if (listFindNoCase("asc,desc",ARGUMENTS.sortDirection) == 0) {
			throw("Invalid Sort Direction [#ARGUMENTS.sortDirection#] - expected [asc] || [desc]");
		}

		// we do this by turning the array into a structure keyed by the users key
		// we then sort the keylist and create a new array based on the sorted key list

		var structToSort = {};
		for (var i=1;i<=arrayLen(ARGUMENTS.arrayToSort);i++) {
			if (isStruct(ARGUMENTS.arrayToSort[i])) {
				if (structKeyExists(ARGUMENTS.arrayToSort[i],ARGUMENTS.keyToSortBy)) {
					structToSort[ARGUMENTS.arrayToSort[i][ARGUMENTS.keyToSortBy]] = ARGUMENTS.arrayToSort[i];
				} else {
					throw("not all Structures in Array elements contain Key [#ARGUMENTS.keyToSortBy#] at Array Index [#i#]");
				} // close if structKeyExists
			} else {
				throw("Array element [#i#] is not a structure");
			} // close if isStruct
		} // close for 
		var keylist = structKeyArray(structToSort);
		arraysort(keylist,"textnocase",ARGUMENTS.sortDirection);
		var returnArray = [];
		for (var key in keylist) {
			arrayAppend(returnArray,structToSort[key]);
		}
		return returnArray;
	} // close sortArrayOfStructByStructKey


	public string function fancyFileSize(required numeric bits) {
		var fileSizes = {
			bits = ARGUMENTS.bits & " bits",
			kb = NumberFormat((ARGUMENTS.bits/1024),"0.99"),
			mb = NumberFormat(((ARGUMENTS.bits/1024)/1024),"0.99")
		};

		if (fileSizes.mb > 1) {
			return fileSizes.mb & " mb";
		} else if (fileSizes.kb > 1) {
			return fileSizes.kb & " kb";
		} else {
			return fileSizes.bits & " b";
		}
	} // close fancyFileSize
}