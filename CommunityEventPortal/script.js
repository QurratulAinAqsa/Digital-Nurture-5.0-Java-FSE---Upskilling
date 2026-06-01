// =====================================
// 1. JavaScript Basics & Setup
// =====================================

console.log("Welcome to the Community Portal");

window.onload = () => {
    alert("Community Portal Loaded Successfully!");
};

// =====================================
// 2. Syntax, Data Types and Operators
// =====================================

const eventName = "Music Festival";
const eventDate = "2026-06-15";
let availableSeats = 50;

console.log(
    `Event: ${eventName} | Date: ${eventDate} | Seats: ${availableSeats}`
);

// =====================================
// 3. Conditionals, Loops, Error Handling
// =====================================

const events = [
    {
        id: 1,
        name: "Music Festival",
        category: "Music",
        seats: 50
    },
    {
        id: 2,
        name: "Food Carnival",
        category: "Food",
        seats: 25
    },
    {
        id: 3,
        name: "Sports Day",
        category: "Sports",
        seats: 0
    }
];

events.forEach(event => {

    if (event.seats > 0) {

        console.log(
            `${event.name} is available`
        );
    }

    else {

        console.log(
            `${event.name} is Full`
        );
    }
});

function safeRegistration(eventObj) {

    try {

        if (eventObj.seats <= 0) {

            throw new Error(
                "No seats available"
            );
        }

        eventObj.seats--;

        console.log(
            `Registered for ${eventObj.name}`
        );

    }

    catch (error) {

        console.error(
            error.message
        );
    }
}

// =====================================
// 4. Functions, Scope, Closures
// =====================================

function addEvent(name, category, seats) {

    events.push({

        id: Date.now(),
        name,
        category,
        seats
    });
}

function registerUser(eventId) {

    let event = events.find(
        e => e.id === eventId
    );

    if (event && event.seats > 0) {

        event.seats--;
    }
}

function filterEventsByCategory(
    category,
    callback
) {

    let result = events.filter(
        e => e.category === category
    );

    callback(result);
}

// Closure Example

function registrationTracker() {

    let count = 0;

    return function () {

        count++;

        return count;
    };
}

const musicTracker =
    registrationTracker();

console.log(
    "Music Registrations:",
    musicTracker()
);

// =====================================
// 5. Objects and Prototypes
// =====================================

class Event {

    constructor(
        name,
        category,
        seats
    ) {

        this.name = name;
        this.category = category;
        this.seats = seats;
    }
}

Event.prototype.checkAvailability =
    function () {

        return this.seats > 0
            ? "Available"
            : "Full";
    };

const workshop =
    new Event(
        "Baking Workshop",
        "Food",
        20
    );

console.log(
    workshop.checkAvailability()
);

Object.entries(workshop)
    .forEach(
        ([key, value]) =>
            console.log(
                key,
                value
            )
    );

// =====================================
// 6. Arrays and Methods
// =====================================

events.push({

    id: 4,
    name: "Dance Competition",
    category: "Dance",
    seats: 30
});

const musicEvents =
    events.filter(
        event =>
            event.category === "Music"
    );

console.log(musicEvents);

const eventCards =
    events.map(
        event =>
            `Workshop on ${event.name}`
    );

console.log(eventCards);

// =====================================
// 7. DOM Manipulation
// =====================================

const eventContainer =
    document.querySelector(
        "#eventContainer"
    );

function displayEvents(
    eventList = events
) {

    if (!eventContainer) return;

    eventContainer.innerHTML = "";

    eventList.forEach(event => {

        const card =
            document.createElement("div");

        card.className =
            "event-card";

        card.innerHTML = `

            <h3>${event.name}</h3>

            <p>
                Category:
                ${event.category}
            </p>

            <p>
                Seats:
                ${event.seats}
            </p>

            <button
            onclick="registerFromCard(${event.id})">

            Register

            </button>
        `;

        eventContainer.appendChild(
            card
        );
    });
}

function registerFromCard(id) {

    registerUser(id);

    displayEvents();
}

// =====================================
// 8. Event Handling
// =====================================

const filterDropdown =
    document.querySelector(
        "#categoryFilter"
    );

if (filterDropdown) {

    filterDropdown.onchange =
        function () {

            filterEventsByCategory(

                this.value,

                displayEvents
            );
        };
}

const searchBox =
    document.querySelector(
        "#searchInput"
    );

if (searchBox) {

    searchBox.addEventListener(

        "keydown",

        function () {

            let value =
                this.value
                    .toLowerCase();

            let filtered =
                events.filter(

                    event =>

                        event.name
                            .toLowerCase()
                            .includes(value)
                );

            displayEvents(
                filtered
            );
        }
    );
}

// =====================================
// 9. Async JS, Promises,
// Async Await
// =====================================

function fetchEvents() {

    console.log(
        "Loading Events..."
    );

    fetch(
        "https://jsonplaceholder.typicode.com/posts"
    )

        .then(response =>
            response.json()
        )

        .then(data =>
            console.log(
                data.slice(0, 5)
            )
        )

        .catch(error =>
            console.error(error)
        );
}

async function fetchEventsAsync() {

    try {

        console.log(
            "Loading..."
        );

        const response =
            await fetch(
                "https://jsonplaceholder.typicode.com/posts"
            );

        const data =
            await response.json();

        console.log(
            data.slice(0, 5)
        );

    }

    catch (error) {

        console.error(error);
    }
}

// =====================================
// 10. Modern JavaScript
// =====================================

function greetUser(
    username = "Guest"
) {

    console.log(
        `Welcome ${username}`
    );
}

const {
    name,
    category,
    seats
} = workshop;

console.log(
    name,
    category,
    seats
);

const clonedEvents =
    [...events];

// =====================================
// 11. Forms
// =====================================

const form =
    document.querySelector(
        "#eventForm"
    );

if (form) {

    form.addEventListener(

        "submit",

        function (event) {

            event.preventDefault();

            const name =
                form.elements[0]
                    .value;

            const email =
                form.elements[1]
                    .value;

            if (
                name === "" ||
                email === ""
            ) {

                alert(
                    "Please fill all fields"
                );

                return;
            }

            console.log(
                "Form Submitted"
            );
        }
    );
}

// =====================================
// 12. AJAX & Fetch API
// =====================================

function submitRegistration(
    userData
) {

    setTimeout(() => {

        fetch(
            "https://jsonplaceholder.typicode.com/posts",

            {

                method: "POST",

                headers: {

                    "Content-Type":
                        "application/json"
                },

                body:
                    JSON.stringify(
                        userData
                    )
            }
        )

            .then(response =>
                response.json()
            )

            .then(data => {

                console.log(
                    "Registration Success",
                    data
                );
            })

            .catch(error => {

                console.error(
                    "Registration Failed",
                    error
                );
            });

    }, 2000);
}

// =====================================
// 13. Debugging
// =====================================

console.log(
    "Debug: JS Loaded"
);

console.log(
    "Total Events:",
    events.length
);

// =====================================
// 14. jQuery Example
// =====================================

/*

$('#registerBtn').click(function(){

    $('.event-card').fadeOut();

    $('.event-card').fadeIn();

});

Benefit of React/Vue:

✔ Component-based architecture

✔ Faster UI updates

✔ Better code organization

✔ Easier maintenance

*/