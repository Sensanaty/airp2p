import flatpickr from "flatpickr";

const initFlatpicker = () => {
  // First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.
  const startDateInput = document.getElementById('rental_start_date');
  const endDateInput = document.getElementById('rental_end_date');

  // Check that the query selector id matches the one you put around your form.
  if (startDateInput) {
  const unavailableDates = JSON.parse(document.querySelector('#listing-booking-dates').dataset.unavailable)
  //endDateInput.disabled = true
  console.log(endDateInput)

  flatpickr(startDateInput, {
    minDate: "today",
    disable: unavailableDates,
    dateFormat: "Y-m-d",
  });

  const endDateForm = flatpickr(endDateInput, {
    //minDate: e.target.value,
    disable: unavailableDates,
    dateFormat: "Y-m-d"
    });


  startDateInput.addEventListener("change", (e) => {
    if (startDateInput != "") {
      console.log(endDateForm)
      endDateForm.set("minDate", e.target.value)
    }
    })
  };
}

export { initFlatpicker }
