// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Introduction
//													jumpTo Introduction

//	A day-trading bot




// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Notes/Tips
//													jumpTo Notes/Tips




// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Variables/Settings
//													jumpTo Variables/Settings

	// settings
	let SETTING_FASTCOMPUTER = 0;
	let SETTING_TESTING = 0;
	let SETTING_TESTINPUT = 0;
	let SETTING_SPEEDMODE = 0;

	let SETTING_NOTRADES = 0;
	let SETTING_NOBUY = 0;
	let SETTING_NOSELL = 0;


	// delays
	let DELAY_START = Delay_FastSlow(48000, 172500);
	let DELAY_EACHLOOP = 22550; 


	// stock rise/drop and price
	let STOCK_DROP_MIN = 0.993;
	let STOCK_DROP_COMEBACK = 0.3;		// this is 20% of the drop, not the total.
	let STOCK_RISE_MIN = 1.002;
	let STOCK_RISE_COMEBACK = 0.15;		// this is 20% of the drop, not the total.

	let STOCK_PRICE_INIT = null;
	let STOCK_PRICE_CURR = null;
	let STOCK_PRICE_HIGHEST = null;
	let STOCK_PRICE_LOWEST = null;
	let STOCK_PRICE_BUYPRICE = null;
	let STOCK_PRICE_RECENT = [];
	let STOCK_PRICE_RECENT_MAXLENGTH = 100;


	// buying or selling stock
	let POSITION_BUYING = 0;
	let POSITION_SELLING = 0;
	let AMOUNT_MONEY = 0;
	let AMOUNT_DAYTRADES = 0;
	let AMOUNT_SHARESHELD = 0;


	let PRINT_FINISHED = 0;


	let STRATEGY = 2;


	// useful random variables
	let i;					// loop iterator
	let temp;				// temporarily holds random values
	let test_i = -1;
	let testInputArray = [60.56, 60.49, NaN, 60.21, NaN, 60.25, 60.15, 60.25, NaN, 60.16, 60.12, 60.17, 60.14, 60.14, 60.14, 60.11, 60.06, NaN, NaN, 60.05, 60.03, 60.05, 60.05, 60.1, 60.15, 60.18, 60.16, 60.1, 60.14, NaN, 60.05, NaN, 60.06, NaN, 60.13, 60.22, 60.23, NaN, 60.22, 60.24, 60.21, 60.28, NaN, NaN, 60.22, 60.15, 60.08, NaN, NaN, 60.14, 60.17, 60.17, 60.16, 60.18, 60.2, 60.23, 60.17, 60.09, 60.06, 60.05, NaN, 60.09, 60.06, 60.07, 60.03, 60.03, 60.05, 60.07, 60.01, 60, 59.92, 59.94, 59.95, 59.98, 59.94, 59.96, 59.93, 59.99, 59.98, NaN, 59.89, 59.89, 59.94, 59.93, 59.91, 59.94, 59.92, 59.95, 59.97, 60.02, 60.04, 60.05, 60.06, 60.11, NaN, 60.1, 60.12, 60.16, 60.18, 60.19, 60.2, 60.14, 60.08, 60.07, 60.13, 60.12, 60.15, NaN, 60.16, 60.14, 60.13, 60.13, 60.14, 60.12, 60.12, 60.14, 60.13, 60.16, 60.17, 60.19, 60.2, 60.21, 60.22, 60.22, 60.22, 60.22, 60.26, 60.25, 60.2, 60.18, 60.17, 60.18, 60.16, 60.15, 60.16, 60.16, 60.17, 60.15, 60.15, 60.14, 60.14, 60.11, 60.14, 60.09, NaN, 60.05, 60.07, NaN, 60.06, 60.04, 60.03, 60.06, 60.07, 60.07, 60.07, 60.06, 60.05, 60.02, 60.02, NaN, NaN, NaN, 59.97, 59.98, 59.95, 59.94, NaN, 59.94, 59.94, 59.97, NaN, NaN, 59.95, 59.95, 59.95, 59.95, 59.98, 59.94, 59.96, 59.97, 59.94, 59.89, 59.87, NaN, 59.85, 59.88, 59.88, 59.89, 59.92, 59.89, 59.91, NaN, 59.91, NaN, 59.92, 59.93, 59.93, 59.92, 59.95, 59.95, 59.94, NaN, 59.96, 59.96, 59.95, 59.96, 59.97, 60, NaN, 60.03, 60.04, 60.02, 60.04, 60.08, 60.1, 60.11, NaN, 60.1, 60.09, 60.09, 60.11, NaN, 60.03, 60.03, 60.04, 60.05, 60.09, 60.07, 60.06, 60.06, 60.01, 60.01, 59.99, NaN, 60, 59.99, 60.02, 60.02, 60.01, 59.98, 59.99, 59.97, 59.95, 59.95, 59.95, NaN, 59.97, NaN, 59.97, 59.93, 59.94, 59.91, 59.91, 59.91, 59.88, 59.9, 59.9, 59.94, 59.93, NaN, 59.9, 59.93, 59.95, 59.96, NaN, 59.91, 59.93, 59.99, 59.97, NaN, 59.96, 59.96, 59.92, 59.93, 59.88, 59.88, 59.89, 59.85, 59.86, 59.82, NaN, 59.84, 59.88, 59.89, 59.88, 59.88, NaN, 59.84, 59.84, 59.86, 59.86, 59.86, 59.89, 59.88, 59.89, 59.89, 59.89, 59.88, 59.87, 59.87, 59.88, 59.87, 59.86, 59.86, 59.88, 59.87, 59.89, 59.91, 59.92, 59.93, 59.93, 59.94, 59.95, 59.94, 59.94, 59.94, 59.95, 59.95, 59.96, 59.96, 59.95, 59.94, 59.95, 59.95, NaN, 59.95, 59.93, 59.93, 59.92, 59.93, 59.94, 59.95, 59.93, 59.92, 59.93, 59.93, 59.9, 59.92, NaN, 59.9, 59.94, 59.93, 59.94, 59.94, 59.95, 59.95, 59.94, 59.95, 59.93, 59.94, 59.94, 59.91, 59.9, 59.91, 59.92, 59.9, 59.87, 59.82, 59.79, 59.8, NaN, 59.84, 59.84, 59.84, 59.86, 59.85, 59.87, 59.87, 59.87, 59.88, 59.89, 59.88, NaN, NaN, 59.86, 59.86, 59.86, 59.88, 59.92, 59.91, 59.91, NaN, 59.91, 59.89, 59.89, 59.88, 59.9, 59.89, 59.91, 59.91, 59.9, 59.9, 59.89, 59.89, 59.9, 59.89, 59.89, 59.86, 59.86, 59.86, 59.84, 59.84, 59.84, 59.82, 59.86, 59.87, 59.86, 59.85, 59.86, 59.85, 59.86, 59.86, NaN, 59.9, 59.91, 59.91, 59.94, 59.94, 59.96, 59.96, 59.95, 59.96, 59.96, 59.95, 59.95, 59.97, 59.97, 59.98, 59.98, 60.01, 60.03, 60.03, 60.01, 60.02, 60.04, 60.02, 60.04, 60.02, 60.05, 60.06, 60.07, 60.08, 60.08, 60.09, 60.09, 60.11, 60.09, NaN, 60.11, 60.14, 60.16, 60.14, 60.13, 60.13, 60.11, 60.11, 60.22, NaN, 60.17, 60.16, 60.1, 60.13, 60.1, NaN, 60.08, 60.08, 60.06, 60.05, 60.07, 60.07, 60.08, 60.07, 60.08, 60.07, 60.09, 60.09, 60.09, 60.09, 60.09, 60.07, NaN, NaN, 59.97, 60.01, 60.01, 60.03, 60.03, NaN, 60, 59.99, 59.99, 60, 59.97, 59.98, 59.99, 59.98, 59.95, 59.95, 59.95, 59.94, 59.93, 59.93, 59.93, 59.9, 59.94, 59.91, NaN, 59.92, 59.93, 59.91, NaN, 59.9, 59.91, 59.91, 59.89, 59.9, 59.9, 59.89, 59.88, 59.88, 59.88, 59.88, 59.85, 59.86, 59.86, 59.86, 59.88, 59.89, 59.9, 59.89, 59.91, 59.9, 59.9, 59.88, 59.89, 59.89, 59.9, 59.91, 59.94, 59.93, 59.92, 59.95, 59.96, NaN, 59.98, 59.98, 59.97, 59.96, 59.95, 59.92, NaN, 59.94, 59.95, 59.97, 59.95, 59.94, 59.96, 59.93, 59.95, NaN, 59.94, 59.95, 59.94, 59.95, 59.93, 59.93, NaN, 59.88, 59.89, 59.88, 59.87, NaN, 59.88, 59.87, 59.87, 59.87, 59.88, 59.9, 59.93, 59.92, 59.91, 59.91, 59.91, 59.93, 59.93, 59.93, 59.92, 59.92, 59.91, 59.93, 59.92, 59.95, 59.97, NaN, 59.94, 59.94, 59.94, 59.95, 59.93, 59.94, 59.96, 59.96, 59.99, NaN, 59.95, 59.96, NaN, NaN, 59.98, NaN, 59.96, NaN, 60, 60.02, 60.03, 60.01, 60.05, 60.05, 60.08, 60.06, 60.06, 60.04, 60.04, 60.05, 60.06, 60.06, 60.05, 60.06, 60.05, 60.07, 60.1, 60.11, 60.11, 60.11, 60.13, 60.15, 60.15, 60.15, 60.14, 60.12, 60.14, 60.12, 60.1, 60.12, 60.12, 60.11, 60.12, 60.15, 60.12, 60.15, 60.17, 60.19, 60.16, 60.17, 60.17, 60.2, NaN, 60.19, 60.2, 60.17, NaN, NaN, NaN, 60.2, 60.2, 60.2, 60.19, 60.19, 60.18, NaN, 60.15, 60.12, NaN, 60.1, 60.11, NaN, 60.1, 60.13, 60.13, 60.1, 60.12, 60.11, 60.15, 60.16, 60.15, 60.17, 60.16, 60.16, 60.18, 60.18, 60.18, 60.2, 60.18, 60.19, 60.18, 60.15, 60.14, 60.14, 60.13, 60.15, 60.14, 60.13, 60.12, 60.15, 60.17, 60.17, 60.19, 60.21, 60.21, 60.2, 60.16, 60.17, 60.19, NaN, NaN, NaN, 60.15, 60.15, 60.15, 60.16, 60.16, 60.15, 60.16, 60.14, 60.14, 60.16, 60.2, 60.19, 60.19, NaN, 60.17, NaN, 60.15, 60.17, 60.17, 60.18, 60.17, 60.18, 60.18, NaN, 60.18, 60.17, 60.18, 60.17, 60.13, 60.15, 60.14, 60.17, NaN, 60.17, 60.19, 60.19, 60.19, 60.2, 60.18, 60.21, 60.22, 60.19, 60.18, 60.21, 60.21, 60.2, 60.2, 60.22, 60.22, 60.23, 60.21, NaN, NaN, 60.18, 60.14, 60.15, 60.18, 60.17, 60.16, 60.14, 60.16, NaN, 60.16, 60.19, 60.18, 60.2, NaN, 60.18, 60.17, 60.16, 60.17, 60.19, 60.18, 60.16, 60.16, 60.16, 60.15, 60.16, 60.17, 60.16, 60.17, 60.18, 60.18, 60.18, 60.18, 60.19, NaN, NaN, 60.16, 60.15, 60.13, 60.15, 60.14, 60.15, 60.15, 60.17, 60.18, 60.16, 60.19, 60.2, 60.19, 60.2, 60.21, 60.22, NaN, 60.24, NaN, 60.24, 60.23, 60.25, NaN, NaN, NaN, 60.29, 60.28, 60.28, 60.31, NaN, NaN, 60.29, 60.29, 60.27, 60.24, 60.23, NaN, 60.22, NaN, NaN, 60.15, 60.14, 60.15, 60.17, 60.19, 60.15, NaN, 60.11, 60.05];
	let OPEN_HOURS = 6;
	let OPEN_MINUTES = 30;
	let CLOSE_HOURS = 13;
	if (SETTING_TESTING == 1) {
		OPEN_HOURS = 0;
		OPEN_MINUTES = 0;
		CLOSE_HOURS = 24;
	}





// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Main
//													jumpTo Main


	
	Vars_Position_Set();


	Vars_Amount_Set();


	Main_Loop()
	





// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Functions List
//													jumpTo Functions List

	// ------- Main Functions ------- 

		// Vars_Amount_Set
		// Main_Loop




	// ------- Helper Functions ------- 


		// --- main loop ---
		// ML_Normal
		// ML_Fast

		// --- one loop --- 
		// OL_Loop
		// OL_Read
		// OL_Process
		// OL_Order

		// --- vars ---
		// Vars_Amount_Read
		// Vars_StockPrice_Adjust
		// Vars_StockPrice_Reset
		// Vars_Position_Swap
		// Vars_Position_Set
		// Vars_AverageCost_Read
		// Vars_Position_Read
		// Vars_SharesHeld_Read

		// --- calculate something --- 
		// Determine_Sell
		// Determine_Buy
		// Determine_MarketClosed
		// Determine_SharesAreHeld

		// --- testing --- 
		// Test_TestInput
		// Test_SpeedPrinting

		// Order_Buy				
		// Order_Sell
		// Order_Create
		// Order_Print


		// --- other --- 
		// Delay_FastSlow
		// Price_Dollar_Get
		// Price_Cents_Get
		// Vars_AverageCost_Read




	// ------- Local Functions ------- 


		// get_stock_price
		// no_day_trades
		// vars_not_set
		// price_lower_than_init
		// price_dropped_enough
		// price_recovered_enough
		// get_searchbar_values
		// set_init
		// set_highest
		// set_lowest
		// reset_buy_vars
		// reset_sell_vars




// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Main Functions
//													jumpTo Main Functions

	// Sets delay for Vars_Amount_Read which reads from RH's searchbar to get values.
	// jumpTo Vars_Amount_Set
	function Vars_Amount_Set() {
		let delay = DELAY_START;
		setTimeout(() => Vars_Amount_Read(), (delay - 1000));
	}


	// Repeating orders
	// jumpTo Main_Loop
	function Main_Loop() {

		if (SETTING_SPEEDMODE == 0) {
			ML_Normal();
		}

		else {
			ML_Fast();
		}
	}





// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Helper Functions
//													jumpTo Helper Functions


// ------------------------------------------------------------------------------

	// jumpTo Determine_MarketOpen
	function Determine_MarketOpen() {

		let time = new Date();


		if (time.getHours() >= 14) {
			return false;
		}


		if (time.getHours() < OPEN_HOURS) {
			return false;
		}


		else if (time.getHours() > OPEN_HOURS) {
			return true;
		}


		else {
			if (time.getMinutes() >= OPEN_MINUTES) {
				return true;
			}
		}


		return false;

	}



// ------------------------------------------------------------------------------


	// not done. got bored
	function Determine_Hill() {

		let highest = 0;
		let highestIndex = 0;
		let lowest = 9999999;
		let lowestIndex = 0;
		let slope = 0;


		if (STOCK_PRICE_RECENT.length < 15) {
			return false;
		}


		for (i = 0; i < STOCK_PRICE_RECENT.length; i++) {

			if (STOCK_PRICE_RECENT[i] > highest) {
				highest = STOCK_PRICE_RECENT[i];
				highestIndex = i;
			}

			if (STOCK_PRICE_RECENT[i] < lowest) {
				lowest = STOCK_PRICE_RECENT[i];
				lowestIndex = i;
			}
		}

		if (highestIndex < lowestIndex) {
			return false;
		}


		slope = Math.abs(  (highest - lowest) /  (highestIndex - lowestIndex) )


		return false;
	}




// ------------------------------------------------------------------------------



	function Determine_Valley() {


		let highest = 0;
		let highestIndex = 0;
		let lowest = 9999999;
		let lowestIndex = 0;
		let dropPercent = 0;
		let risePercent = 0;
		let goingUp = false;


		
		if (STOCK_PRICE_RECENT.length < 3) {
			return false;
		}


		for (i = 0; i < STOCK_PRICE_RECENT.length; i++) {

			if (STOCK_PRICE_RECENT[i] > highest) {
				highest = STOCK_PRICE_RECENT[i];
				highestIndex = i;
			}

			if (STOCK_PRICE_RECENT[i] < lowest) {
				lowest = STOCK_PRICE_RECENT[i];
				lowestIndex = i;
			}
		}


		dropPercent = lowest / highest;
		risePercent = (STOCK_PRICE_RECENT[STOCK_PRICE_RECENT.length - 1] - lowest) / (highest - lowest) 
		goingUp = (STOCK_PRICE_RECENT[STOCK_PRICE_RECENT.length - 3] - lowest) / (highest - lowest) 


		if (lowestIndex < highestIndex) {
			return false;
		}


		if (dropPercent <= STOCK_DROP_MIN && risePercent >= STOCK_DROP_COMEBACK && goingUp <= STOCK_DROP_COMEBACK) {
			return true;
		}


		return false;

	}




// ------------------------------------------------------------------------------


	function Strategy_1_Buy() {


		if (vars_not_set()) {
			return false;
		}

		else if (price_lower_than_init() && price_dropped_enough() && price_recovered_enough()) {
			return true;
		}

		return false;

	}





// ------------------------------------------------------------------------------


	function Strategy_1_Sell() {

		if (vars_not_set()) {
			return false;
		}

		else if (STOCK_PRICE_CURR > STOCK_PRICE_BUYPRICE && STOCK_PRICE_CURR >= (STOCK_PRICE_BUYPRICE * STOCK_RISE_MIN) && STOCK_PRICE_CURR <= STOCK_PRICE_HIGHEST - ((STOCK_PRICE_HIGHEST - STOCK_PRICE_BUYPRICE) * STOCK_RISE_COMEBACK)) {
			return true;
		}

		return false;
	}





// ------------------------------------------------------------------------------


	function Strategy_2_Buy() {

		if (Determine_Valley()) {
			return true;
		}

		return false;
	}




// ------------------------------------------------------------------------------

	// the same as strategy 1 at the moment
	function Strategy_2_Sell() {

		if (vars_not_set()) {
			return false;
		}

		else if (STOCK_PRICE_CURR >= (STOCK_PRICE_BUYPRICE * STOCK_RISE_MIN) && STOCK_PRICE_CURR <= STOCK_PRICE_HIGHEST - ((STOCK_PRICE_HIGHEST - STOCK_PRICE_BUYPRICE) * STOCK_RISE_COMEBACK)){
			return true;
		}

		return false;
	}


// ------------------------------------------------------------------------------

	function Vars_Position_Set() {
		let delay = DELAY_START;
		setTimeout(() => Vars_Position_Read(), (delay - 1000));
	}




// ------------------------------------------------------------------------------

	function Vars_Position_Read() {

		if (!Determine_SharesAreHeld()) {
			POSITION_BUYING = 1;
			POSITION_SELLING = 0;
		}

		else {
			POSITION_BUYING = 0;
			POSITION_SELLING = 1;
			AMOUNT_SHARESHELD = Vars_SharesHeld_Read();
			STOCK_PRICE_BUYPRICE = Vars_AverageCost_Read();
		}
	}


// ------------------------------------------------------------------------------

	function Vars_AverageCost_Read() {

		let num = document.getElementsByClassName("css-1wyk9uc");
		num = num.item(1).innerText
		num = num.substring(1);
		return parseFloat(num);


	}




// ------------------------------------------------------------------------------

	function Vars_SharesHeld_Read() {

		let num = document.getElementsByClassName("table");
		num = num.item(1);
		num = num.getElementsByTagName("td")[2].innerText;
		return parseFloat(num);

	}




// ------------------------------------------------------------------------------

	function Determine_SharesAreHeld() {

		if (document.getElementsByClassName("css-1wyk9uc").length > 0) {
			return true;
		}

		return false;
	}

// ------------------------------------------------------------------------------

	// gets the stock price and returns it as a double.
	// jumpTo OL_Read
	function OL_Read() {

		if (SETTING_TESTINPUT == 1) { 
			return Test_TestInput();
		}

		let stockPrice = get_stock_price();
		stockPrice = stockPrice.substring(1);
		return parseFloat(stockPrice);
	}




// ------------------------------------------------------------------------------

	// determines what action should be taken.
	// jumpTo OL_Process
	function OL_Process(stockPriceCurr) {

		STOCK_PRICE_CURR = stockPriceCurr;
		

		// if it's past 2pm, turn off pc by returning -1
		if (SETTING_TESTING == 0) {


			if (Determine_MarketClosed()) {

				if (PRINT_FINISHED == 0) {
					PRINT_FINISHED = 1;
				}

				return Order_Create("saveAndExit");

			}


			if (!Determine_MarketOpen()) {
				return Order_Create("nothing")
			}
		}

		// if NAN (when price is moving), then do nothing
		if (isNaN(STOCK_PRICE_CURR)) {
			return Order_Create("nothing");
		}


		// adjust price
		Vars_StockPrice_Adjust();


		if (Determine_Buy() && POSITION_BUYING == 1 && SETTING_NOTRADES == 0 && SETTING_NOBUY == 0) {
			Order_Buy();
			reset_buy_vars();
			return [0, AMOUNT_SHARESHELD, Price_Dollar_Get(), Price_Cents_Get()];
		}


		else if (Determine_Sell() && POSITION_SELLING == 1 && SETTING_NOTRADES == 0 && SETTING_NOSELL == 0) {
			let sharesBought = AMOUNT_SHARESHELD;
			Order_Sell();
			reset_sell_vars()
			return [1, sharesBought, Price_Dollar_Get(), Price_Cents_Get()];
		}


		return Order_Create("nothing");
	}





// ------------------------------------------------------------------------------

	// prints out the order to the console.
	// jumpTo OL_Order
	function OL_Order(decision) {

		if (SETTING_SPEEDMODE == 1) {
			if (decision[1] > 0) {
				console.log(decision);
				return;
			}
			return;
		}

		if (PRINT_FINISHED == 0 || PRINT_FINISHED == 1) {
			Order_Print(decision);
		}

		if (PRINT_FINISHED == 1) {
			PRINT_FINISHED = -1;
		}
		
	}




// ------------------------------------------------------------------------------

	// swaps from POSITION_BUYING to POSITION_SELLING or vice versa
	// jumpTo Vars_Position_Swap
	function Vars_Position_Swap() {

		if (POSITION_BUYING == 1) {
			POSITION_BUYING = 0;
			POSITION_SELLING = 1;
		}

		else {
			POSITION_BUYING = 1;
			POSITION_SELLING = 0;
		}

	}




// ------------------------------------------------------------------------------

	// jumpTo Test_TestInput
	function Test_TestInput() {

		test_i++;

		if (test_i >= testInputArray.length) {
			return -9999;
		}

		return testInputArray[test_i];
	}




// ------------------------------------------------------------------------------

	// says if stock should be bought or not
	// jumpTo Determine_Buy
	function Determine_Buy() {

		if (no_day_trades()) {
			return false;
		}

		if (STRATEGY == 1) {
			return Strategy_1_Buy();
		}

		else if (STRATEGY == 2) {
			return Strategy_2_Buy();
		}


		return false;
	}




// ------------------------------------------------------------------------------

	// jumpTo Determine_Sell
	function Determine_Sell() {

		if (STRATEGY == 1) {
			return Strategy_1_Sell();
		}

		else if (STRATEGY == 2) {
			return Strategy_2_Sell();
		}

		return false;
	}




// ------------------------------------------------------------------------------

	// jumpTo Order_Buy
	function Order_Buy() {
		AMOUNT_SHARESHELD = Math.floor(AMOUNT_MONEY / STOCK_PRICE_CURR);
		AMOUNT_MONEY = AMOUNT_MONEY - (STOCK_PRICE_CURR * AMOUNT_SHARESHELD);
	}




// ------------------------------------------------------------------------------

	// jumpTo Order_Sell
	function Order_Sell() {
		temp = AMOUNT_SHARESHELD;
		AMOUNT_SHARESHELD = 0;
		AMOUNT_MONEY = AMOUNT_MONEY + (STOCK_PRICE_CURR * temp);
	}




// ------------------------------------------------------------------------------

	// jumpTo Vars_StockPrice_Adjust
	function Vars_StockPrice_Adjust() {

		set_init();

		set_highest();

		set_lowest();

		STOCK_PRICE_RECENT.push(STOCK_PRICE_CURR);
		if (STOCK_PRICE_RECENT.length > STOCK_PRICE_RECENT_MAXLENGTH) {
			STOCK_PRICE_RECENT.shift();
		}
	}




// ------------------------------------------------------------------------------

	// jumpTo Vars_StockPrice_Reset
	function Vars_StockPrice_Reset() {
		STOCK_PRICE_INIT = null;
		STOCK_PRICE_HIGHEST = null;
		STOCK_PRICE_LOWEST = null;
		STOCK_PRICE_BUYPRICE = null;
		STOCK_PRICE_RECENT = [];
	}




// ------------------------------------------------------------------------------

	// jumpTo Price_Dollar_Get
	function Price_Dollar_Get() {
		return Math.floor(STOCK_PRICE_CURR);
	}




// ------------------------------------------------------------------------------

	// jumpTo Price_Cents_Get
	function Price_Cents_Get() {
		return Math.round((STOCK_PRICE_CURR - Math.floor(STOCK_PRICE_CURR)) * 100);
	}




// ------------------------------------------------------------------------------

	// gets the stock price and returns it as a double.
	// jumpTo Vars_Amount_Read
	function Vars_Amount_Read() {

		let amounts = get_searchbar_values();

		AMOUNT_MONEY = amounts[0];
		AMOUNT_DAYTRADES = amounts[1];

		// because robinhood wants u to have 5% more than your order
		AMOUNT_MONEY = AMOUNT_MONEY * 0.95;
	}




// ------------------------------------------------------------------------------

	// jumpTo Test_SpeedPrinting
	function Test_SpeedPrinting() {

		let delay = 1000;
		let delayIncrease = 1000;




		if (STRATEGY != 2) {
			for (i = 0; i < testInputArray.length; i++) {
				OL_Loop();
			}
		}


		else {
			for (i = 0; i < testInputArray.length; i++) {
				setTimeout(() => OL_Loop(), delay);
				delay = delay + delayIncrease;
			}
		}


		setTimeout(() => console.log("order complete"), delay);
		setTimeout(() => console.log("money is:" + AMOUNT_MONEY), delay);
		setTimeout(() => console.log("dayTrades: " + AMOUNT_DAYTRADES), delay);
	}




// ------------------------------------------------------------------------------

	// jumpTo Delay_FastSlow
	function Delay_FastSlow(fastSpeed, slowSpeed) {

		let delay = fastSpeed;

		if (SETTING_FASTCOMPUTER == 0) {
			delay = slowSpeed;
		}

		return delay;
	}




// ------------------------------------------------------------------------------

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




// ------------------------------------------------------------------------------


	// jumpTo Order_Print
	function Order_Print(decision) {
		console.clear();
		console.log(decision[0]);
		console.log(decision[1]);
		console.log(decision[2]);
		console.log(decision[3]);
	}




// ------------------------------------------------------------------------------

	// jumpTo Order_Create
	function Order_Create(type) {

		if (type == "saveAndExit") {
			return [-1, 0, 0, 0];
		}

		if (type == "nothing") {
			return [0, 0, 0, 0];
		}
	}




// ------------------------------------------------------------------------------

	// jumpTo ML_Normal
	function ML_Normal() {

		let delay = DELAY_START;

		for (i = 0; i < 2200; i++) {
			setTimeout(() => OL_Loop(), delay);
			delay = delay + DELAY_EACHLOOP;
		}
	}




// ------------------------------------------------------------------------------

	// jumpTo ML_Fast
	function ML_Fast() {
		let delay = DELAY_START;
		SETTING_TESTING = 1;
		SETTING_TESTINPUT = 1;
		setTimeout(() => Test_SpeedPrinting(), delay);
	}




// ------------------------------------------------------------------------------ 

	// jumpTo OL_Loop
	function OL_Loop() {

		OL_Order(OL_Process(OL_Read()));
	}






// *************************************************************************************************************************// *************************************************************************************************************************
//  *************************************************************************************************************************
//													Local Functions
//													jumpTo Local Functions




// ------------------------------------------------------------------------------

	// jumpTo get_stock_price
	function get_stock_price() {

		//  vars
		let stockPrice = "";
		let stockPriceDigits = document.getElementsByClassName("T_ocKK8QpgJxwxluz95GC up css-1baulvz");

		// loop through the price and add it to a string
		for (i = 0; i < stockPriceDigits.length; i++) {
			stockPrice = stockPrice + stockPriceDigits.item(i).innerHTML;
		}

		return stockPrice;
	}





// ------------------------------------------------------------------------------
	
	// jumpTo set_lowest
	function set_lowest() {
		if (STOCK_PRICE_LOWEST > STOCK_PRICE_CURR || STOCK_PRICE_LOWEST == null) {
			STOCK_PRICE_LOWEST = STOCK_PRICE_CURR;
		}
	}





// ------------------------------------------------------------------------------ 
	
	// jumpTo get_searchbar_values
	function get_searchbar_values() {
		let nums = document.getElementById("downshift-0-input");
		nums = nums.value;
		return nums.split(" ");
	}




// ------------------------------------------------------------------------------

	// jumpTo set_init
	function set_init() {
		if (STOCK_PRICE_INIT == null) {
			STOCK_PRICE_INIT = STOCK_PRICE_CURR;
		}
	}




// ------------------------------------------------------------------------------

	// jumpTo set_highest
	function set_highest() {
		if (STOCK_PRICE_HIGHEST < STOCK_PRICE_CURR || STOCK_PRICE_HIGHEST == null) {
			STOCK_PRICE_HIGHEST = STOCK_PRICE_CURR;
		}
	}





// ------------------------------------------------------------------------------

	// jumpTo no_day_trades
	function no_day_trades() {


		if (AMOUNT_DAYTRADES <= 0) {
			return true;
		}


		return false;


	}




// ------------------------------------------------------------------------------

	// jumpTo vars_not_set
	function vars_not_set() {

		if (STOCK_PRICE_LOWEST == null || STOCK_PRICE_INIT == null || STOCK_PRICE_HIGHEST == null) {
			return true;
		}

		return false;
	}
	



// ------------------------------------------------------------------------------

	// jumpTo price_lower_than_init
	function price_lower_than_init() {
		if (STOCK_PRICE_CURR < STOCK_PRICE_INIT) {
			return true;
		}
		return false;
	}




// ------------------------------------------------------------------------------

	// jumpTo price_dropped_enough
	function price_dropped_enough() {
		if (STOCK_PRICE_CURR <= (STOCK_PRICE_INIT * STOCK_DROP_MIN)) {
			return true;
		}

		return false;
	}




// ------------------------------------------------------------------------------

	// jumpTo price_recovered_enough
	function price_recovered_enough() {

		if (STOCK_PRICE_CURR >= STOCK_PRICE_LOWEST + ((STOCK_PRICE_INIT - STOCK_PRICE_LOWEST) * STOCK_DROP_COMEBACK)) {
			return true;
		}

		return false;
	}




// ------------------------------------------------------------------------------ 

	// jumpTo reset_buy_vars
	function reset_buy_vars() {
		Vars_Position_Swap();
		Vars_StockPrice_Reset();
		STOCK_PRICE_BUYPRICE = STOCK_PRICE_CURR;
	}




// ------------------------------------------------------------------------------ 

	// jumpTo reset_sell_vars
	function reset_sell_vars() {
		Vars_Position_Swap();
		Vars_StockPrice_Reset();
		AMOUNT_DAYTRADES = AMOUNT_DAYTRADES - 1;
	}


