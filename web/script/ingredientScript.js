    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
//Ingredient Init
let draggablesIngredient = document.querySelectorAll('.draggable-ingredient');
const containerIngredient = document.querySelector(
	'.draggable-container-ingredient'
);
const btnToggleIngredient = document.getElementById('btnToggleIngredient');
const btnAddIngredient = document.getElementById('btnAddIngredient');

let inputsIngredient = containerIngredient.querySelectorAll('.input');
let dragIngredient = false; // Flag to track drag mode
let btnDeleteIngredient = document.querySelectorAll('.btnDeleteIngredient');

// Ingredient select field

// Get the select element
const ingredientList = document.querySelectorAll('.ingredientList');

// Function to toggle drag mode
function toggleDragModeIngredient(enableDragMode) {
	dragIngredient = enableDragMode;
	draggablesIngredient.forEach((draggable) => {
		draggable.draggable = dragIngredient;
		draggable.classList.toggle('drag-mode-disabled', !dragIngredient);
		draggable.style.cursor = dragIngredient ? 'grab' : 'default';
	});

	inputsIngredient.forEach((input) => {
		input.disabled = dragIngredient;
		input.classList.toggle('disable-selection', !dragIngredient);
		input.style.cursor = dragIngredient ? 'grab' : 'default';
	});

	if (dragIngredient) {
		console.log('Drag mode enabled');
		draggablesIngredient.forEach((draggable) => {
			draggable.addEventListener('dragstart', () => {
				draggable.classList.add('dragging');
			});

			draggable.addEventListener('dragend', () => {
				draggable.classList.remove('dragging');
			});
		});

		containerIngredient.addEventListener('dragover', (e) => {
			e.preventDefault();
			const afterElement = getDragAfterElement(
				containerIngredient,
				e.clientY
			);
			const draggable = document.querySelector('.dragging');
			if (afterElement == null) {
				containerIngredient.appendChild(draggable);
			} else {
				containerIngredient.insertBefore(draggable, afterElement);
			}
		});
	}
}

// Add event listener to the toggle button
btnToggleIngredient.addEventListener('click', () => {
	toggleDragModeIngredient(!dragIngredient); // Toggle the drag mode
});

// Add event listener to the add button
btnAddIngredient.addEventListener('click', () => {
	if (!dragIngredient) {
		const newDraggable = document.createElement('p');
		newDraggable.classList.add('draggable-ingredient');
		newDraggable.classList.add('draggable');
		newDraggable.draggable = dragIngredient;

		// Create new input element
		const newInput = document.createElement('input');
		newInput.type = 'text';
		newInput.classList.add('input');
		newInput.name = 'ingredientDesc';
		newInput.required = true;

		//create the option field
		const option = document.createElement('select');
		option.classList.add('ingredientList');
                option.name = 'ingredientId';
		createOptions(option);
		// Create delete button
		const deleteButton = document.createElement('button');
		deleteButton.type = 'button';
		deleteButton.classList.add('btnDeleteIngredient');

		// Create an <img> element
		const deleteImage = document.createElement('img');
		deleteImage.src = './assets/close-icon.svg';
		deleteImage.alt = 'Delete';

		// Append the <img> element to the button
		deleteButton.appendChild(deleteImage);
		
		deleteButton.addEventListener('click', () => {
			newDraggable.remove();
			if (
				containerIngredient.querySelectorAll('.draggable-ingredient')
					.length == 1
			) {
				disableDeleteButtons(btnDeleteIngredient);
			}
		});

		// Append input element and delete button to draggable element
		newDraggable.appendChild(newInput);
		newDraggable.appendChild(option);
		newDraggable.appendChild(deleteButton);

		// Append draggable element to containerIngredient
		containerIngredient.appendChild(newDraggable);
		draggablesIngredient = document.querySelectorAll(
			'.draggable-ingredient'
		);
		inputsIngredient = containerIngredient.querySelectorAll('.input');

		btnDeleteIngredient = document.querySelectorAll('.btnDeleteIngredient');
		enableDeleteButtons(btnDeleteIngredient);
	}
});

function getDragAfterElement(containerIngredient, y) {
	const draggableElements = [
		...containerIngredient.querySelectorAll('.draggable:not(.dragging)'),
	];

	return draggableElements.reduce(
		(closest, child) => {
			const box = child.getBoundingClientRect();
			const offset = y - box.top - box.height / 2;
			if (offset < 0 && offset > closest.offset) {
				return { offset: offset, element: child };
			} else {
				return closest;
			}
		},
		{ offset: Number.NEGATIVE_INFINITY }
	).element;
}

function disableDeleteButtons(deleteButtons) {
	deleteButtons.forEach((button) => {
		button.disabled = true;
	});
}

function enableDeleteButtons(deleteButtons) {
	deleteButtons.forEach((button) => {
		button.disabled = false;
	});
}

document.querySelectorAll('.btnDeleteIngredient').forEach((button) => {
	button.addEventListener('click', () => {
		button.parentNode.remove();
		if (
			containerIngredient.querySelectorAll('.draggable-ingredient')
				.length == 1
		) {
			disableDeleteButtons(btnDeleteIngredient);
		}
	});
});

// Add options to the select element
// Add options to the select elements
ingredientList.forEach((element) => {
	for (const key in hashMap) {
		if (hashMap.hasOwnProperty(key)) {
			const option = document.createElement('option');
			option.value = key;
			option.text = hashMap[key];
			element.appendChild(option);
		}
	}

	// Set the first option as selected
	element.firstChild.selected = true;
	// Add the "required" attribute to the select element
	element.setAttribute('required', true);
});

function createOptions(selectElement) {
	for (const key in hashMap) {
		if (hashMap.hasOwnProperty(key)) {
			const option = document.createElement('option');
			option.value = key;
			option.text = hashMap[key];
			selectElement.appendChild(option);
		}
	}

	// Set the first option as selected
	selectElement.firstChild.selected = true;
	// Add the "required" attribute to the select element
	selectElement.setAttribute('required', true);
}
