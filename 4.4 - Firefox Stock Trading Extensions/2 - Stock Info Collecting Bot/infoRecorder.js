//  *************************************************************************************************************************
//  *************************************************************************************************************************
//  *************************************************************************************************************************
//											Introduction

	//	Collects data on stock prices





//  *************************************************************************************************************************
//  *************************************************************************************************************************
//  *************************************************************************************************************************
//											Variables


	// settings
	let fast_computer = 0;
	let testing = 0;
	let max_num_loops = 10;
	let curr_loop = 0;

	let i;
	let holderArray = [];
	let arrayPrintedAlready = 0;

	// delay
	let delay = 32000; 
	if (fast_computer == 0) { 
		delay = 172500;
	}
	let delayAmount = 22550; 

	
	// time
	let startTime = 6;
	let startMinutes = 30;
	let endTime = 13;
	if (testing == 1) {
		startTime = 0;
		startMinutes = 0;
		endTime = 24;
	}
	


//  *************************************************************************************************************************
//  *************************************************************************************************************************
//  *************************************************************************************************************************
//											Main

	for (i = 0; i < 2200; i++) {
		setTimeout(() => addData(), delay);
		delay = delay + delayAmount;
	}
	





//  *************************************************************************************************************************
//  *************************************************************************************************************************
//  *************************************************************************************************************************
//											Functions


	function Determine_PastOpeningTime() {


		let time = new Date();


		if (time.getHours() < startTime) {
			return false;
		}


		else if (time.getHours() > startTime) {
			return true;
		}


		else {
			if (time.getMinutes() >= startMinutes) {
				return true;
			}
		}


		return false;


	}



	// jumpTo Determine_MarketClosed
	function Determine_MarketClosed() {
		let time = new Date();
		if ((time.getHours() >= 13 && time.getMinutes() <= 15) && time.getHours() < 14) {
			return true;
		}

		else {
			return false;
		}
	}




	// gets the stock price and returns it as a double.
	function read() {

		//  vars
		let total_num = "";
		let nums = document.getElementsByClassName("T_ocKK8QpgJxwxluz95GC up css-1baulvz");

		// loop through the price and add it to a string
		for (i = 0; i < nums.length; i++) {
			total_num = total_num + nums.item(i).innerHTML;
		}

		// remove the dollar sign
		total_num = total_num.substring(1);

		// change from string to num and return
		return parseFloat(total_num);
	}

// ------------------------------------------------------------------------------------------------

	function addData() {

		let time = new Date();
	
		if (Determine_PastOpeningTime() && time.getHours() < endTime) {
			holderArray.push(read());
		}

		else if (Determine_MarketClosed()) {
			if (arrayPrintedAlready == 0) {
				setTimeout(() => printData(), 90000);
				arrayPrintedAlready = 1;
			}
		}

		if (testing == 1 && curr_loop >= max_num_loops && arrayPrintedAlready == 0) {
			printData();
			arrayPrintedAlready = 1;
		}

		curr_loop++;
	}




// ------------------------------------------------------------------------------------------------

	function printData() {
		console.clear();
		let printString = "[";
		for (i = 0; i < holderArray.length; i++) {
			if (i < holderArray.length - 1) {
				printString = printString + holderArray[i] + ", ";
			}
			else {
				printString = printString + holderArray[i];
			}
		}
		printString = printString + "]";
		console.log(printString);
	}





// ------------------------------------------------------------------------------------------------

	function determineTimeout() {

		let totalTimeout = 0;
		let time = new Date();

		if (time.getHours() >= endTime) {
			totalTimeout = totalTimeout + (23 - time.getHours()) * 3600;
			totalTimeout = totalTimeout + (60 - time.getMinutes()) * 60;
			totalTimeout = totalTimeout + (3600 * endTime);
		}

		else {
			totalTimeout = totalTimeout + (12 - time.getHours()) * 3600;
			totalTimeout = totalTimeout + (60 - time.getMinutes()) * 60;
		}

		return totalTimeout;
	}
