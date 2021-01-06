CREATE TABLE application (
 student_id INT NOT NULL,
 applied_instrument VARCHAR(500)
);


CREATE TABLE appointment (
 instructor_name VARCHAR(500)
);


CREATE TABLE instructor (
 instructor_id VARCHAR(20) NOT NULL,
 person_id INT NOT NULL,
 employment_id VARCHAR(50) NOT NULL,
 instrument_skill  VARCHAR(500),
 nr_of_lessons INT,
 lesson_date DATE
);


CREATE TABLE person (
 person_id INT NOT NULL,
 person_number VARCHAR(12),
 first_name VARCHAR(500),
 last_name VARCHAR(500),
 age VARCHAR(50),
 street VARCHAR(100),
 zip VARCHAR(100),
 city VARCHAR(100)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE phone (
 phone_nr VARCHAR(500) NOT NULL
);


CREATE TABLE schedule (
 lesson_type VARCHAR(10),
 time TIME,
 date DATE
);


CREATE TABLE skill_level (
 beginner VARCHAR(50),
 intermediate VARCHAR(50),
 advanced VARCHAR(50)
);


CREATE TABLE soundgood_music_school (
 school_id INT NOT NULL,
 street VARCHAR(100),
 zip VARCHAR(100),
 city VARCHAR(100),
 age_limit INT,
 nr_of_students INT,
 nr_of_instructors  INT
);

ALTER TABLE soundgood_music_school ADD CONSTRAINT PK_soundgood_music_school PRIMARY KEY (school_id);


CREATE TABLE student (
 student_id INT NOT NULL,
 person_id INT NOT NULL,
 nr_of_siblings  INT,
 school_id INT NOT NULL,
 guardian_id INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE audition (
 time TIMESTAMP(10),
 grade CHAR(20)
);


CREATE TABLE email_address (
 email VARCHAR(500) NOT NULL
);


CREATE TABLE ensemble_lesson (
 instructor VARCHAR(500),
 instrument VARCHAR(50),
 nr_of_students INT,
 skill_level VARCHAR(50),
 date DATE,
 genre VARCHAR(100),
 nr_of_lessons INT,
 seats_left VARCHAR(50),
 weekday VARCHAR(50)
);


CREATE TABLE group_lesson (
 instructor VARCHAR(500),
 instrument VARCHAR(50),
 nr_of_students INT,
 skill_level VARCHAR(50),
 date DATE,
 nr_of_lessons INT
);


CREATE TABLE guardian (
 guardian_id INT NOT NULL,
 person_id INT NOT NULL,
 nr_of_children  INT
);

ALTER TABLE guardian ADD CONSTRAINT PK_guardian PRIMARY KEY (guardian_id);


CREATE TABLE individual_lesson (
 student VARCHAR(500),
 instructor VARCHAR(500),
 instrument VARCHAR(50),
 skill_level VARCHAR(50),
 date DATE,
 nr_of_lessons INT
);


CREATE TABLE lesson_requirements (
 min_nr_of_students INT,
 max_nr_of_students  INT
);


CREATE TABLE price (
 weekday_price INT,
 weekend_price INT,
 skill_level_price INT,
 school_id INT
);


CREATE TABLE rental (
 lease_period DATE,
 school_id INT
);


CREATE TABLE rental_instrument (
 instrument_type VARCHAR(50),
 brand VARCHAR(500),
 quantity INT,
 monthly_rental_fee INT,
 rental_date DATE,
 access_instrument_type VARCHAR(50)
);


CREATE TABLE rules_of_rental (
 lease_period DATE,
 fee_per_month INT,
 limit_of_rentals  INT
);


CREATE TABLE sibling_discount (
 amount INT
);


CREATE TABLE payment (
 amount INT
);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (school_id) REFERENCES soundgood_music_school (school_id);
ALTER TABLE student ADD CONSTRAINT FK_student_2 FOREIGN KEY (guardian_id) REFERENCES guardian (guardian_id);


ALTER TABLE guardian ADD CONSTRAINT FK_guardian_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE price ADD CONSTRAINT FK_price_0 FOREIGN KEY (school_id) REFERENCES soundgood_music_school (school_id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (school_id) REFERENCES soundgood_music_school (school_id);


