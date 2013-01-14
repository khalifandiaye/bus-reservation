// initializes a set of day/month/year select elements
function initDateSelect(yearId, monthId, dayId, startYear, endYear) {
	var yearNode;
	var monthNode;
	var dayNode;
	// default startYear
	if (startYear == null) {
		startYear = new Date().getYear() - 5;
	}
	// default endYear
	if (endYear == null) {
		endYear = startYear + 5;
	}
	yearNode = document.getElementById(yearId);
	monthNode = document.getElementById(monthId);
	dayNode = document.getElementById(dayId);
	// fill year select
	fillNumberSelect(yearNode, startYear, endYear, endYear - 20);
	// fill month
	fillNumberSelect(monthNode, 1, 12, 1);
	// fill day
	fillNumberSelect(dayNode, 1, 31, 1);
	// update day select when month and year select change
	monthNode.addEventListener('change', function() {
		setDaySelect(dayNode, monthNode, yearNode);
	}, false);
	yearNode.addEventListener('change', function() {
		setDaySelect(dayNode, monthNode, yearNode);
	}, false);
}

// Update a day select element in accordance to the month and year elements
function setDaySelect(dayNote, monthNode, yearNode) {
	var year = yearNode.options[yearNode.selectedIndex].value;
	var month = monthNode.options[monthNode.selectedIndex].value;
	var day = dayNote.options[dayNote.selectedIndex].value;
	// refill day select when month and year are selected
	if (month != '' && year != '') {
		fillNumberSelect(dayNote, 1, daysInMonth(month, year), day);
	}
}

// Get number of days in a specific month
function daysInMonth(month, year) {
	return new Date(year, month, 0).getDate();
}

// fill a select element with numeric options
function fillNumberSelect(selectNode, start, end, defaultOption) {
	// clear select
	selectNode.options.length = 0;
	// add default blank option
	if (defaultOption != null && defaultOption < start) {
		selectNode.options[selectNode.options.length] = new Option('', '');
	}
	if (defaultOption != null && defaultOption > end) {
		defaultOption = end;
	}
	for ( var i = start; i <= end; i++) {
		if (defaultOption == i) {
			selectNode.options[selectNode.options.length] = new Option(i, i,
					true);
		} else {
			selectNode.options[selectNode.options.length] = new Option(i, i);
		}
	}
}