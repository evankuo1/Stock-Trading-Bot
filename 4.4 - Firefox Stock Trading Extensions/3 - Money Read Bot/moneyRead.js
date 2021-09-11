

//	A day-trading bot





// ------------- Variables ------------

	// settings
	var fast_computer = 0;
	var testing = 0;
	var test_input = 0;
	var speed_mode = 0;

	// useful random variables
	var i;					// loop iterator
	var temp;				// temporarily holds random values
	var test_i = -1;





// ------------- Main ------------

	var delay = 9000;
	if (fast_computer == 0) {
		delay = 42000;
	}
	
	setTimeout(() => console.log(getDollarAmount(read())), delay);







// ------------- Functions ------------


	// ------------- Main Functions ------------

	// gets the stock price and returns it as a double.
	function read() {


		//  vars
		var total_num = "";
		var nums = document.getElementsByClassName("css-dbaw41");


		if (test_input == 1) {
			return testInput();
		}


		total_num = total_num + nums.item(1).innerHTML;


		// remove the dollar sign
		total_num = total_num.substring(1);


		// remove commas
		total_num = total_num.replace(",", "");


		// change from string to num and return
		return parseFloat(total_num);
	}



	// determines what action should be taken.
	function process(stockPriceCurr) {

		// delete later. used for test input
		if (stockPriceCurr == -9999) {
			return [-2, 0, 0, 0];
		}

		// if NAN (when price is moving), then do nothing
		if (isNaN(stockPriceCurr)) {
			return [0, 0, 0, 0];
		}

		// if it's past 2pm, turn off pc by returning -1
		if (testing == 0) {
			var time = new Date();
			if (time.getHours() >= 13) {
				return [-1, 0, 0, 0];
			}
		}


		// adjust price
		adjustHighestLowestInit(stockPriceCurr);

		if (determineBuy(stockPriceCurr) && buyMode == true) {
			buyAll(stockPriceCurr);
			swapMode();
			return [0, sharesHeld, getDollarAmount(stockPriceCurr), getCentsAmount(stockPriceCurr)];
		}

		else if (determineSell(stockPriceCurr) && sellMode == true) {
			sellAll(stockPriceCurr)
			swapMode();
			return [1, temp, getDollarAmount(stockPriceCurr), getCentsAmount(stockPriceCurr)];
		}

		return [0, 0, 0, 0];
	}



	// prints out the order to the console.
	function order (decision) {
		if (speed_mode == 0) {
			console.clear();
			console.log(decision[0]);
			console.log(decision[1]);
			console.log(decision[2]);
			console.log(decision[3]);
		}
		else {
			if (decision[1] > 0) {
				console.log(decision);
			}
		}
	}



	// ------------- Helper Functions ------------


	// swaps from buyMode to sellMode or vice versa
	function swapMode() {

		if (buyMode == true) {
			buyMode = false;
			sellMode = true;
		}

		else {
			buyMode = true;
			sellMode = false;
		}

	}

	function testInput() {
		test_i++;
		if (test_i >= testInputArray.length) {
			return -9999;
		}
		return testInputArray[test_i];
	}


	// says if stock should be bought or not
	function determineBuy(stockPriceCurr) {

		if (priceLowest == null || priceInit == null) {
			return false;
		}

		else if (stockPriceCurr < priceInit && stockPriceCurr <= (priceInit * stockPriceMinimumDropPercent) && stockPriceCurr >= priceLowest + ((priceInit - priceLowest) * stockPriceDropComebackPercent)) {
			resetHighestLowestInit();
			priceInit = stockPriceCurr;
			return true;
		}

		else {
			return false;
		}
	}


	function determineSell(stockPriceCurr) {

		if (priceHighest == null) {
			return false;
		}

		else if (stockPriceCurr > priceInit && stockPriceCurr >= (priceInit * stockPriceMinimumRisePercent) && stockPriceCurr <= priceHighest - ((priceHighest - priceInit) * stockPriceRiseComebackPercent)) {
			resetHighestLowestInit();
			return true;
		}

		else {
			return false;
		}
	}


	function buyAll(stockPriceCurr) {
		sharesHeld = Math.floor(money / stockPriceCurr);
		money = money - (stockPriceCurr * sharesHeld);
	}


	function sellAll(stockPriceCurr) {
		temp = sharesHeld;
		sharesHeld = 0;
		money = money + (stockPriceCurr * temp);
	}

	function adjustHighestLowestInit(stockPriceCurr) {

		if (priceInit == null) {
			priceInit = stockPriceCurr;
		}

		if (priceHighest < stockPriceCurr || priceHighest == null) {
			priceHighest = stockPriceCurr;
		}

		if (priceLowest > stockPriceCurr || priceLowest == null) {
			priceLowest = stockPriceCurr;
		}
	}

	function resetHighestLowestInit() {
		priceInit = null;
		priceHighest = null;
		priceLowest = null;
	}

	function getDollarAmount(stockPriceCurr) {
		return Math.floor(stockPriceCurr);
	}

	function getCentsAmount(stockPriceCurr) {
		return Math.round((stockPriceCurr - Math.floor(stockPriceCurr)) * 100);
	}