
	var fast_computer = 0;

// ------------- Main ------------

	var delay = 9000;
	if (fast_computer == 0) {
		delay = 42000;
	}
	setTimeout(() => console.log(readDayTrades()), delay);





// ------------- Functions List ------------


	// returns the number of day trades left
	function readDayTrades() {

		var dayTrades = document.getElementsByClassName("_2fMdia82KwWc0JSyKE7Dd- Fsbdezy_6qyEtz271V0uz");

		return 3 - dayTrades.length;
	}
