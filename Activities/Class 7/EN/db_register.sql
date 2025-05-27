CREATE DATABASE customer_records;

USE customer_records;

CREATE TABLE Person(
	person_id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	birth_date DATE NOT NULL,
	nationality VARCHAR(255) NOT NULL,
	gender ENUM('M','F') NOT NULL,
	marital_status ENUM('single','married','divorced','widowed'),
	rg_number VARCHAR(20) NOT NULL UNIQUE,
	ssn VARCHAR(17) NOT NULL UNIQUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_person PRIMARY KEY (person_id)
);

CREATE TABLE Enrollment(
	enrollment_id INT NOT NULL AUTO_INCREMENT,
	person_id INT NOT NULL,
	employee_number VARCHAR(20) NOT NULL,
	hire_date DATE NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_enrollment PRIMARY KEY (enrollment_id),
	CONSTRAINT fk_enrollment_person FOREIGN KEY (person_id) REFERENCES Person (person_id)
);

CREATE TABLE Address(
	address_id INT NOT NULL AUTO_INCREMENT,
	person_id INT NOT NULL,
	street VARCHAR(100) NOT NULL,
	number INT,
	complement VARCHAR(100),
	neighborhood VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	state CHAR(2) NOT NULL,
	postal_code VARCHAR(10) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_address PRIMARY KEY (address_id),
	CONSTRAINT fk_address_person FOREIGN KEY (person_id) REFERENCES Person (person_id)
);

CREATE TABLE Job_History(
	job_id INT NOT NULL AUTO_INCREMENT,
	person_id INT NOT NULL,
	position VARCHAR(100) NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_job_history PRIMARY KEY (job_id),
	CONSTRAINT fk_job_history_person FOREIGN KEY (person_id) REFERENCES Person (person_id)
);

CREATE TABLE Department_Assignment(
	assignment_id INT NOT NULL AUTO_INCREMENT,
	person_id INT NOT NULL,
	department VARCHAR(100) NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_department_assignment PRIMARY KEY (assignment_id),
	CONSTRAINT fk_department_assignment_person FOREIGN KEY (person_id) REFERENCES Person (person_id)
);

CREATE TABLE Dependent(
	person_id INT NOT NULL,
	principal_id INT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_dependent PRIMARY KEY (person_id),
	CONSTRAINT fk_dependent_person FOREIGN KEY (person_id) REFERENCES Person (person_id),
	CONSTRAINT fk_dependent_principal FOREIGN KEY (principal_id) REFERENCES Person (person_id)
);
