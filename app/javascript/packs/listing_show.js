const calculatePrice = () => {
const start_date_input = document.querySelector('#rental_start_date');
const end_date_input = document.querySelector('#rental_end_date');
const total_price_display = document.querySelector('#total_price');
const price_string = document.querySelector('#price').innerText;
const price = parseInt(price_string);
let duration = 0;
let start_date;

console.log(price);
start_date_input.addEventListener('change', () => {
  start_date = new Date(start_date_input.value);
})

end_date_input.addEventListener('change', () => {
  let end_date = new Date(end_date_input.value);
  let duration = new Date (end_date - start_date);
  let days = duration / (1000 * 60 * 60 * 24);
  let total_price = price * (days + 1);
  total_price_display.innerText = `$${total_price}`;
})



}

export { calculatePrice }
