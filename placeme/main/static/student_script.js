// student_script.js

const placementList = document.getElementById('placementList');
const detailsPage = document.getElementById('detailsPage');
const placementsPage = document.getElementById('placementsPage');
const detailsBackButton = document.getElementById('detailsBackButton');
const profilePage = document.getElementById('profilePage'); // Add profile page
const viewProfileButton = document.getElementById('viewProfileButton'); // Add profile button
const profileBackButton = document.getElementById('profileBackButton');

// --- DOM element references for details ---
const detailsPageTitle = document.getElementById('detailsPageTitle');
const detailsCompany = document.getElementById('detailsCompany');
const detailsCgpa = document.getElementById('detailsCgpa');
const detailsBacklogs = document.getElementById('detailsBacklogs');
const detailsSalary = document.getElementById('detailsSalary');
const detailsDescription = document.getElementById('detailsDescription');
const detailsSkills = document.getElementById('detailsSkills');
const detailsContact = document.getElementById('detailsContact');
const detailsPosted = document.getElementById('detailsPosted');
const detailsDeadline = document.getElementById('detailsDeadline');
const detailsStatus = document.getElementById('detailsStatus'); // Get the status element
const applyForm = document.getElementById('applyForm');
const applyBtn = document.getElementById('applyBtn');

// --- DOM element references for profile details
const profileName = document.getElementById('profileName');
const profileEmail = document.getElementById('profileEmail');
const profileRegNo = document.getElementById('profileRegNo');
const profileCGPA = document.getElementById('profileCGPA');
const profileBacklogs = document.getElementById('profileBacklogs');
const profileDepartment = document.getElementById('profileDepartment');
const profileDivision = document.getElementById('profileDivision');
const profileSemester = document.getElementById('profileSemester');
const profileDob = document.getElementById('profileDob');
const profileBatch = document.getElementById('profileBatch');
const profilePhone = document.getElementById('profilePhone');

function initStudent() {
    console.log("student script js called")
    setupSidebarToggle();
    setupNavigation();
    setupProfileButton(); // Call the new function
}

function setupSidebarToggle() {
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');
    if (sidebarToggle && sidebar) {
        sidebarToggle.addEventListener('click', () => {
            sidebar.classList.toggle('sidebar-collapsed');
            sidebar.classList.toggle('sidebar-expanded', !sidebar.classList.contains('sidebar-collapsed'));
        });
    }
}
function setupNavigation() {
}
// --- Click Event Listener (Modified) ---
placementList.addEventListener('click', (event) => {
    const likeButton = event.target.closest('.like-button');
    const placementItem = event.target.closest('.placement-list-item');

    if (likeButton) {
        const placementId = parseInt(likeButton.dataset.placementId, 10);
        handleLike(placementId);
    } else if (placementItem) {
        const placementId = parseInt(placementItem.dataset.placementId, 10);
        showPlacementDetails(placementItem); // Pass the element, not just the ID
    }
});

// --- Show Placement Details (Modified) ---
function showPlacementDetails(placementItem) {
    // 1. Hide the placements list, show the details page
    placementsPage.classList.remove('active-page');
     profilePage.classList.remove('active-page');
    detailsPage.classList.add('active-page');

    // 2. Get the data from the data-* attributes
    const company = placementItem.dataset.company;
    const cgpa = placementItem.dataset.cgpa;
    const backlogs = placementItem.dataset.backlogs;
    const salary = placementItem.dataset.salary;
    const description = placementItem.dataset.description;
    const skills = placementItem.dataset.skills;
    const contact = placementItem.dataset.contact;
    const posted = placementItem.dataset.posted;
    const deadline = placementItem.dataset.deadline;
    const hasApplied = placementItem.dataset.hasApplied === 'true';
    const placementId = parseInt(placementItem.dataset.placementId, 10);
    const isLiked = placementItem.dataset.isLiked === 'true';

    // 3. Populate the details section
    detailsPageTitle.textContent = company; // Set the title
    detailsCompany.textContent = company;
    detailsCgpa.textContent = cgpa;
    detailsBacklogs.textContent = backlogs;
    detailsSalary.textContent = salary;
    detailsDescription.textContent = description;
    detailsSkills.textContent = skills;
    detailsContact.textContent = contact;
    detailsPosted.textContent = posted;
    detailsDeadline.textContent = deadline;
    // Set the form action dynamically
    applyForm.action = `/apply_for_placement/${placementId}/`;

    // 4. Update the status and button based on hasApplied
    if (hasApplied) {
        detailsStatus.textContent = 'Applied';
        applyBtn.textContent = 'Applied'; // Change button text
        applyBtn.disabled = true;          // Disable the button
    } else {
        detailsStatus.textContent = 'Not Applied';
        applyBtn.textContent = 'Register';
        applyBtn.disabled = false;
    }


}

// --- Back Button (Modified) ---
detailsBackButton.addEventListener('click', () => {
    detailsPage.classList.remove('active-page');
    placementsPage.classList.add('active-page');
});

profileBackButton.addEventListener('click', () => {
    profilePage.classList.remove('active-page');
    placementsPage.classList.add('active-page');
});

// --- AJAX for Like Button (CORRECTED) ---
function handleLike(placementId) {
    fetch(`/like_placement/${placementId}/`, {
        method: 'POST',
        headers: {
            'X-CSRFToken': getCookie('csrftoken'),
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest', // Add this for Django to recognize as AJAX
        },
        body: JSON.stringify({})
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Find the specific placement list item
            const placementItem = document.querySelector(`.placement-list-item[data-placement-id="${placementId}"]`);
            if (placementItem) {
                // Update the data-is-liked attribute
                placementItem.dataset.isLiked = data.is_liked ? 'true' : 'false';

                // Update the like button icon *within that item*
                const likeButton = placementItem.querySelector('.like-button');
                if (likeButton) {
                    const icon = likeButton.querySelector('.material-icons');
                    icon.textContent = data.is_liked ? 'favorite' : 'favorite_border';
                }
            }
        } else {
            console.error('Error liking placement:', data.message);
        }
    })
    .catch(error => console.error('Error:', error));
}

// --- CSRF Token Function (Keep this) ---
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(0, name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

// --- Profile Button Setup ---
function setupProfileButton() {
    if (viewProfileButton) {
        viewProfileButton.addEventListener('click', () => {
            // Hide placements and details, show profile
            placementsPage.classList.remove('active-page');
            detailsPage.classList.remove('active-page');
            profilePage.classList.add('active-page');

        });
    }
}


document.getElementById('navLogout').addEventListener('click', function() {
    fetch('/logout/', {
        method: 'GET',
        credentials: 'same-origin'
    })
    .then(response => {
        if (response.redirected) {
            sessionStorage.clear();
            window.location.href = response.url;
        } else {
            console.error('Logout failed: No redirection');
        }
    })
    .catch(error => console.error('Logout error:', error));
});

initStudent();