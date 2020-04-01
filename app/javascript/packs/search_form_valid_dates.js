const startDateEl = document.getElementById("start");
const endDateEl = document.getElementById("end");
const submit = document.getElementById("submit-search");

const enableSubmit = () => {
  submit.disabled = false;
}

const disableSubmit = () => {
  submit.disabled = true;
}

const parseDate = (dateString) => {
  const dateArray = dateString.split("-");
  const year = dateArray[0];
  const month = parseInt(dateArray[1], 10) - 1;
  const day = dateArray[2];
  const date = new Date(year, month, day);
  return date;
}

const validDates = () =>  {
  if (startDateEl.value){
    const startDate = parseDate(startDateEl.value);
    const today = new Date();
    today.setHours(0,0,0,0);
    const differenceInTimeWithToday = startDate.getTime() - today.getTime();
    if (differenceInTimeWithToday <= 0){
      return false;
    } else {
      if (endDateEl.value){
        const endDate = parseDate(endDateEl.value);
        const differenceInTime = endDate.getTime() - startDate.getTime();
        if (differenceInTime <= 0) {
          return false
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  }
  else {
    return false;
  }
}

const checkDates = () => {
  if (validDates()) {
    enableSubmit();
  } else {
    disableSubmit();
  }
}

const validationForDates = () => {
  if (submit){
    checkDates();
    startDateEl.addEventListener("change", (event) => {
      checkDates();
    });
    endDateEl.addEventListener("change", (event) => {
      checkDates();
    });
  }
}

export { validationForDates };

