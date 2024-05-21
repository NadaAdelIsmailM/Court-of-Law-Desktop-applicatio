CREATE TABLE chiefjustice
(

ch_name VARCHAR(15) NOT NULL,
ch_id INT ,
ch_idpic image NOT NULL,
ch_sy_id int NOT NULL,
PRIMARY KEY (ch_id),


)



CREATE TABLE judge
(
j_name VARCHAR(15) NOT NULL,
j_id INT ,
j_degree VARCHAR(15) NOT NULL,
j_sy_id int NOT NULL,
j_idpic  image NOT NULL,
ch_id int ,
PRIMARY KEY (j_id),
FOREIGN KEY (ch_id) REFERENCES chiefjustice(ch_id)
	ON DELETE SET DEFAULT
	ON UPDATE CASCADE

)


CREATE TABLE lawyer
(
l_name VARCHAR(15) NOT NULL,
l_id INT ,
l_degree VARCHAR(15) NOT NULL,
l_sy_id int NOT NULL,
PRIMARY KEY (l_id)
)

CREATE TABLE civilian
(

c_name VARCHAR(15) NOT NULL,
c_id INT ,
l_idpic image NOT NULL,
l_id int ,
Power_Attorney image NOT NULL,
PRIMARY KEY (c_id),
FOREIGN KEY (l_id) REFERENCES lawyer
	ON DELETE SET NULL
	ON UPDATE CASCADE
)

CREATE TABLE court
(

court_num INT ,
court_location INT NOT NULL,
court_type VARCHAR(15) NOT NULL,
ch_id INT ,

PRIMARY KEY (court_num),
FOREIGN KEY (ch_id) REFERENCES chiefjustice
	ON DELETE SET DEFAULT
	ON UPDATE CASCADE
)

CREATE TABLE courtcase
(
ch_id INT ,
court_num INT ,
l_id INT ,
c_id INT NOT NULL,

case_obj_decision VARCHAR(15),
case_year  int ,
case_id INT ,
case_type VARCHAR(15) ,
case_location VARCHAR(15) ,
case_verdict VARCHAR(15), 
case_status VARCHAR(15), 
case_degree VARCHAR(15),
PRIMARY KEY (case_id,case_year,case_type,case_location),
FOREIGN KEY (ch_id) REFERENCES chiefjustice
	ON DELETE SET DEFAULT
	ON UPDATE CASCADE,
FOREIGN KEY (l_id) REFERENCES lawyer
	ON DELETE SET NULL
	ON UPDATE CASCADE,
FOREIGN KEY (c_id) REFERENCES civilian,
FOREIGN KEY (court_num) REFERENCES court
)



CREATE TABLE witnesses
(
case_year  int ,
case_id INT ,
case_type VARCHAR(15) ,
case_location VARCHAR(15) ,

w_name VARCHAR(15),
w_id INT,
w_idpic image,
PRIMARY KEY (w_id),
FOREIGN KEY (case_id,case_year,case_type,case_location) REFERENCES courtcase(case_id,case_year,case_type,case_location)
)


CREATE TABLE courtsession
(
session_date date,
session_location VARCHAR(15),

case_year  int,
case_id INT,
case_type VARCHAR(15),
case_location VARCHAR(15),
j_id int,

PRIMARY KEY (session_date,session_location),
FOREIGN KEY (case_id,case_year,case_type,case_location) REFERENCES courtcase(case_id,case_year,case_type,case_location),
FOREIGN KEY (j_id) REFERENCES judge
	ON DELETE SET DEFAULT
	ON UPDATE CASCADE
)


CREATE TABLE Testify
(
w_id INT,
case_year  int,
case_id INT,
case_type VARCHAR(15),
case_location VARCHAR(15),

FOREIGN KEY (w_id) REFERENCES witnesses
	ON DELETE SET NULL
	ON UPDATE CASCADE,
FOREIGN KEY (case_id,case_year,case_type,case_location) REFERENCES courtcase(case_id,case_year,case_type,case_location)
)


CREATE TABLE Evidence
(
Evidence image,
case_year  int,
case_id INT,
case_type VARCHAR(15),
case_location VARCHAR(15),

FOREIGN KEY (case_id,case_year,case_type,case_location) REFERENCES courtcase(case_id,case_year,case_type,case_location)
)


CREATE TABLE Assigned_To
(
j_id INT,
case_year  int,
case_id INT,
case_type VARCHAR(15),
case_location VARCHAR(15),
FOREIGN KEY (j_id) REFERENCES judge
	ON DELETE SET DEFAULT
	ON UPDATE CASCADE,
FOREIGN KEY (case_id,case_year,case_type,case_location) REFERENCES courtcase(case_id,case_year,case_type,case_location)
)

CREATE TABLE Represent_in
(
l_id INT,
case_year  int,
case_id INT,
case_type VARCHAR(15),
case_location VARCHAR(15),
FOREIGN KEY (l_id) REFERENCES lawyer
	ON DELETE SET NULL
	ON UPDATE CASCADE,
FOREIGN KEY (case_id,case_year,case_type,case_location) REFERENCES courtcase(case_id,case_year,case_type,case_location)
)
GO