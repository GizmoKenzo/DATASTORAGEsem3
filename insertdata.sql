
INSERT INTO instructor (id, person_number, first_name, last_name, level_of_skill, address, phone, email)
VALUES
(1, '301415', 'Aaron', 'Smith', 'ADVANCED', '123 Main St', '0765753917', 'aaron@example.com'),
(2, '311415', 'Melinda', 'Gates', 'BEGINNER', '456 Elm St', '075653197', 'melinda@example.com'),
(3, '321415', 'Simon', 'Cowell', 'INTERMEDIATE', '789 Oak St', '0745753918', 'simon@example.com'),
(4, '331416', 'Jessica', 'Alba', 'ADVANCED', '999 Willow St', '0768888888', 'jessica@example.com'),
(5, '341417', 'Chris', 'Evans', 'INTERMEDIATE', '1010 Cedar Ave', '0779999999', 'chris@example.com');

INSERT INTO instructor_available (id, available_start, available_end, instructor_id)
VALUES
(1, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 1),
(2, '2025-01-02 10:00:00', '2025-01-02 18:00:00', 2),
(3, '2025-01-03 12:00:00', '2025-01-03 20:00:00', 3),
(4, '2025-01-04 08:00:00', '2025-01-04 16:00:00', 4),
(5, '2025-01-05 13:00:00', '2025-01-05 19:00:00', 5);

INSERT INTO instrument (id, type, brand, quantity_in_stock)
VALUES
(1, 'Guitar', 'Fender', 10),
(2, 'Piano', 'Yamaha', 9),
(3, 'Drums', 'Pearl', 8),
(4, 'Violin', 'Stradivarius', 7),
(5, 'Flute', 'Yamaha', 6),
(6, 'Trumpet', 'Bach', 5),
(7, 'Saxophone', 'Selmer', 4);

INSERT INTO lesson (id, appointment_time, scheduled_time, instrument, level_of_skill, lesson_type, maximum_of_students, minimum_of_students, genre, instructor_id)
VALUES
(1, '2025-01-05 10:00:00', NULL, 'Guitar', 'BEGINNER', 'INDIVIDUAL', NULL, NULL, NULL, 1),
(2, NULL, '2025-01-08 16:00:00', 'Drums', 'ADVANCED', 'ENSEMBLE', 8, 4, 'Rock', 3), -- no seats left
(3, NULL, '2025-01-10 10:00:00', 'Guitar', 'BEGINNER', 'GROUP', 10, 5, NULL, 1),
(4, NULL, '2025-01-10 14:00:00', 'Violin', 'ADVANCED', 'ENSEMBLE', 8, 4, 'Classical', 4), -- 1 or 2 seats left
(5, '2025-01-11 14:00:00', NULL, 'Piano', 'INTERMEDIATE', 'INDIVIDUAL', NULL, NULL, NULL, 2),
(6, NULL, '2025-01-12 11:00:00', 'Flute', 'BEGINNER', 'ENSEMBLE', 10, 5, 'Jazz', 5), -- Many seats left
(7, NULL, '2025-01-13 16:00:00', 'Drums', 'ADVANCED', 'ENSEMBLE', 8, 4, 'Rock', 3),
(8, NULL, '2025-01-15 11:00:00', 'Violin', 'ADVANCED', 'GROUP', 6, 3, NULL, 4),
(9, NULL, '2025-01-15 16:00:00', 'Drums', 'ADVANCED', 'ENSEMBLE', 8, 4, 'Rock', 3),
(10, '2025-01-16 14:30:00', NULL, 'Flute', 'BEGINNER', 'INDIVIDUAL', NULL, NULL, NULL, 5),
(11, NULL, '2025-01-17 13:00:00', 'Saxophone', 'INTERMEDIATE', 'ENSEMBLE', 5, 3, 'Jazz', 1),
(12, NULL, '2025-01-18 10:00:00', 'Trumpet', 'BEGINNER', 'GROUP', 12, 6, NULL, 3),

(13, '2025-02-05 11:00:00', NULL, 'Violin', 'BEGINNER', 'INDIVIDUAL', NULL, NULL, NULL, 4),
(14, NULL, '2025-02-10 15:00:00', 'Flute', 'ADVANCED', 'ENSEMBLE', 5, 2, 'Pop', 5),
(15, NULL, '2025-02-20 13:00:00', 'Saxophone', 'INTERMEDIATE', 'GROUP', 6, 3, NULL, 1),

(16, '2025-03-01 09:00:00', NULL, 'Trumpet', 'BEGINNER', 'INDIVIDUAL', NULL, NULL, NULL, 2),
(17, NULL, '2025-03-15 11:00:00', 'Piano', 'INTERMEDIATE', 'ENSEMBLE', 10, 5, 'Classical', 3),
(18, NULL, '2025-03-25 14:00:00', 'Drums', 'ADVANCED', 'GROUP', 8, 4, NULL, 4);

INSERT INTO pricing_scheme (id, lesson_type, level_of_skill, sibling_discount)
VALUES
(1, 'GROUP', 'BEGINNER', 10),
(2, 'INDIVIDUAL', 'INTERMEDIATE', 20),
(3, 'ENSEMBLE', 'BEGINNER', 10),
(4, 'GROUP', 'ADVANCED', 30),
(5, 'INDIVIDUAL', 'BEGINNER', 10),
(6, 'ENSEMBLE', 'INTERMEDIATE', 20);

INSERT INTO student (id, person_number, first_name, last_name, level_of_skill, address, phone, email)
VALUES
(1, '201020', 'Alfons', 'Berg', 'BEGINNER', '123 Pine St', '0735557890', 'alfons@example.com'),
(2, '213040', 'Emma', 'Tesked', 'INTERMEDIATE', '456 Maple St', '0775553210', 'emma@example.com'),
(3, '223560', 'Johanna', 'Panna', 'ADVANCED', '789 Birch St', '0759874567', 'johanna@example.com'),
(4, '201021', 'Pernilla', 'Wahlgren', 'BEGINNER', '555 Oak Lane', '0741234567', 'pernilla@example.com'),
(5, '201022', 'George', 'Clooney', 'INTERMEDIATE', '666 Elm Blvd', '0758765432', 'george@example.com'),
(6, '201023', 'Serena', 'Williams', 'BEGINNER', '777 Birch Ave', '0739876543', 'serena@example.com'),
(7, '214050', 'Anna', 'Anka', 'ADVANCED', '999 Maple St', '0769999999', 'anna@example.com'),
(8, '215060', 'Miley', 'Cyrus', 'BEGINNER', '888 Birch St', '0738888888', 'miley@example.com'); 

INSERT INTO booking (id, time_slots, student_id, lesson_id, classroom)
VALUES
(1, '2025-01-05 10:00:00', 1, 1, 'Room A'),
(2, '2025-01-10 10:00:00', 1, 5, 'Room A'),
(3, '2025-01-10 14:00:00', 2, 3, 'Room B'),
(4, '2025-01-11 14:00:00', 2, 4, 'Room B'),

-- Fully booked (8 students)
(5, '2025-01-08 16:00:00', 1, 2, 'Room C'),
(6, '2025-01-08 16:00:00', 2, 2, 'Room C'),
(7, '2025-01-08 16:00:00', 3, 2, 'Room C'),
(8, '2025-01-08 16:00:00', 4, 2, 'Room C'),
(9, '2025-01-08 16:00:00', 5, 2, 'Room C'),
(10, '2025-01-08 16:00:00', 6, 2, 'Room C'),
(11, '2025-01-08 16:00:00', 7, 2, 'Room C'),
(12, '2025-01-08 16:00:00', 8, 2, 'Room C'),

-- 1–2 seats left (4 bookings)
(13, '2025-01-10 14:00:00', 1, 4, 'Room D'),
(14, '2025-01-10 14:00:00', 2, 4, 'Room D'),
(15, '2025-01-10 14:00:00', 3, 4, 'Room D'),
(16, '2025-01-10 14:00:00', 4, 4, 'Room D'),
(17, '2025-01-10 14:00:00', 5, 4, 'Room D'),
(18, '2025-01-10 14:00:00', 6, 4, 'Room D'),

-- Many seats left (2 bookings)
(19, '2025-01-12 11:00:00', 1, 6, 'Room E'),
(20, '2025-01-12 11:00:00', 2, 6, 'Room E');

INSERT INTO contact_person (id, person_number, address, phone, email, student_id)
VALUES(1, '503132', '123 Cherry St', '0734561234', 'katri@example.com', 1),
(2, '512467', '456 Walnut St', '0776544321', 'elvira@example.com', 2),
(3, '537896', '789 Ash St', '0751239876', 'rebecca@example.com', 3),
(4, '547812', '222 Maple St', '0738765432', 'nora@example.com', 4),
(5, '512673', '333 Birch Rd', '0747654321', 'mike@example.com', 5),
(6, '532673', '333 Willow St', '0747654321', 'tor@example.com', 6);

INSERT INTO instructor_payment (id, amount_paid, payment_date, lesson_id, instructor_id)
VALUES
(1, 50.00, '2025-01-31', 1, 1),
(2, 75.00, '2025-02-01', 2, 2),
(3, 100.00, '2025-02-02', 3, 3),
(4, 60.00, '2025-02-03', 4, 4),
(5, 85.00, '2025-02-04', 5, 5),
(6, 50.00, '2025-02-05', 6, 1),
(7, 70.00, '2025-02-06', 7, 3);

INSERT INTO instrument_rental (id, rental_id, price_of_rental, rental_period, student_id, instrument, start_date, end_date)
VALUES (1, 'RENTAL001', 50.00, 1, 1, 1, '2025-01-01', '2025-01-31'),
(2, 'RENTAL002', 75.00, 2, 2, 2, '2025-01-01', '2025-02-28'),
(3, 'RENTAL003', 100.00, 1, 3, 3, '2025-01-15', '2025-01-31'),
(4, 'RENTAL004', 60.00, 1, 4, 4, '2025-01-10', '2025-01-31'),
(5, 'RENTAL005', 85.00, 3, 5, 5, '2025-01-01', '2025-03-31');

INSERT INTO lesson_student_history (id, lesson_date, lesson_id, student_id)
VALUES
(1, '2025-01-05', 1, 1),
(2, '2025-01-10', 2, 1),
(3, '2025-01-10', 3, 2),
(4, '2025-01-11', 4, 2),
(5, '2025-01-12', 5, 3),
(6, '2025-01-15', 6, 4),
(7, '2025-01-15', 7, 3),
(8, '2025-01-16', 8, 5),
(9, '2025-01-17', 9, 6),
(10, '2025-01-18', 10, 1),
(11, '2025-01-18', 10, 2),

(12, '2025-02-05', 11, 4),
(13, '2025-02-10', 12, 5),
(14, '2025-02-20', 13, 6),

(15, '2025-03-01', 14, 1),
(16, '2025-03-15', 15, 2),
(17, '2025-03-25', 16, 3);

INSERT INTO payment (id, total_price, student_id, date, pricing_scheme_id, status)
VALUES 
(1, 100.00, 1, '2025-01-31', 1, 'PAID'),
(2, 200.00, 2, '2025-01-31', 2, 'PAID'),
(3, 300.00, 3, '2025-01-31', 3, 'PAID'),
(4, 150.00, 4, '2025-01-31', 4, 'PAID'),
(5, 250.00, 5, '2025-01-31', 5, 'PAID'),
(6, 180.00, 6, '2025-01-31', 6, 'PAID'),
(7, 120.00, 2, '2025-02-28', 2, 'PAID'),
(8, 140.00, 3, '2025-02-28', 3, 'PAID'),
(9, 150.00, 4, '2025-02-28', 4, 'PAID'),
(10, 160.00, 5, '2025-03-31', 5, 'PAID'),
(11, 180.00, 6, '2025-03-31', 6, 'PAID');

INSERT INTO sibling_group (student_id, group_number)
VALUES 
(1, 'STUDENTGROUP001'), 
(2, 'STUDENTGROUP001'),
(5, 'STUDENTGROUP003'),
(6, 'STUDENTGROUP003'),
(7, 'STUDENTGROUP003');