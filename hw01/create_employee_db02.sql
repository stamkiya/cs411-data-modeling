CREATE DATABASE IF NOT EXISTS employee_model02;
use employee_model02;

DROP TABLE IF EXISTS TermReason;
DROP TABLE IF EXISTS PersonalInfo;
DROP TABLE IF EXISTS HourlyPay;
DROP TABLE IF EXISTS SalaryPay;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS MarialStatus;
DROP TABLE IF EXISTS EmployeeStatus;
DROP TABLE IF EXISTS JobTitle;
DROP TABLE IF EXISTS Department;

CREATE TABLE IF NOT EXISTS MarialStatus (
	code INT NOT NULL PRIMARY KEY,
    status VARCHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS EmployeeStatus (
	code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS Department (
	code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS JobTitle (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  department_code INT,
  foreign key(department_code) references Department(code)
);

CREATE TABLE IF NOT EXISTS Employee(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  is_terminated BOOLEAN,
  salary DOUBLE,
  manager_id INT,
  emp_status_code INT,
  job_title_id INT,
  FOREIGN KEY(job_title_id) REFERENCES JobTitle(id),
  FOREIGN KEY(emp_status_code) REFERENCES EmployeeStatus(code)
);

CREATE TABLE IF NOT EXISTS HourlyPay(	
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    FOREIGN KEY(emp_id) REFERENCES Employee(id)
);

CREATE TABLE IF NOT EXISTS SalaryPay(	
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    FOREIGN KEY(emp_id) REFERENCES Employee(id)
);


CREATE TABLE IF NOT EXISTS TermReason (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    reason VARCHAR(255),
    emp_id INT NOT NULL,
    FOREIGN KEY(emp_id) REFERENCES Employee(id)
);

CREATE TABLE IF NOT EXISTS PersonalInfo (
	emp_id INT NOT NULL PRIMARY KEY,
    sex VARCHAR(100),
    DOB VARCHAR(50),
    zip_code INT,
    marrial_status_code INT,
    FOREIGN KEY(emp_id) REFERENCES Employee(id),
    FOREIGN KEY(marrial_status_code) REFERENCES MarialStatus(code)
);

