create database BANK1;
use BANK1;

CREATE TABLE Branch (
  BRANCHNAME VARCHAR(50) PRIMARY KEY,
  BRANCHCITY VARCHAR(50),
  ASSETS INT
);

INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bangalore', 5000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bangalore', 2000),
('SBI_ParliamentRoad', 'Delhi', 3000),
('SBI_JantarMantar', 'Delhi', 4000);

CREATE TABLE BankAccount (
  ACCNO INT PRIMARY KEY,
  BRANCHNAME VARCHAR(50),
  BALANCE INT,
  FOREIGN KEY (BRANCHNAME) REFERENCES Branch(BRANCHNAME)
);

INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 5000),
(2, 'SBI_ResidencyRoad', 10000),
(3, 'SBI_ShivajiRoad', 2000),
(4, 'SBI_ParliamentRoad', 3000),
(5, 'SBI_JantarMantar', 4000);

CREATE TABLE BankCustomer (
  CUSTOMERNAME VARCHAR(50) PRIMARY KEY,
  CUSTOMERSTREET VARCHAR(100),
  CUSTOMERCITY VARCHAR(50)
);

INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Gandhi_Bazaar', 'Bangalore'),
('Ravi', 'Prithviraj_Road', 'Delhi');

CREATE TABLE Loan (
  LOANNUMBER VARCHAR(10) PRIMARY KEY,
  BRANCHNAME VARCHAR(50),
  AMOUNT INT,
  FOREIGN KEY (BRANCHNAME) REFERENCES Branch(BRANCHNAME)
);

INSERT INTO Loan VALUES
('L1', 'SBI_Chamrajpet', 1000),
('L2', 'SBI_ResidencyRoad', 2000),
('L3', 'SBI_ShivajiRoad', 3000),
('L4', 'SBI_ParliamentRoad', 4000),
('L5', 'SBI_JantarMantar', 5000);

CREATE TABLE Depositor (
  CUSTOMERNAME VARCHAR(50),
  ACCNO INT,
  FOREIGN KEY (CUSTOMERNAME) REFERENCES BankCustomer(CUSTOMERNAME),
  FOREIGN KEY (ACCNO) REFERENCES BankAccount(ACCNO)
);

INSERT INTO Depositor VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 3),
('Ravi', 4),
('Avinash', 5),
('Dinesh', 1),
('Nikil', 2),
('Nikil', 3),
('Dinesh', 4),
('Nikil', 5);

SELECT BRANCHNAME, ASSETS AS ASSETS_IN_LAKHS
FROM BRANCH;

SELECT D.CUSTOMERNAME
FROM BankAccount B, Depositor D
WHERE B.ACCNO=D.ACCNO
GROUP BY D.CUSTOMERNAME
HAVING COUNT(*)>1;

CREATE VIEW LOAN_AT_BRANCH AS
SELECT BRANCHNAME, SUM(Amount) as Total_loan
FROM LOAN
GROUP BY BRANCHNAME;

SELECT * FROM LOAN_AT_BRANCH;
