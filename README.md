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

Todos nós já pensámos: "Eu quero muito este livro, mas pagar tanto para o ler uma vez e nunca mais tocar nele? Não vale a pena!" É aqui que entra a Lend and Rent. Com a Lend and Rent, podes dar uma nova vida aos livros que já leste e receber os livros que desejas sem pagar nada. 

És apaixonado por leitura, mas já vês a tua casa a ser engolida pelos livros? Ou então simplesmente tens dificuldades a financiar essa tua paixão? Então a Lend and Rent é para ti! Comprar livros é caro, e a própria impressão deles tem um forte impacto no ambiente. Mesmo as bibliotecas têm sempre prazos para o arrendamento. E apesar de vivermos na era digital, há quem não queira deixar o prazer do livro de capa dura. Então junta-te à Lend and Rent e terás todos os livros a um clique de distância.

Vamos virar a página para um mundo mais sustentável.

## Requirements

### Domain model

The app is structured so that users can lend and rent books. Therefore, users can be lenters, renters, or both. Each user has his personal information, a list of rented books and a list of lent books. For each book, it is necessary to store its ISBN, its name, a description of it, as well as any courses/themes the book may be a part of. The app also features a comment/review system. Each comment comes from a user and can be placed in another users profile page, or a book page. For each comment, its necessary to save its text, submission date and its last edition date. Finally, for the apps chat feature, each chat is between a lenter and a renter and has a set of message, of which it is necessary to store its text and the user who sent it.
 
<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/domain.png"/>
</p>


## Architecture and Design

### Logical architecture
The application consists of a layered approach with three layers and a separated Firebase API. The UI component, responsible for the 'front-end' of the application, renders the application onto the screen and captures the users inputs. It communicates with the business logic to know what to render and for the inputs to be passed from the former to the latter in order to be processed.

The business logic handles the "internal state" of the app. It's connected to both the UI and Database schemas in order to have the information received from the user as well as the database and authentication mechanisms. With this information it processes what the next state will be, reporting back any updates necessary to both UI and Database.

The database schemas layer is simply an interface for the communication between the Firebase API and the business logic of the application.

![LogicalView](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/Architecture%20and%20Design/logical_archutecture.png)

### Physical architecture
The physical side of the application consists of the device on which the app is stored and ran, its local storage, and the Firebase servers with which the app communicates for database access (Firestore and FirebaseStorage) and authentication (FirebaseAuth).

We have chosen Firebase for the database and authentication features for its simplicity of use and efficiency. We have also chosen to develop the app in Flutter to assist with portability, and, like Firebase, due to the low degree of difficulty in using it.

![DeploymentView](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/Architecture%20and%20Design/physical_architecture.png)

### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we have implemented a [vertical prototype](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/releases/tag/vertical-prototype), a thin vertical slice of the system integrating as many technologies as we can.

The vertical prototype consists of a simpler version of the apps home page containing only the following functionalities:
- Book display
- Database access for book retrieval
- Book search
- Theming, dark and light mode

## Project management

 ## [Sprint 1](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/releases/tag/Sprint1)

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

## [Sprint 2](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/releases/tag/Sprint2)

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

## [Sprint 3](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/releases/tag/Sprint3)

### Implemented Features

**Logout** - Users can now logout of the app and switch accounts.

**Book Pages** - Each book has its own page where users can see it in more detail.

**Remove Books** - Users can now remove book postings as they see fit.

**Delete User Account** - Users can now delete their account as they see fit.

**User and Book Reviews** - Users can now leave reviews to books they have read and users they have rented to or from.

**Report Users** - Users can now report other users for malicious content.

**Aesthetic overhaul** - The UI has received an overhaul to improve the user experience.

### Bug Fixes

The user chat now synchronizes not just when messages are sent but also when they are received.

The user is not logged out when they close the app anymore.

Profile and book images maintain the appropriate size throughout the app.

### Sprint Planning

**Project at start of Sprint 3:**

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/backlog/sprint3_begin.png"/>
</p>

**Project at end of Sprint 3:**

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC16T3/blob/main/docs/backlog/sprint3_end.png"/>
</p>

### Sprint Retrospective and Observations

**What went well?**
- The team was able to work together and communicate efficiently.
- All the previously identified bugs were patched.
- All the desired features were implemented.

**What went less well?**
- We weren't able to reach full test coverage across the app as desired.
- We weren't able to dedicate as much time as desired to the project due to other concurrent projects.

**What have we learned?**
- How to integrate mocks into Flutter tests.
- How to design more complex interactions in Flutter tests (click, drag, etc...)
- How to improve the apps' architecture to better adjust for later testing.

**What still puzzles us?**
- How to test the trickier widget interactions.
- How to improve Firebase response time or make the app more visually appealing during the wait.

