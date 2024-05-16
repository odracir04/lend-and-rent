# _Lend & Rent_ Development Report

Welcome to the documentation pages of the _Lend & Rent_!

You can find here details about the _Lend & Rent_, from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by type of activities: 

* [Business modeling](#Business-Modelling) 
  * [Product Vision](#Product-Vision)
  * [Features and Assumptions](#Features-and-Assumptions)
  * [Elevator Pitch](#Elevator-pitch)
* [Requirements](#Requirements)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* [Architecture and Design](#Architecture-And-Design)
  * [Logical architecture](#Logical-Architecture)
  * [Physical architecture](#Physical-Architecture)
  * [Vertical prototype](#Vertical-Prototype)
* [Project management](#Project-Management)

Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

- Camila Santos Silva (up202109812@up.pt)
- Gonçalo Guedes da Conceição (up202206456@up.pt)
- Rafael Teixeira de Magalhães (up202206499@up.pt)
- Ricardo de Freitas Oliveira (up202205353@up.pt)
- Tomás Alexandre Torres Pereira (up202108845@up.pt)

---
## Business Modelling

### Product Vision
Lend & Rent envisions to facilitate the lives of our community, encouraging a connected community throught resource sharing.

We believe that knowledge is power, and our mission is to empower users through our app, fostering connections and promoting sustainable practices one book at a time.

### Features and Assumptions
- [x] **Book Listing:** Users can access and browse the collection of books available for rent.
  
- [x] **Search Filtering:** Users can select specific filters to facilitate finding the perfect book match. 

- [x] **Renting:** Users can rent books from others within the community.
  
- [x] **Lending:** Users can list their own books for rent, contributing to the shared pool of resources.

- [x] **User Profiles:** Profiles for each user to manage their accounts and user details.

### Elevator Pitch
> [!WARNING]
> This section is not written out yet.
Draft a small text to help you quickly introduce and describe your product in a short time (lift travel time ~90 seconds) and a few words (~800 characters), a technique usually known as elevator pitch.

Take a look at the following links to learn some techniques:
* [Crafting an Elevator Pitch](https://www.mindtools.com/pages/article/elevator-pitch.htm)
* [The Best Elevator Pitch Examples, Templates, and Tactics - A Guide to Writing an Unforgettable Elevator Speech, by strategypeak.com](https://strategypeak.com/elevator-pitch-examples/)
* [Top 7 Killer Elevator Pitch Examples, by toggl.com](https://blog.toggl.com/elevator-pitch-examples/)


## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

### Domain model

The app is structured so that users can lend and rent books. Therefore, users can be lenters, renters, or both. Each user has his personal information, a list of rented books and a list of lent books. For each book, it is necessary to store its ISBN, its name, a description of it, as well as any courses/themes the book may be a part of. The app also features a comment/review system. Each comment comes from a user and can be placed in another users profile page, or a book page. For each comment, its necessary to save its text, submission date and its last edition date. Finally, for the apps chat feature, each chat is between a lenter and a renter and has a set of message, of which it is necessary to store its text and the user who sent it.
 
<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/domain.png"/>
</p>


## Architecture and Design
> [!WARNING]
> This section is not written out yet.

The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code (Logical View), using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system in a horizontal decomposition, defining layers and implementation concepts, such as the user interface, business logic and concepts.

![LogicalView](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/Architecture%20and%20Design/logical_archutecture.png)

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams (Deployment View) or component diagrams (Implementation View), separate or integrated, showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for ESOF are, for example, frameworks for mobile applications (such as Flutter).

![DeploymentView](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/Architecture%20and%20Design/physical_architecture.png)

### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we have implemented a vertical prototype, a thin vertical slice of the system integrating as many technologies as we can.

The vertical prototype consists of a simpler version of the apps home page containing only the following functionalities:
- Book display
- Database access for book retrieval
- Book search
- Theming, dark and light mode

## Project management
> [!WARNING]
> This section is not written out yet.

Software project management is the art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we recommend each team to adopt a set of project management practices and tools capable of registering tasks, assigning tasks to team members, adding estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Common practices of managing iterative software development are: backlog management, release management, estimation, iteration planning, iteration development, acceptance tests, and retrospectives.

You can find below information and references related with the project management in our team: 

* Backlog management: Product backlog and Sprint backlog in a [Github Projects board](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/54);
* Release management: [v0](#), v1, v2, v3, ...;
* Sprint planning and retrospectives: 
  * plans: screenshots of Github Projects board at begin and end of each iteration;
  * retrospectives: meeting notes in a document in the repository;

 ---

 ## Sprint 1

 ### Implemented Features

**Sign In** - The user must now sign in at start up in order to access the app fully.

**Home page** - The user now has access to all books available, listed in the home page.

**Search engine and respective filters** - Either by setting up filters or simply inputting the name of the wanted book, the user can now search through all the available books with ease with the newly implemented search bar on the top of the home page.

**Navigation bar** - In order to switch through the various pages of the app swiftly, a new navigation bar was added at the bottom section of the app. Users can currenty only explore the home and profile pages, with more options coming in the future.

**Profile page** - An early prototype of they're profile page is now available to the user.

 ### Bug fixes

No corrections were made during this iteration of the project.

 ### Sprint Planning

**Project at start of Sprint 1:**
 
<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/backlog/sprint0.png"/>
</p>

**Project at end of Sprint 1:**

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/backlog/sprint1.png"/>
</p>

 ### Sprint Retrospective and Observations
In regards to the development of the app itself, all but one of the planned features where implemented, although only one included the respective tests.

Thus far, our team was faced with lack of communication and problems regarding the organization of the project, issues that lead our performance as a team to overall fall below expected. As such, we're looking forward to improve on those regards until the next sprint.

## Sprint 2

### Implemented Features

**New App Logo** - The _Lend & Rent_ app now displays new art, improving its identity and overall branding.

**Sign Up** - The user can now sign up to the service in order to fully enjoy the app and all its features.

**Recover Password** - A new option was included to the sign in page where users can request a password recovery when necessary.

**Profile Page and Settings** - After weeks in development, the profile page is now mostly implemented. Users can now promptly check and alter they're account info as well.

**Add Books** - Users can finally add their book postings to the app.

**Chat** - In order to arrange an exchange, users can now make use of the new chat feature to send and receive messages form each other.

### Bug fixes

Opening the keyboard in the sign in page no longer causes the widgets to overflow.

Elements at the top of the screen, such as the searchbar, are no longer hidden behind the front cameras and dynamic islands in some phone models.

### Sprint Planning

**Project at start of Sprint 2:**

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/backlog/sprint1.png"/>
</p>

**Project at end of Sprint 2:**

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/backlog/sprint2.png"/>
</p>

### Sprint Retrospective and Observations
As a team, we are proud to say that our communication has improved, leading to a greater organization and overall performance during this sprint.

Most of the planned features were implemented without issue, and all pre-existing bugs were fixed promptly. 

Since this sprint had a bigger focus on implementing missing features, we expect the next one to be more aimed at testing and bug fixing, in order to prepare for the coming presentation and offer the user a more reliable and enjoyable experience.