# VAmPI
**The Vulnerable API** *(Based on OpenAPI 3)*
![vampi](https://i.imgur.com/zR0quKf.jpg)

VAmPI is a vulnerable API made with Flask and it includes vulnerabilities from the OWASP top 10 vulnerabilities for APIs. It was created as I wanted a vulnerable API to evaluate the efficiency of tools used to detect security issues in APIs. It includes a switch on/off to allow the API to be vulnerable or not while testing. This allows to cover better the cases for false positives/negatives. VAmPI can also be used for learning/teaching purposes. You can find a bit more details about the vulnerabilities in [erev0s.com](https://erev0s.com/blog/vampi-vulnerable-api-security-testing/).
Vulpy is a web application developed in Python / Flask / SQLite that has two faces: secure and insecure.

## Features
 - Based on OWASP Top 10 vulnerabilities for APIs.
 - OpenAPI3 specs and Postman Collection included.
 - Global switch on/off to have a vulnerable environment or not.
 - Token-Based Authentication (Adjust lifetime from within app.py)

VAmPI's flow of actions is going like this: an unregistered user can see minimal information about the dummy users included in the API. A user can register and then login to be allowed using the token received during login to post a book. For a book posted the data accepted are the title and a secret about that book. Each book is unique for every user and only the owner of the book should be allowed to view the secret.

A quick rundown of the actions included can be seen in the following table:

| **Action** |            **Path**           |                     **Details**                    |
|:----------:|:-----------------------------:|:--------------------------------------------------:|
|     GET    |           /createdb           | Creates and populates the database with dummy data |
|     GET    |               /               |                     VAmPI home                     |
|     GET    |           /users/v1           |      Displays all users with basic information     |
|     GET    |        /users/v1/_debug       |         Displays all details for all users         |
|    POST    |       /users/v1/register      |                  Register new user                 |
|    POST    |        /users/v1/login        |                   Login to VAmPI                   |
|     GET    |      /users/v1/{username}     |              Displays user by username             |
|   DELETE   |      /users/v1/{username}     |       Deletes user by username (Only Admins)       |
|     PUT    |   /users/v1/{username}/email  |             Update a single users email            |
|     PUT    | /users/v1/{username}/password |                Update users password               |
|     GET    |           /books/v1           |                 Retrieves all books                |
|    POST    |           /books/v1           |                    Add new book                    |
|     GET    |        /books/v1/{book}       |      Retrieves book by title along with secret     |

For more details you can use a service like the [swagger editor](https://editor.swagger.io) supplying it the OpenAPI specification which can be found in the directory `openapi_specs`.

### List of Vulnerabilities
 - SQLi Injection
 - Unauthorized Password Change
 - Broken Object Level Authorization
 - Mass Assignment
 - Excessive Data Exposure through debug endpoint
 - User and Password Enumeration
 - RegexDOS (Denial of Service)
 - Lack of Resources & Rate Limiting

#### WARNING!
THIS WEB APPLICATION CONTAINS NUMEROUS SECURITY VULNERABILITIES WHICH WILL RENDER YOUR COMPUTER VERY INSECURE WHILE RUNNING! IT IS HIGHLY RECOMMENDED TO COMPLETELY DISCONNECT YOUR COMPUTER FROM ALL NETWORKS WHILE RUNNING!

#### Google Chrome Note
Google Chrome performs filtering for reflected XSS attacks. These attacks will not work unless chrome is run with the argument `--disable-xss-auditor`.

##### Contrast Instrumentation 
This repo includes the components necessary to instrument contrast Assess/Protect with this Python application except for the contrast_security.yaml file containing the connection strings.


# Requirements

1. Docker Community Edition
2. docker-compose

When built, the Dockerfile pulls all of the code into the Docker Container. 

## How to build and run

### 1. Running in a Docker Container

The provided Dockerfile is compatible with both Linux and Windows containers (note from Steve: I've only run it on Linux).

To build a Docker image, execute the following command: docker-compose build

### Linux Containers

To run the `vampi` Container image, execute one of the following commands:

1. Development: docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

2. QA: docker-compose -f docker-compose.yml -f docker-compose.qa.yml up -d

3. Production (this disables Assess and enables Protect): docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

VAmPI should be accessible at http://ip_address:5002.


### Stopping the Docker container

To stop the `vampi` container, execute the following command in the same directory as your docker-compose files: docker-compose stop 

### 2. Building with Jenkins
Included is a sample Jenkinsfile that can be used as a Jenkins Pipeline to build and run the application. The Jenkins Pipeline passes buildNumber as a parameter to the YAML. 

#### Customizing token timeout and vulnerable environment or not
If you would like to alter the timeout of the token created after login or if you want to change the environment **not** to be vulnerable then you can use a few ways depending how you run the application.

 - If you run it like normal with `python3 app.py` then all you have to do is edit the `alive` and `vuln` variables defined in the `app.py` itself. The `alive` variable is measured in seconds, so if you put `100`, then the token expires after 100 seconds. The `vuln` variable is like boolean, if you set it to `1` then the application is vulnerable, and if you set it to `0` the application is not vulnerable.
 - If you run it through Docker, then you must either pass environment variables to the `docker run` command or edit the `Dockerfile` and rebuild. 
   - Docker run example: `docker run -d -e vulnerable=0 -e tokentimetolive=300 -p 5000:5000 vampire_docker:latest`
     - One nice feature to running it this way is you can startup a 2nd container with `vulnerable=1` on a different port and flip easily between the two.

   - In the Dockerfile you will find two environment variables being set, the `ENV vulnerable=1` and the `ENV tokentimetolive=60`. Feel free to change it before running the docker-compose build command.

##### Default user accounts
The database comes pre-populated with these user accounts created as part of the seed data -
* Admin Account - u:admin p:pass1 
* User Accounts - u:name1 p:pass1
* New users can also be added using the sign-up page.
