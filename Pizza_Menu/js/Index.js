
	function getOrder() {
		var text1;
		var text2;
		var runningTotal = 0;
		var sizeTotal = 0;
		var sizeArray = document.getElementsByClassName("size");
		for (var i = 0; i < sizeArray.length; i++) {
			if (sizeArray[i].checked) {
				var selectedSize = sizeArray[i].value;
				text1 = selectedSize+"<br>";
			}
		}
		if (selectedSize === "Personal") {
			sizeTotal = 6;
		} else if (selectedSize === "Medium") {
			sizeTotal = 10;
		} else if (selectedSize === "Large") {
			sizeTotal = 14;
		} else if (selectedSize === "Xlarge") {
			sizeTotal = 16;
		}
		
		runningTotal = sizeTotal;
		text2 = sizeTotal+"<br>";
		getSauce(runningTotal,text1,text2);
	}
		function getSauce(runningTotal,text1,text2) {
			var sauceTotal = 0;
			var sauceArray = document.getElementsByClassName("sauce");
			for (var a = 0; a < sauceArray.length; a++) {
				if (sauceArray[a].checked) {
					var selectedSauce = sauceArray[a].value;
					text1 = text1+selectedSauce+"<br>";
					text2 = text2+sauceTotal+"<br>";
				}
			getMeat(runningTotal,text1, text2);
			}
		};
		
		function getMeat(runningTotal,text1,text2) {
			var meatTotal = 0;
			var selectedMeat = [];
			var meatArray = document.getElementsByClassName("meats");
			for (var j = 0; j < meatArray.length; j++) {
				if (meatArray[j].checked) {
					selectedMeat.push(meatArray[j].value);
					text1 = text1+meatArray[j].value+"<br>";
					if (selectedMeat.length <= 1) {
						text2 = text2+"0 <br>";
					} else {
						text2 = text2+"1 <br>";
					}
				}
			}
			var meatCount = selectedMeat.length;
			if (meatCount > 1) {
				meatTotal = (meatCount - 1);
			} else {
				meatTotal = 0;
			}
			runningTotal = (runningTotal + meatTotal);
			getVeggie(runningTotal,text1, text2);
		};
		
		function getVeggie(runningTotal,text1,text2) {
			var veggieTotal = 0;
			var selectedVeggie = [];
			var veggieArray = document.getElementsByClassName("veggies");
			for (var b = 0; b < veggieArray.length; b++) {
				if (veggieArray[b].checked) {
					selectedVeggie.push(veggieArray[b].value);
					text1 = text1+veggieArray[b].value+"<br>";
					if (selectedVeggie.length <= 1) {
						text2 = text2+"0 <br>";
					} else {
						text2 = text2+"1 <br>";
					}
				}
			}
			var veggieCount = selectedVeggie.length;
			if (veggieCount > 1) {
				veggieTotal = (veggieCount - 1);
			} else {
				veggieTotal = 0;
			}
			runningTotal = (runningTotal + veggieTotal);
			getCheese(runningTotal,text1, text2);
		};
		
		function getCheese(runningTotal,text1,text2) {
			var cheeseTotal = 0;
			var cheeseArray = document.getElementsByClassName("cheese");
			for (var c = 0; c < cheeseArray.length; c++) {
				if (cheeseArray[c].checked) {
					var selectedCheese = cheeseArray[c].value;
					text1 = text1+selectedCheese+"<br>";
				} 
			}
			if (selectedCheese === "Extra Cheese") {
				cheeseTotal = 3;
			} else {
				cheeseTotal = 0;
			}
			
			runningTotal = (runningTotal + cheeseTotal);
			text2 = (text2+cheeseTotal+"<br>");
			getCrust(runningTotal,text1, text2);
		};
		
		function getCrust(runningTotal,text1,text2) {
			var crustTotal = 0;
			var crustArray = document.getElementsByClassName("crust");
			for (var d = 0; d < crustArray.length; d++) {
				if (crustArray[d].checked) {
					var selectedCrust = crustArray[d].value;
					text1 = text1+selectedCrust+"<br>";
				} 
			}
			if (selectedCrust === "Cheese Stuffed Crust") {
				crustTotal = 3;
			} else {
				crustTotal = 0;
			}
			
			runningTotal = (runningTotal + crustTotal);
			text2 = (text2+crustTotal+"<br>");
		
		document.getElementById("receipt").style.opacity = ".90";
		document.getElementById("title1").innerHTML="<h3><strong>Your Order</strong></h3>";
		document.getElementById("title2").innerHTML="<h3><strong>Subtotal</strong></h3>";
		document.getElementById("showText1").innerHTML=text1;
		document.getElementById("showText2").innerHTML=text2;
		document.getElementById("totalPrice1").innerHTML = "<h4>Total:</h4>";
		document.getElementById("totalPrice2").innerHTML = "<h4><strong>$"+runningTotal+".00"+"</strong></h4>";
		};

	function cancelOrder() {
		$("#menuForm").get(0).reset()
			document.getElementById("receipt").style.opacity = "0";
			document.getElementById("title1").innerHTML="";
			document.getElementById("title2").innerHTML="";
			document.getElementById("showText1").innerHTML="";
			document.getElementById("showText2").innerHTML="";
			document.getElementById("totalPrice1").innerHTML = "";
			document.getElementById("totalPrice2").innerHTML = "";
		}
