/**
 * Retrieves input data from a form and returns it as a JSON object.
 * @param  {HTMLFormControlsCollection} elements  the form elements
 * @return {Object}                               form data as an object literal
 */
const formToJSON = (elements) =>
  [].reduce.call(
    elements,
    (data, element) => {
      // Make sure the element has the required properties and should be added.
      if (isValidElement(element) && isValidValue(element)) {
        /*
         * Some fields allow for more than one value, so we need to check if this
         * is one of those fields and, if so, store the values as an array.
         */
        if (isCheckbox(element)) {
          data[element.name] = (data[element.name] || []).concat(element.value);
        } else if (isMultiSelect(element)) {
          data[element.name] = getSelectValues(element);
        } else {
          data[element.name] = element.value;
        }
      }

      return data;
    },
    {}
  );

function handleHttp(data, gameName, modalName) {
  const jsonData = JSON.stringify(data, null, "  ");

  var xmlHttp = new XMLHttpRequest();
  xmlHttp.open("POST", "https://postman-echo.com/post", true);
  xmlHttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
  xmlHttp.send(jsonData);

  xmlHttp.onload = function () {
    window.location.href = "https://postman-echo.com/post";
  };
}

const testFormSubmit = (event) => {
  event.preventDefault();
  const data = formToJSON(test_form.elements);
  console.log(data);
  handleHttp(data, triviaGameName, "triviaModal");
};

const test_form = document.getElementById("test-form");
test_form.addEventListener("submit", testFormSubmit);
