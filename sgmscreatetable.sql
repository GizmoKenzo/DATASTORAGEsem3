DROP TABLE IF EXISTS sibling_group CASCADE;
DROP TABLE IF EXISTS payment CASCADE;
DROP TABLE IF EXISTS lesson_student_history CASCADE;
DROP TABLE IF EXISTS instrument_rental CASCADE;
DROP TABLE IF EXISTS instructor_payment CASCADE;
DROP TABLE IF EXISTS instructor_lesson CASCADE;
DROP TABLE IF EXISTS contact_person CASCADE;
DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS pricing_scheme CASCADE;
DROP TABLE IF EXISTS lesson CASCADE;
DROP TABLE IF EXISTS instrument CASCADE;
DROP TABLE IF EXISTS instructor_available CASCADE;
DROP TABLE IF EXISTS instructor CASCADE;

CREATE TABLE instructor (
 id SERIAL NOT NULL,
 person_number VARCHAR(20) NOT NULL,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 level_of_skill  VARCHAR(20) NOT NULL,
 address VARCHAR(100) NOT NULL,
 phone VARCHAR(20) NOT NULL,
 email VARCHAR(50) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instructor_available (
 id SERIAL NOT NULL,
 available_start TIMESTAMP NOT NULL,
 available_end TIMESTAMP NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instructor_available ADD CONSTRAINT PK_instructor_available PRIMARY KEY (id);


CREATE TABLE instrument (
 id SERIAL NOT NULL,
 type VARCHAR(50) NOT NULL,
 brand VARCHAR(50) NOT NULL,
 quantity_in_stock INT
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE lesson (
 id SERIAL NOT NULL,
 appointment_time TIMESTAMP,
 scheduled_time TIMESTAMP,
 instrument VARCHAR(50) NOT NULL,
 level_of_skill VARCHAR(20) NOT NULL CHECK (level_of_skill IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED')),
 lesson_type VARCHAR(50) NOT NULL CHECK (lesson_type IN ('INDIVIDUAL', 'GROUP', 'ENSEMBLE')),
 maximum_of_students INT,
 minimum_of_students INT,
 genre VARCHAR(50),
 instructor_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE pricing_scheme (
 id SERIAL NOT NULL,
 lesson_type VARCHAR(50) NOT NULL CHECK (lesson_type IN ('INDIVIDUAL', 'GROUP', 'ENSEMBLE')),
 level_of_skill VARCHAR(20) NOT NULL CHECK (level_of_skill IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED')),
 sibling_discount DECIMAL(10)
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (id);


CREATE TABLE student (
 id SERIAL NOT NULL,
 person_number VARCHAR(20) NOT NULL,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 level_of_skill VARCHAR(20) NOT NULL CHECK (level_of_skill IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED')),
 address VARCHAR(100) NOT NULL,
 phone VARCHAR(20) NOT NULL,
 email VARCHAR(50) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE booking (
 id SERIAL NOT NULL,
 time_slots TIMESTAMP NOT NULL,
 student_id INT NOT NULL,
 lesson_id INT NOT NULL,
 classroom VARCHAR(50) NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (id);


CREATE TABLE contact_person (
 id SERIAL NOT NULL,
 person_number VARCHAR(20) NOT NULL,
 address VARCHAR(100) NOT NULL,
 phone VARCHAR(20) NOT NULL,
 email VARCHAR(50) NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (id);


CREATE TABLE instructor_lesson (
 id SERIAL NOT NULL,
 lesson_id INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instructor_lesson ADD CONSTRAINT PK_instructor_lesson PRIMARY KEY (id);


CREATE TABLE instructor_payment (
 id SERIAL NOT NULL,
 amount_paid DECIMAL(10),
 payment_date DATE,
 lesson_id INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instructor_payment ADD CONSTRAINT PK_instructor_payment PRIMARY KEY (id);


CREATE TABLE instrument_rental (
 id SERIAL NOT NULL,
 rental_id VARCHAR(20) NOT NULL,
 price_of_rental DECIMAL(10) NOT NULL,
 rental_period INT NOT NULL CHECK (rental_period > 0),
 student_id INT NOT NULL,
 instrument INT NOT NULL,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (id);


CREATE TABLE lesson_student_history (
 id SERIAL NOT NULL,
 lesson_date DATE NOT NULL,
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE lesson_student_history ADD CONSTRAINT PK_lesson_student_history PRIMARY KEY (id);


CREATE TABLE payment (
 id SERIAL NOT NULL,
 total_price DECIMAL(10) NOT NULL,
 student_id INT NOT NULL,
 date DATE,
 pricing_scheme_id INT NOT NULL,
 status VARCHAR(10) NOT NULL CHECK (status IN ('PAID', 'PENDING'))
);

ALTER TABLE payment ADD CONSTRAINT PK_payment PRIMARY KEY (id);


CREATE TABLE sibling_group (
 student_id INT NOT NULL,
 group_number VARCHAR(500) NOT NULL
);

ALTER TABLE sibling_group ADD CONSTRAINT PK_sibling_group PRIMARY KEY (student_id,group_number);


ALTER TABLE instructor_available ADD CONSTRAINT FK_instructor_available_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE instructor_lesson ADD CONSTRAINT FK_instructor_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE instructor_lesson ADD CONSTRAINT FK_instructor_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (instrument) REFERENCES instrument (id);


ALTER TABLE lesson_student_history ADD CONSTRAINT FK_lesson_student_history_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE lesson_student_history ADD CONSTRAINT FK_lesson_student_history_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE payment ADD CONSTRAINT FK_payment_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE payment ADD CONSTRAINT FK_payment_1 FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme (id);


ALTER TABLE sibling_group ADD CONSTRAINT FK_sibling_group_0 FOREIGN KEY (student_id) REFERENCES student (id);


