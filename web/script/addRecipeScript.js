/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
let draggables = document.querySelectorAll('.draggable');
const container = document.querySelector('.container');
const toggleDragModeButton = document.getElementById('toggleDragMode');
const addButton = document.getElementById('addButton');
const addHeaderButton = document.getElementById('addHeaderButton');
let inputs = document.querySelectorAll('.input');
let dragModeEnabled = false; // Flag to track drag mode
let deleteButtons = document.querySelectorAll('.deleteButton');

// Function to toggle drag mode
function toggleDragMode(enableDragMode) {
	dragModeEnabled = enableDragMode;
	draggables.forEach((draggable) => {
		draggable.draggable = dragModeEnabled;
		draggable.classList.toggle('drag-mode-disabled', !dragModeEnabled);
		draggable.style.cursor = dragModeEnabled ? 'grab' : 'default';
	});

	inputs.forEach((input) => {
		input.disabled = dragModeEnabled;
		input.classList.toggle('disable-selection', !dragModeEnabled);
	});

	if (dragModeEnabled) {
		console.log('Drag mode enabled');
		draggables.forEach((draggable) => {
			draggable.addEventListener('dragstart', () => {
				draggable.classList.add('dragging');
			});

			draggable.addEventListener('dragend', () => {
				draggable.classList.remove('dragging');
			});
		});

		container.addEventListener('dragover', (e) => {
			e.preventDefault();
			const afterElement = getDragAfterElement(container, e.clientY);
			const draggable = document.querySelector('.dragging');
			if (afterElement == null) {
				container.appendChild(draggable);
			} else {
				container.insertBefore(draggable, afterElement);
			}
		});
	}
}

// Add event listener to the toggle button
toggleDragModeButton.addEventListener('click', () => {
	toggleDragMode(!dragModeEnabled); // Toggle the drag mode
});

// Add event listener to the add button
addButton.addEventListener('click', () => {
	if (!dragModeEnabled) {
		const newDraggable = document.createElement('p');
		newDraggable.classList.add('draggable');
		newDraggable.draggable = dragModeEnabled;

		// Create new input element
		const newInput = document.createElement('input');
		newInput.type = 'text';
		newInput.classList.add('input');
		newInput.name = 'direction';

		// Create delete button
		const deleteButton = document.createElement('button');
		deleteButton.textContent = 'Delete';
		deleteButton.type = 'button';
		deleteButton.classList.add('deleteButton');
		deleteButton.addEventListener('click', () => {
			newDraggable.remove();
			if (container.querySelectorAll('.draggable').length == 1) {
				disableDeleteButtons();
			}
		});

		// Append input element and delete button to draggable element
		newDraggable.appendChild(newInput);
		newDraggable.appendChild(deleteButton);

		// Append draggable element to container
		container.appendChild(newDraggable);
		draggables = document.querySelectorAll('.draggable');
		inputs = document.querySelectorAll('.input');

		deleteButtons = document.querySelectorAll('.deleteButton');
		enableDeleteButtons();
	}
});

addHeaderButton.addEventListener('click', () => {
	if (!dragModeEnabled) {
		const newDraggable = document.createElement('p');
		newDraggable.classList.add('draggable');
		newDraggable.draggable = dragModeEnabled;

		// Create new input element
		const newInput = document.createElement('input');
		newInput.type = 'text';
		newInput.classList.add('input');
		newInput.name = 'header';

		// Create delete button
		const deleteButton = document.createElement('button');
		deleteButton.textContent = 'Delete';
		deleteButton.type = 'button';
		deleteButton.classList.add('deleteButton');
		deleteButton.addEventListener('click', () => {
			newDraggable.remove();
			if (container.querySelectorAll('.draggable').length == 1) {
				disableDeleteButtons();
			}
		});

		// Append input element and delete button to draggable element
		newDraggable.appendChild(newInput);
		newDraggable.appendChild(deleteButton);

		// Append draggable element to container
		container.appendChild(newDraggable);
		draggables = document.querySelectorAll('.draggable');
		inputs = document.querySelectorAll('.input');

		deleteButtons = document.querySelectorAll('.deleteButton');
		enableDeleteButtons();
	}
});

function getDragAfterElement(container, y) {
	const draggableElements = [
		...container.querySelectorAll('.draggable:not(.dragging)'),];

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

function disableDeleteButtons() {
	deleteButtons.forEach((button) => {
		button.disabled = true;
	});
}

function enableDeleteButtons() {
	deleteButtons.forEach((button) => {
		button.disabled = false;
	});
}

document.querySelectorAll('.deleteButton').forEach((button) => {
	button.addEventListener('click', () => {
		button.parentNode.remove();
		if (container.querySelectorAll('.draggable').length == 1) {
			disableDeleteButtons();
		}
	});
});


