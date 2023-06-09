/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
//Direction Init
let draggablesDirection = document.querySelectorAll('.draggable-direction');
const containerDirection = document.querySelector(
	'.draggable-container-direction'
);
const btnToggleDirection = document.getElementById('btnToggleDirection');
const btnAddDirection = document.getElementById('btnAddDirection');
const btnAddHeader = document.getElementById('btnAddHeader');
let inputsDirection = containerDirection.querySelectorAll('.input');
let dragDirection = false; // Flag to track drag mode
let btnDeleteDirection = document.querySelectorAll('.btnDeleteDirection');
// Create an <img> element


// Function to toggle drag mode
function toggleDragMode(enableDragMode) {
	dragDirection = enableDragMode;
	draggablesDirection.forEach((draggable) => {
		draggable.draggable = dragDirection;
		draggable.classList.toggle('drag-mode-disabled', !dragDirection);
		draggable.style.cursor = dragDirection ? 'grab' : 'default';
	});

	inputsDirection.forEach((input) => {
		input.disabled = dragDirection;
		input.classList.toggle('disable-selection', !dragDirection);
		input.style.cursor = dragDirection ? 'grab' : 'default';
	});

	if (dragDirection) {
		console.log('Drag mode enabled');
		draggablesDirection.forEach((draggable) => {
			draggable.addEventListener('dragstart', () => {
				draggable.classList.add('dragging');
			});

			draggable.addEventListener('dragend', () => {
				draggable.classList.remove('dragging');
			});
		});

		containerDirection.addEventListener('dragover', (e) => {
			e.preventDefault();
			const afterElement = getDragAfterElement(
				containerDirection,
				e.clientY
			);
			const draggable = document.querySelector('.dragging');
			if (afterElement == null) {
				containerDirection.appendChild(draggable);
			} else {
				containerDirection.insertBefore(draggable, afterElement);
			}
		});
	}
}

// Add event listener to the toggle button
btnToggleDirection.addEventListener('click', () => {
	toggleDragMode(!dragDirection); // Toggle the drag mode
});

// Add event listener to the add button
btnAddDirection.addEventListener('click', () => {
	if (!dragDirection) {
		const newDraggable = document.createElement('p');
		newDraggable.classList.add('draggable-direction');
		newDraggable.classList.add('draggable');
		newDraggable.draggable = dragDirection;

		// Create new input element
		const newInput = document.createElement('textarea');
		newInput.type = 'text';
		newInput.classList.add('input');
		newInput.name = 'direction';
		newInput.rows = '5';
		newInput.placeholder = 'Your direction here';
		newInput.required = true;

		// Create delete button
		const deleteButton = document.createElement('button');
		deleteButton.type = 'button';
		deleteButton.classList.add('btnDeleteDirection');

		// Create an <img> element
		const deleteImage = document.createElement('img');
		deleteImage.src = './assets/close.svg';
		deleteImage.alt = 'Delete';

		// Append the <img> element to the button
		deleteButton.appendChild(deleteImage);

		deleteButton.addEventListener('click', () => {
			newDraggable.remove();
			if (
				containerDirection.querySelectorAll('.draggable-direction')
					.length == 1
			) {
				disableDeleteButtons(btnDeleteDirection);
			}
		});

		// Append input element and delete button to draggable element
		newDraggable.appendChild(newInput);
		newDraggable.appendChild(deleteButton);

		// Append draggable element to containerDirection
		containerDirection.appendChild(newDraggable);
		draggablesDirection = document.querySelectorAll('.draggable-direction');
		inputsDirection = containerDirection.querySelectorAll('.input');

		btnDeleteDirection = document.querySelectorAll('.btnDeleteDirection');
		enableDeleteButtons(btnDeleteDirection);
	}
});

btnAddHeader.addEventListener('click', () => {
	if (!dragDirection) {
		const newDraggable = document.createElement('p');
		newDraggable.classList.add('draggable-direction');
		newDraggable.classList.add('draggable');
		newDraggable.draggable = dragDirection;

		// Create new input element
		const newInput = document.createElement('input');
		newInput.type = 'text';
		newInput.classList.add('input');
		newInput.name = 'header';
		newInput.placeholder = 'Your header here';

		// Create delete button
		const deleteButton = document.createElement('button');
		deleteButton.type = 'button';
		deleteButton.classList.add('btnDeleteDirection');

		// Create an <img> element
		const deleteImage = document.createElement('img');
		deleteImage.src = './assets/close.svg';
		deleteImage.alt = 'Delete';

		// Append the <img> element to the button
		deleteButton.appendChild(deleteImage);

		deleteButton.addEventListener('click', () => {
			newDraggable.remove();
			if (
				containerDirection.querySelectorAll('.draggable-direction')
					.length == 1
			) {
				disableDeleteButtons(btnDeleteDirection);
			}
		});

		// Append input element and delete button to draggable element
		newDraggable.appendChild(newInput);
		newDraggable.appendChild(deleteButton);

		// Append draggable element to containerDirection
		containerDirection.appendChild(newDraggable);
		draggablesDirection = document.querySelectorAll('.draggable-direction');
		inputsDirection = containerDirection.querySelectorAll('.input');

		btnDeleteDirection = document.querySelectorAll('.btnDeleteDirection');
		enableDeleteButtons(btnDeleteDirection);
	}
});

function getDragAfterElement(containerDirection, y) {
	const draggableElements = [
		...containerDirection.querySelectorAll('.draggable:not(.dragging)'),
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

document.querySelectorAll('.btnDeleteDirection').forEach((button) => {
	button.addEventListener('click', () => {
		button.parentNode.remove();
		if (
			containerDirection.querySelectorAll('.draggable-direction')
				.length == 1
		) {
			disableDeleteButtons(btnDeleteDirection);
		}
	});
});
