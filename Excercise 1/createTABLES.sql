CREATE TABLE Employer (
    Employer_ID SERIAL PRIMARY KEY,
    FullName VARCHAR(80),
    JoiningDate DATE,
    CurrentPosition VARCHAR(80),
    Department VARCHAR(80),
    AssignedProject VARCHAR(80)
);

CREATE TABLE Services (
    Software_ID SERIAL PRIMARY KEY,
    SoftwareName VARCHAR(80),
    SoftwareCategory VARCHAR(80),
    SoftwareSize INT,
    NumberOfInstallments INT
);

CREATE TABLE Software_Requests (
    Employer_ID int references Employer(Employer_ID),
    Software_ID int references Services(Software_ID),
    Request_Start_Date DATE,
    Request_Closed_Date DATE,
    CurrentStatus BOOLEAN
);
