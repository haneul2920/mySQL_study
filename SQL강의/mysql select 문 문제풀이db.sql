CREATE DATABASE LibraryDB;
USE LibraryDB;
 

CREATE TABLE Books (
  BookID INT AUTO_INCREMENT PRIMARY KEY,
  Title VARCHAR(255) NOT NULL,
  Author VARCHAR(255),
  Publisher VARCHAR(255),
  YearPublished VARCHAR(255),
  Genre VARCHAR(100),
  Available BOOLEAN DEFAULT TRUE
);
 

CREATE TABLE Members (
  MemberID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Email VARCHAR(100) UNIQUE,
  Phone VARCHAR(15),
  JoinDate DATE DEFAULT '2024-11-07'
);

 

CREATE TABLE Loans (
  LoanID INT AUTO_INCREMENT PRIMARY KEY,
  BookID INT,
  MemberID INT,
  LoanDate DATE DEFAULT '2024-11-07',
  ReturnDate DATE,
  Returned BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (BookID) REFERENCES Books(BookID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);


-- Books 테이블 데이터 삽입 

INSERT INTO Books (Title, Author, Publisher, YearPublished, Genre, Available) VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 'Fiction', TRUE), ('To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', 1960, 'Fiction', TRUE), ('1984', 'George Orwell', 'Secker & Warburg', 1949, 'Dystopian', TRUE), ('Pride and Prejudice', 'Jane Austen', 'T. Egerton', 1813, 'Romance', TRUE), ('The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company', 1951, 'Fiction', FALSE), ('Moby Dick', 'Herman Melville', 'Harper & Brothers', 1851, 'Adventure', TRUE), ('War and Peace', 'Leo Tolstoy', 'The Russian Messenger', 1869, 'Historical', TRUE), ('The Hobbit', 'J.R.R. Tolkien', 'George Allen & Unwin', 1937, 'Fantasy', TRUE), ('Crime and Punishment', 'Fyodor Dostoevsky', 'The Russian Messenger', 1866, 'Psychological', FALSE), ('The Alchemist', 'Paulo Coelho', 'HarperOne', 1988, 'Adventure', TRUE); 

 

-- Members 테이블 데이터 삽입 

INSERT INTO Members (FirstName, LastName, Email, Phone, JoinDate) VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2024-01-15'), ('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2024-02-12'), ('Emily', 'Johnson', 'emily.j@example.com', '555-666-7777', '2024-03-10'), ('Michael', 'Brown', 'michael.brown@example.com', '222-333-4444', '2024-04-08'), ('Sarah', 'Davis', 'sarah.d@example.com', '444-555-6666', '2024-05-17'), ('William', 'Jones', 'will.jones@example.com', '333-222-1111', '2024-06-23'), ('Emma', 'Miller', 'emma.m@example.com', '999-888-7777', '2024-07-05'), ('Olivia', 'Wilson', 'olivia.w@example.com', '123-123-1234', '2024-08-14'), ('James', 'Taylor', 'james.t@example.com', '987-987-9876', '2024-09-19'), ('Sophia', 'Anderson', 'sophia.a@example.com', '777-555-3333', '2024-10-30'); 

 

-- Loans 테이블 데이터 삽입 

INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate, Returned) VALUES (1, 2, '2024-09-01', '2024-09-15', TRUE), (3, 5, '2024-10-01', NULL, FALSE), (2, 8, '2024-10-03', '2024-10-17', TRUE), (4, 1, '2024-10-05', NULL, FALSE), (6, 3, '2024-10-10', '2024-10-24', TRUE), (7, 6, '2024-10-12', NULL, FALSE), (8, 7, '2024-10-14', '2024-10-28', TRUE), (9, 9, '2024-10-16', NULL, FALSE), (5, 4, '2024-10-20', NULL, FALSE), (10, 10, '2024-10-25', NULL, FALSE);