USE customer_records;

INSERT INTO Person (first_name, last_name, birth_date, nationality, gender, marital_status, rg_number, ssn)
VALUES
  ('João','Silva','1980-05-15','Brazilian','M','married','MG1234567','123.456.789-00'),
  ('Maria','Oliveira','1985-09-30','Brazilian','F','single','SP7654321','987.654.321-00'),
  ('Pedro','Souza','1975-12-10','Brazilian','M','divorced','RJ1122334','111.222.333-44'),
  ('Ana','Silva','2010-03-20','Brazilian','F',NULL,'MG9988776','222.333.444-55'),
  ('Lucas','Silva','2012-07-08','Brazilian','M',NULL,'MG5544332','333.444.555-66');

INSERT INTO Enrollment (person_id, employee_number, hire_date)
VALUES
  (1,'EMP-001','2005-01-10'),
  (2,'EMP-002','2010-05-22'),
  (3,'EMP-003','2000-09-15');

INSERT INTO Address (person_id, street, number, complement, neighborhood, city, state, postal_code)
VALUES
  (1,'Av. Paulista',1234,'Apt 101','Bela Vista','São Paulo','SP','01310-100'),
  (2,'Rua das Flores',567,NULL,'Centro','Campinas','SP','13010-200'),
  (3,'Av. Brasil',890,NULL,'Centro','Rio de Janeiro','RJ','20010-000');

INSERT INTO Job_History (person_id, position, start_date, end_date)
VALUES
  (1,'Analyst','2005-01-10','2010-12-31'),
  (1,'Coordinator','2011-01-01','2018-06-30'),
  (1,'Manager','2018-07-01',NULL),
  (2,'Assistant','2010-05-22','2015-08-15'),
  (2,'Supervisor','2015-08-16',NULL),
  (3,'Intern','2000-09-15','2002-12-31');

INSERT INTO Department_Assignment (person_id, department, start_date, end_date)
VALUES
  (1,'Finance','2005-01-10','2008-03-31'),
  (1,'HR','2008-04-01','2014-02-28'),
  (1,'Technology','2014-03-01',NULL),
  (2,'Logistics','2010-05-22','2012-11-30'),
  (2,'Operations','2012-12-01',NULL),
  (3,'Marketing','2000-09-15','2003-06-30');

INSERT INTO Dependent (person_id, principal_id)
VALUES
  (4,1),
  (5,1);
