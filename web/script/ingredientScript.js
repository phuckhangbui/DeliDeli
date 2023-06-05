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
		newInput.name = 'ingredient';
		newInput.required = true;

		// Create delete button
		const deleteButton = document.createElement('button');
		deleteButton.textContent = 'Delete';
		deleteButton.type = 'button';
		deleteButton.classList.add('btnDeleteIngredient');
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
