window.addEventListener('input', () => {
 const priceInput = document.getElementById("item-price");
 const inputValue = priceInput.value;
 console.log(inputValue);
 const addTaxDom = document.getElementById("add-tax-price");
 addTaxDom.innerHTML = (Math.floor(inputValue*0.1))
 const addTax = addTaxDom.innerHTML
 const profitDom = document.getElementById("profit");
 profitDom.innerHTML = (Math.floor(inputValue-addTax))
});