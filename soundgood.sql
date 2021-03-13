CREATE TABLE administrative_staff (
 id SERIAL NOT NULL
);

ALTER TABLE administrative_staff ADD CONSTRAINT PK_administrative_staff PRIMARY KEY (id);


CREATE TABLE guardian (
 id SERIAL NOT NULL,
 zip VARCHAR(5) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL
);

ALTER TABLE guardian ADD CONSTRAINT PK_guardian PRIMARY KEY (id);


CREATE TABLE instructor (
 id SERIAL NOT NULL,
 person_number VARCHAR(12) NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 available BOOLEAN NOT NULL,
 can_teach_ensembles BOOLEAN NOT NULL,
 available_for_individual_lessons BOOLEAN NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instructor_instrument (
 instructor_id INT NOT NULL,
 instrument VARCHAR(500) NOT NULL
);

ALTER TABLE instructor_instrument ADD CONSTRAINT PK_instructor_instrument PRIMARY KEY (instructor_id,instrument);


CREATE TABLE instructor_payment (
 id SERIAL NOT NULL,
 payment NUMERIC(32) NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instructor_payment ADD CONSTRAINT PK_instructor_payment PRIMARY KEY (id);


CREATE TABLE is_weekend_price (
 is_weekend BOOLEAN NOT NULL,
 price NUMERIC(32) NOT NULL
);

ALTER TABLE is_weekend_price ADD CONSTRAINT PK_is_weekend_price PRIMARY KEY (is_weekend);


CREATE TABLE lesson (
 id SERIAL NOT NULL,
 time TIMESTAMP(10) NOT NULL,
 duration INT NOT NULL,
 skill_level VARCHAR(500) NOT NULL,
 lesson_type VARCHAR(500) NOT NULL,
 instructor_id INT
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE rental_instrument (
 id SERIAL NOT NULL,
 brand VARCHAR(500) NOT NULL,
 monthly_fee INT NOT NULL,
 rented BOOLEAN NOT NULL,
 instrument_type VARCHAR(500) NOT NULL
);

ALTER TABLE rental_instrument ADD CONSTRAINT PK_rental_instrument PRIMARY KEY (id);


CREATE TABLE skill_level_price (
 skill_level VARCHAR(500) NOT NULL,
 price NUMERIC(32) NOT NULL
);

ALTER TABLE skill_level_price ADD CONSTRAINT PK_skill_level_price PRIMARY KEY (skill_level);


CREATE TABLE student (
 id SERIAL NOT NULL,
 person_number VARCHAR(12) NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 age INT NOT NULL,
 street VARCHAR(500) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 city VARCHAR(500) NOT NULL,
 guardian_id INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_instrument (
 student_id INT NOT NULL,
 instrument_type VARCHAR(500) NOT NULL,
 skill_level VARCHAR(500) NOT NULL
);

ALTER TABLE student_instrument ADD CONSTRAINT PK_student_instrument PRIMARY KEY (student_id,instrument_type);


CREATE TABLE student_payment (
 id SERIAL NOT NULL,
 payment NUMERIC(32) NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_payment ADD CONSTRAINT PK_student_payment PRIMARY KEY (id);


CREATE TABLE lesson_type_price (
 lesson_type VARCHAR(500) NOT NULL,
 price NUMERIC(32) NOT NULL
);

ALTER TABLE lesson_type_price ADD CONSTRAINT PK_lesson_type_price PRIMARY KEY (lesson_type);


CREATE TABLE application (
 id SERIAL NOT NULL,
 accepted BOOLEAN,
 instrument VARCHAR(500) NOT NULL,
 student_id INT NOT NULL,
 lesson_id INT NOT NULL,
 administrative_staff_id INT
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (id);


CREATE TABLE audition (
 student_id INT NOT NULL,
 lesson_id INT NOT NULL,
 time TIMESTAMP(10) NOT NULL,
 passed BOOLEAN,
 administrative_staff_id INT
);

ALTER TABLE audition ADD CONSTRAINT PK_audition PRIMARY KEY (student_id,lesson_id);


CREATE TABLE sibling_discount (
 student_id INT NOT NULL,
 nr_of_siblings_who_took_lessons_same_month INT NOT NULL,
 amount NUMERIC(32) NOT NULL
);

ALTER TABLE sibling_discount ADD CONSTRAINT PK_sibling_discount PRIMARY KEY (student_id);


CREATE TABLE email (
 email_address VARCHAR(500) NOT NULL,
 student_id INT,
 instructor_id INT,
 guardian_id INT
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (email_address);


CREATE TABLE ensemble_lesson (
 lesson_id INT NOT NULL,
 genre VARCHAR(500) NOT NULL,
 min_nr_of_students INT NOT NULL,
 max_nr_of_students INT NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 instrument VARCHAR(500) NOT NULL,
 places INT NOT NULL,
 free_places INT NOT NULL,
 min_nr_of_students INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 instrument_type VARCHAR(500) NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE lesson_price (
 lesson_id INT NOT NULL,
 skill_level VARCHAR(500),
 lesson_type VARCHAR(500),
 is_weekend BOOLEAN
);

ALTER TABLE lesson_price ADD CONSTRAINT PK_lesson_price PRIMARY KEY (lesson_id);


CREATE TABLE phone (
 phone_number VARCHAR(500) NOT NULL,
 student_id INT,
 instructor_id INT,
 guardian_id INT
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (phone_number);


CREATE TABLE rentals (
 id SERIAL NOT NULL,
 rental_start TIMESTAMP(10) NOT NULL,
 rental_end TIMESTAMP(10),
 terminated BOOLEAN,
 rental_instrument_id INT NOT NULL,
 student_id INT
);

ALTER TABLE rentals ADD CONSTRAINT PK_rentals PRIMARY KEY (id);


CREATE TABLE siblings (
 student_id INT NOT NULL,
 sibling_id INT NOT NULL,
 took_lessons_same_month BOOLEAN
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (student_id,sibling_id);


CREATE TABLE booking (
 student_id INT NOT NULL,
 lesson_id INT NOT NULL,
 time TIMESTAMP(10) NOT NULL,
 administrative_staff_id INT
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (student_id,lesson_id);


ALTER TABLE instructor_instrument ADD CONSTRAINT FK_instructor_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;


ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE SET NULL;


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE SET NULL;


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (guardian_id) REFERENCES guardian (id) ON DELETE SET NULL;


ALTER TABLE student_instrument ADD CONSTRAINT FK_student_instrument_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;


ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE SET NULL;


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (instrument_type,student_id) REFERENCES student_instrument (instrument_type,student_id) ON DELETE CASCADE;
ALTER TABLE application ADD CONSTRAINT FK_application_1 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE application ADD CONSTRAINT FK_application_2 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE application ADD CONSTRAINT FK_application_3 FOREIGN KEY (administrative_staff_id) REFERENCES administrative_staff (id) ON DELETE SET NULL;


ALTER TABLE audition ADD CONSTRAINT FK_audition_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE audition ADD CONSTRAINT FK_audition_1 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE audition ADD CONSTRAINT FK_audition_2 FOREIGN KEY (administrative_staff_id) REFERENCES administrative_staff (id) ON DELETE SET NULL;


ALTER TABLE sibling_discount ADD CONSTRAINT FK_sibling_discount_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;


ALTER TABLE email ADD CONSTRAINT FK_email_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE SET NULL;
ALTER TABLE email ADD CONSTRAINT FK_email_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE SET NULL;
ALTER TABLE email ADD CONSTRAINT FK_email_2 FOREIGN KEY (guardian_id) REFERENCES guardian (id) ON DELETE SET NULL;


ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE lesson_price ADD CONSTRAINT FK_lesson_price_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE lesson_price ADD CONSTRAINT FK_lesson_price_1 FOREIGN KEY (skill_level) REFERENCES skill_level_price (skill_level) ON DELETE SET NULL;
ALTER TABLE lesson_price ADD CONSTRAINT FK_lesson_price_2 FOREIGN KEY (lesson_type) REFERENCES lesson_type_price (lesson_type) ON DELETE SET NULL;
ALTER TABLE lesson_price ADD CONSTRAINT FK_lesson_price_3 FOREIGN KEY (is_weekend) REFERENCES is_weekend_price (is_weekend) ON DELETE SET NULL;


ALTER TABLE phone ADD CONSTRAINT FK_phone_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE SET NULL;
ALTER TABLE phone ADD CONSTRAINT FK_phone_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE SET NULL;
ALTER TABLE phone ADD CONSTRAINT FK_phone_2 FOREIGN KEY (guardian_id) REFERENCES guardian (id) ON DELETE SET NULL;


ALTER TABLE rentals ADD CONSTRAINT FK_rentals_0 FOREIGN KEY (rental_instrument_id) REFERENCES rental_instrument (id) ON DELETE CASCADE;
ALTER TABLE rentals ADD CONSTRAINT FK_rentals_1 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE SET NULL;


ALTER TABLE siblings ADD CONSTRAINT FK_siblings_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE siblings ADD CONSTRAINT FK_siblings_1 FOREIGN KEY (sibling_id) REFERENCES student (id) ON DELETE CASCADE;


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (lesson_id) REFERENCES individual_lesson (lesson_id) ON DELETE CASCADE;
ALTER TABLE booking ADD CONSTRAINT FK_booking_2 FOREIGN KEY (administrative_staff_id) REFERENCES administrative_staff (id) ON DELETE SET NULL;
