
-- Drop tables if they exist
DROP TABLE effects CASCADE CONSTRAINTS;
DROP TABLE medicines CASCADE CONSTRAINTS;
DROP TABLE supplies CASCADE CONSTRAINTS;
DROP TABLE pharmacy CASCADE CONSTRAINTS;
DROP TABLE doctors CASCADE CONSTRAINTS;
DROP TABLE patients CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE order_items CASCADE CONSTRAINTS;
DROP TABLE prescriptions CASCADE CONSTRAINTS;
DROP TABLE prescription_medicines CASCADE CONSTRAINTS;

-- Create effects table
CREATE TABLE effects (
    effect_id INTEGER PRIMARY KEY,
    effect_name CHAR(20)
);

-- Create medicines table
CREATE TABLE medicines (
    medicine_id INTEGER PRIMARY KEY,
    generic_name CHAR(100),
    brand_name CHAR(100),
    dosage FLOAT,
    form_of_medicine CHAR(50),
    manufacturer CHAR(100),
    expiration_date DATE,
    quantity_in_stock INTEGER,
    price DECIMAL(10, 2)
);

-- Create supplies table
CREATE TABLE supplies (
    supplier_id INTEGER PRIMARY KEY,
    supplier_name CHAR(100),
    contact_information CHAR(150),
    payment_terms CHAR(100)
);

-- Create pharmacy table
CREATE TABLE pharmacy (
    pharmacy_id INTEGER PRIMARY KEY,
    pharmacy_name CHAR(100),
    location CHAR(150),
    contact_information CHAR(150)
);

-- Create doctors table
CREATE TABLE doctors (
    doctor_id INTEGER PRIMARY KEY,
    doctor_name CHAR(100),
    medical_license CHAR(50),
    specialty CHAR(100)
);

-- Create patients table
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY,
    patient_name CHAR(100),
    contact_information CHAR(150),
    insurance_information CHAR(150)
);

-- Create orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE,
    supplier_id INTEGER,
    pharmacy_id INTEGER,
    total_amount DECIMAL(10, 2),
    order_status CHAR(50),
    FOREIGN KEY (supplier_id) REFERENCES supplies(supplier_id),
    FOREIGN KEY (pharmacy_id) REFERENCES pharmacy(pharmacy_id)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    medicine_id INTEGER,
    quantity_ordered INTEGER,
    unit_price DECIMAL(10, 2),
    expected_expiration_date DATE,
    delivery_status CHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- Create prescriptions table
CREATE TABLE prescriptions (
    prescription_id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    doctor_id INTEGER,
    prescription_date DATE,
    quantity_prescribed INTEGER,
    refills_allowed INTEGER,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Create prescription_medicines table
CREATE TABLE prescription_medicines (
    prescription_id INTEGER,
    medicine_id INTEGER,
    quantity_prescribed INTEGER,
    PRIMARY KEY (prescription_id, medicine_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

ALTER TABLE medicines
ADD effect_id CHAR(5);

ALTER TABLE medicines
ADD CONSTRAINT fk_effect
FOREIGN KEY (effect_id) REFERENCES effects(effect_id);

ALTER TABLE medicines
MODIFY effect_id INTEGER;

ALTER TABLE effects
MODIFY effect_name CHAR(100);

prompt effects_inserts

INSERT INTO effects VALUES (1, 'Ameliorarea durerilor de cap');           -- 101: Paracetamol
INSERT INTO effects VALUES (2, 'Reducerea inflama?iilor ?i durerii');     -- 102: Ibuprofen
INSERT INTO effects VALUES (3, 'Ameliorarea durerilor intense');          -- 103: Metamizol Sodic
INSERT INTO effects VALUES (4, 'Tratamentul arsurilor gastrice');         -- 104: Omeprazol
INSERT INTO effects VALUES (5, 'Tratamentul diareei acute');              -- 105: Loperamid
INSERT INTO effects VALUES (6, 'Tratamentul infec?iilor bacteriene');     -- 106: Amoxicilinã
INSERT INTO effects VALUES (7, 'Tratamentul infec?iilor urinare');        -- 107: Ciprofloxacinã
INSERT INTO effects VALUES (8, 'Ameliorarea durerilor musculare');        -- 108: Diclofenac
INSERT INTO effects VALUES (9, 'Tratamentul ulcerelor gastrice');         -- 109: Ranitidinã
INSERT INTO effects VALUES (10, 'Tratamentul alergiilor sezoniere');      -- 110: Cetirizinã
INSERT INTO effects VALUES (11, 'Tratamentul astmului bron?ic');          -- 111: Salbutamol
INSERT INTO effects VALUES (12, 'Reglarea nivelului glicemiei');          -- 112: Insulinã Glargin
INSERT INTO effects VALUES (13, 'Scãderea colesterolului');               -- 113: Atorvastatinã
INSERT INTO effects VALUES (14, 'Reducerea inflama?iilor severe');        -- 114: Dexametazonã
INSERT INTO effects VALUES (15, 'Tratamentul durerilor articulare');      -- 115: Ketoprofen
INSERT INTO effects VALUES (16, 'Ameliorarea durerilor cronice');         -- 116: Naproxen
INSERT INTO effects VALUES (17, 'Tratamentul infec?iilor fungice');       -- 117: Fluconazol
INSERT INTO effects VALUES (18, 'Fluidificarea mucusului');               -- 118: Ambroxol
INSERT INTO effects VALUES (19, 'Tratamentul problemelor tiroidiene');    -- 119: Levotiroxinã
INSERT INTO effects VALUES (20, 'Tratamentul simptomelor Alzheimer');     -- 120: Rivastigminã
INSERT INTO effects VALUES (21, 'Reducerea durerilor inflamatorii');      -- 121: Ibuprofen Lysine
INSERT INTO effects VALUES (22, 'Tratamentul infec?iilor bacteriene');    -- 122: Augmentin
INSERT INTO effects VALUES (23, 'Tratamentul gre?urilor ?i vãrsãturilor');-- 123: Metoclopramid
INSERT INTO effects VALUES (24, 'Tratamentul inflama?iilor');             -- 124: Prednisolon
INSERT INTO effects VALUES (25, 'Eliminarea reten?iei de apã');           -- 125: Furosemid
INSERT INTO effects VALUES (26, 'Eliminarea excesului de apã');           -- 126: Hydrochlorothiazid
INSERT INTO effects VALUES (27, 'Reducerea durerilor de cap');            -- 127: Acid acetilsalicilic (Aspirin)
INSERT INTO effects VALUES (28, 'Tratamentul infec?iilor bacteriene');    -- 128: Bactrim
INSERT INTO effects VALUES (29, 'Tratamentul infec?iilor respiratorii');  -- 129: Claritromicinã
INSERT INTO effects VALUES (30, 'Tratamentul infec?iilor ORL');           -- 130: Azitromicinã
INSERT INTO effects VALUES (31, 'Tratamentul tuberculozei');              -- 131: Rifampicinã
INSERT INTO effects VALUES (32, 'Tratamentul infec?iilor fungice sistemice');-- 132: Amfotericinã B
INSERT INTO effects VALUES (33, 'Ameliorarea durerilor severe');          -- 133: Paracetamol + Codeinã
INSERT INTO effects VALUES (34, 'Tratamentul infec?iilor bacteriene');    -- 134: Tetraciclinã
INSERT INTO effects VALUES (35, 'Reducerea inflama?iilor ?i durerii');    -- 135: Hydrocortizon
INSERT INTO effects VALUES (36, 'Scãderea colesterolului');               -- 136: Fenofibrat
INSERT INTO effects VALUES (37, 'Tratamentul infec?iilor parazitare');    -- 137: Mebendazol
INSERT INTO effects VALUES (38, 'Tratamentul alergiilor severe');         -- 138: Cetirizinã Dihidroclorid
INSERT INTO effects VALUES (39, 'Tratamentul alergiilor cronice');        -- 139: Levocetirizinã
INSERT INTO effects VALUES (40, 'Ameliorarea durerilor articulare');      -- 140: Indometacin
INSERT INTO effects VALUES (41, 'Tratamentul infec?iilor bacteriene');    -- 141: Doxiciclinã
INSERT INTO effects VALUES (42, 'Tratamentul ulcerelor stomacale');       -- 142: Lansoprazol
INSERT INTO effects VALUES (43, 'Tratamentul refluxului gastric');        -- 143: Esomeprazol
INSERT INTO effects VALUES (44, 'Scãderea colesterolului');               -- 144: Simvastatinã
INSERT INTO effects VALUES (45, 'Scãderea colesterolului');               -- 145: Rosuvastatinã
INSERT INTO effects VALUES (46, 'Tratamentul alergiilor cronice');        -- 146: Fexofenadinã
INSERT INTO effects VALUES (47, 'Tratamentul astmului bron?ic');          -- 147: Montelukast
INSERT INTO effects VALUES (48, 'Scãderea tensiunii arteriale');          -- 148: Metoprolol
INSERT INTO effects VALUES (49, 'Scãderea tensiunii arteriale');          -- 149: Amlodipinã
INSERT INTO effects VALUES (50, 'Scãderea tensiunii arteriale');          -- 150: Ramipril

DELETE FROM effects;

prompt medicines_inserts

INSERT INTO medicines VALUES (101, 'Paracetamol', 'Parasinus', 500, 'Comprimate', 'Terapia', TO_DATE('2025-12-31', 'YYYY-MM-DD'), 200, 5.50, 1);
INSERT INTO medicines VALUES (102, 'Ibuprofen', 'Nurofen Forte', 400, 'Capsule', 'Reckitt Benckiser', TO_DATE('2025-11-30', 'YYYY-MM-DD'), 150, 12.75, 2);
INSERT INTO medicines VALUES (103, 'Metamizol Sodic', 'Algocalmin', 500, 'Solutie', 'Zentiva', TO_DATE('2026-01-15', 'YYYY-MM-DD'), 300, 15.00, 3);
INSERT INTO medicines VALUES (104, 'Omeprazol', 'Omez', 20, 'Capsule', 'Krka', TO_DATE('2025-10-01', 'YYYY-MM-DD'), 120, 8.50, 4);
INSERT INTO medicines VALUES (105, 'Loperamid', 'Imodium', 2, 'Capsule', 'Johnson and Johnson', TO_DATE('2025-06-01', 'YYYY-MM-DD'), 180, 6.25, 5);
INSERT INTO medicines VALUES (106, 'Amoxicilina', 'Amoxil', 250, 'Capsule', 'Pfizer', TO_DATE('2026-02-01', 'YYYY-MM-DD'), 100, 10.00, 6);
INSERT INTO medicines VALUES (107, 'Ciprofloxacina', 'Cipro', 500, 'Comprimate', 'Bayer', TO_DATE('2025-09-15', 'YYYY-MM-DD'), 80, 12.00, 7);
INSERT INTO medicines VALUES (108, 'Diclofenac', 'Diclac', 75, 'Gel', 'Sandoz', TO_DATE('2025-08-01', 'YYYY-MM-DD'), 150, 7.50, 8);
INSERT INTO medicines VALUES (109, 'Ranitidina', 'Ranidil', 150, 'Comprimate', 'Antibiotice Iasi', TO_DATE('2026-01-01', 'YYYY-MM-DD'), 90, 4.50, 4);
INSERT INTO medicines VALUES (110, 'Cetirizina', 'Zyrtec', 10, 'Comprimate', 'Johnson and Johnson', TO_DATE('2025-07-01', 'YYYY-MM-DD'), 200, 3.50, 9);
INSERT INTO medicines VALUES (111, 'Salbutamol', 'Ventolin', 100, 'Inhalator', 'GSK', TO_DATE('2025-12-01', 'YYYY-MM-DD'), 50, 22.00, 10);
INSERT INTO medicines VALUES (112, 'Insulina Glargin', 'Lantus', 100, 'Injectabil', 'Sanofi', TO_DATE('2026-03-01', 'YYYY-MM-DD'), 60, 120.00, 11);
INSERT INTO medicines VALUES (113, 'Atorvastatina', 'Sortis', 20, 'Comprimate', 'Pfizer', TO_DATE('2026-02-28', 'YYYY-MM-DD'), 150, 18.00, 12);
INSERT INTO medicines VALUES (114, 'Dexametazona', 'Dexamed', 4, 'Comprimate', 'Terapia', TO_DATE('2025-09-30', 'YYYY-MM-DD'), 70, 10.50, 2);
INSERT INTO medicines VALUES (115, 'Ketoprofen', 'Ketonal', 100, 'Capsule', 'Sandoz', TO_DATE('2025-08-31', 'YYYY-MM-DD'), 110, 9.75, 8);
INSERT INTO medicines VALUES (116, 'Naproxen', 'Naproxen Forte', 500, 'Comprimate', 'Pfizer', TO_DATE('2026-05-01', 'YYYY-MM-DD'), 85, 12.25, 8);
INSERT INTO medicines VALUES (117, 'Fluconazol', 'Diflucan', 150, 'Capsule', 'Pfizer', TO_DATE('2026-04-01', 'YYYY-MM-DD'), 70, 15.25, 7);
INSERT INTO medicines VALUES (118, 'Ambroxol', 'Mucosolvan', 30, 'Sirop', 'Boehringer', TO_DATE('2025-06-15', 'YYYY-MM-DD'), 130, 8.00, 13);
INSERT INTO medicines VALUES (119, 'Levotiroxina', 'Euthyrox', 50, 'Comprimate', 'Merck', TO_DATE('2026-07-01', 'YYYY-MM-DD'), 250, 6.00, 14);
INSERT INTO medicines VALUES (120, 'Rivastigmina', 'Exelon', 4.6, 'Patch', 'Novartis', TO_DATE('2025-10-01', 'YYYY-MM-DD'), 60, 50.00, 15);
INSERT INTO medicines VALUES (121, 'Ibuprofen Lysine', 'Nurofen Rapid', 200, 'Capsule moi', 'Reckitt Benckiser', TO_DATE('2025-10-10', 'YYYY-MM-DD'), 120, 13.50, 2);
INSERT INTO medicines VALUES (122, 'Amoxicilina + Clavulanat', 'Augmentin', 625, 'Comprimate', 'GSK', TO_DATE('2026-02-20', 'YYYY-MM-DD'), 95, 20.00, 6);
INSERT INTO medicines VALUES (123, 'Metoclopramid', 'Reglan', 10, 'Comprimate', 'Terapia', TO_DATE('2026-01-10', 'YYYY-MM-DD'), 80, 5.25, 5);
INSERT INTO medicines VALUES (124, 'Prednisolon', 'Prednison', 5, 'Comprimate', 'Sanofi', TO_DATE('2025-12-20', 'YYYY-MM-DD'), 100, 6.75, 2);
INSERT INTO medicines VALUES (125, 'Furosemid', 'Lasix', 40, 'Comprimate', 'Sanofi', TO_DATE('2025-12-15', 'YYYY-MM-DD'), 90, 3.75, 16);
INSERT INTO medicines VALUES (126, 'Hydrochlorothiazid', 'Esidrix', 25, 'Comprimate', 'Pfizer', TO_DATE('2026-04-01', 'YYYY-MM-DD'), 85, 4.50, 16);
INSERT INTO medicines VALUES (127, 'Acid acetilsalicilic', 'Aspirin', 500, 'Comprimate', 'Bayer', TO_DATE('2025-11-15', 'YYYY-MM-DD'), 300, 5.00, 1);
INSERT INTO medicines VALUES (128, 'Sulfametoxazol + Trimetoprim', 'Bactrim', 800, 'Suspensie', 'Roche', TO_DATE('2025-12-10', 'YYYY-MM-DD'), 60, 9.00, 6);
INSERT INTO medicines VALUES (129, 'Claritromicina', 'Klacid', 500, 'Comprimate', 'Abbott', TO_DATE('2026-05-01', 'YYYY-MM-DD'), 50, 22.50, 6);
INSERT INTO medicines VALUES (130, 'Azitromicina', 'Zithromax', 250, 'Capsule', 'Pfizer', TO_DATE('2026-02-28', 'YYYY-MM-DD'), 100, 15.50, 6);
INSERT INTO medicines VALUES (131, 'Rifampicina', 'Rifadin', 300, 'Capsule', 'Sanofi', TO_DATE('2025-11-20', 'YYYY-MM-DD'), 70, 18.00, 7);
INSERT INTO medicines VALUES (132, 'Amfotericina B', 'Fungizone', 50, 'Injectabil', 'Bristol-Myers Squibb', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 40, 50.00, 7);
INSERT INTO medicines VALUES (133, 'Paracetamol + Codeinã', 'Panadol Extra', 500, 'Comprimate', 'GSK', TO_DATE('2026-03-15', 'YYYY-MM-DD'), 200, 10.50, 1);
INSERT INTO medicines VALUES (134, 'Tetraciclina', 'Sumycin', 250, 'Capsule', 'Pfizer', TO_DATE('2026-05-10', 'YYYY-MM-DD'), 80, 12.25, 6);
INSERT INTO medicines VALUES (135, 'Hydrocortizon', 'Cortef', 20, 'Comprimate', 'Pfizer', TO_DATE('2025-08-20', 'YYYY-MM-DD'), 150, 5.75, 2);
INSERT INTO medicines VALUES (136, 'Fenofibrat', 'Lipanthyl', 145, 'Capsule', 'Abbott', TO_DATE('2026-04-15', 'YYYY-MM-DD'), 60, 23.00, 12);
INSERT INTO medicines VALUES (137, 'Mebendazol', 'Vermox', 100, 'Comprimate', 'Janssen', TO_DATE('2025-07-01', 'YYYY-MM-DD'), 90, 8.50, 7);
INSERT INTO medicines VALUES (138, 'Cetirizinã Dihidroclorid', 'Alerid', 10, 'Comprimate', 'Glenmark', TO_DATE('2025-10-01', 'YYYY-MM-DD'), 120, 3.25, 9);
INSERT INTO medicines VALUES (139, 'Levocetirizinã', 'Xyzal', 5, 'Comprimate', 'UCB Pharma', TO_DATE('2026-01-10', 'YYYY-MM-DD'), 150, 5.00, 9);
INSERT INTO medicines VALUES (140, 'Indometacin', 'Indocid', 25, 'Capsule', 'Pfizer', TO_DATE('2025-11-15', 'YYYY-MM-DD'), 70, 9.50, 8);
INSERT INTO medicines VALUES (141, 'Doxiciclina', 'Vibramycin', 100, 'Capsule', 'Pfizer', TO_DATE('2025-12-31', 'YYYY-MM-DD'), 80, 10.75, 6);
INSERT INTO medicines VALUES (142, 'Lansoprazol', 'Lanzul', 30, 'Capsule', 'Krka', TO_DATE('2026-02-20', 'YYYY-MM-DD'), 100, 6.50, 4);
INSERT INTO medicines VALUES (143, 'Esomeprazol', 'Nexium', 20, 'Capsule', 'AstraZeneca', TO_DATE('2026-03-30', 'YYYY-MM-DD'), 120, 9.00, 4);
INSERT INTO medicines VALUES (144, 'Simvastatinã', 'Zocor', 10, 'Comprimate', 'Merck', TO_DATE('2026-04-30', 'YYYY-MM-DD'), 200, 4.75, 12);
INSERT INTO medicines VALUES (145, 'Rosuvastatinã', 'Crestor', 20, 'Comprimate', 'AstraZeneca', TO_DATE('2026-05-15', 'YYYY-MM-DD'), 150, 16.50, 12);
INSERT INTO medicines VALUES (146, 'Fexofenadinã', 'Allegra', 120, 'Comprimate', 'Sanofi', TO_DATE('2026-02-28', 'YYYY-MM-DD'), 100, 11.00, 9);
INSERT INTO medicines VALUES (147, 'Montelukast', 'Singulair', 10, 'Comprimate', 'Merck', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 80, 7.25, 10);
INSERT INTO medicines VALUES (148, 'Metoprolol', 'Betaloc', 50, 'Comprimate', 'AstraZeneca', TO_DATE('2025-10-20', 'YYYY-MM-DD'), 90, 6.75, 13);
INSERT INTO medicines VALUES (149, 'Amlodipinã', 'Norvasc', 5, 'Comprimate', 'Pfizer', TO_DATE('2025-12-01', 'YYYY-MM-DD'), 150, 4.25, 13);
INSERT INTO medicines VALUES (150, 'Ramipril', 'Tritace', 10, 'Comprimate', 'Sanofi', TO_DATE('2026-01-15', 'YYYY-MM-DD'), 100, 5.50, 13);

DELETE FROM medicines;

prompt supplies_inserts

INSERT INTO supplies VALUES (201, 'Terapia', 'contact@terapia.ro, +40 123 456 789', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (202, 'Reckitt Benckiser', 'contact@rb.com, +44 987 654 321', 'Platã în avans');
INSERT INTO supplies VALUES (203, 'Zentiva', 'contact@zentiva.com, +33 123 321 456', 'Platã în 45 de zile');
INSERT INTO supplies VALUES (204, 'Krka', 'info@krka.com, +386 123 456 789', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (205, 'Johnson and Johnson', 'info@jnj.com, +1 555 123 4567', 'Platã la livrare');
INSERT INTO supplies VALUES (206, 'Pfizer', 'sales@pfizer.com, +1 800 555 0199', 'Platã în 60 de zile');
INSERT INTO supplies VALUES (207, 'Bayer', 'contact@bayer.com, +49 555 789 123', 'Platã în avans');
INSERT INTO supplies VALUES (208, 'Sandoz', 'info@sandoz.com, +41 987 654 321', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (209, 'Antibiotice Ia?i', 'office@antibiotice.ro, +40 232 123 456', 'Platã în 45 de zile');
INSERT INTO supplies VALUES (210, 'GSK', 'contact@gsk.com, +44 123 456 7890', 'Platã la livrare');
INSERT INTO supplies VALUES (211, 'Sanofi', 'contact@sanofi.com, +33 555 321 123', 'Platã în avans');
INSERT INTO supplies VALUES (212, 'Boehringer', 'sales@boehringer.com, +49 800 321 456', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (213, 'Merck', 'info@merck.com, +1 987 123 4567', 'Platã în 60 de zile');
INSERT INTO supplies VALUES (214, 'Novartis', 'info@novartis.com, +41 800 456 789', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (215, 'Abbott', 'sales@abbott.com, +1 800 654 3210', 'Platã la livrare');
INSERT INTO supplies VALUES (216, 'Roche', 'contact@roche.com, +41 555 123 987', 'Platã în avans');
INSERT INTO supplies VALUES (217, 'Bristol-Myers Squibb', 'info@bms.com, +1 877 987 6543', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (218, 'Janssen', 'sales@janssen.com, +1 888 456 7890', 'Platã în 45 de zile');
INSERT INTO supplies VALUES (219, 'Glenmark', 'info@glenmark.com, +91 123 456 7890', 'Platã la livrare');
INSERT INTO supplies VALUES (220, 'UCB Pharma', 'contact@ucb.com, +32 987 654 321', 'Platã în avans');
INSERT INTO supplies VALUES (221, 'AstraZeneca', 'contact@astrazeneca.com, +44 321 654 987', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (222, 'Teva Pharmaceuticals', 'info@teva.com, +972 123 456 789', 'Platã în 60 de zile');
INSERT INTO supplies VALUES (223, 'Mylan', 'sales@mylan.com, +1 321 456 7890', 'Platã la livrare');
INSERT INTO supplies VALUES (224, 'Sun Pharma', 'contact@sunpharma.com, +91 987 654 3210', 'Platã în 45 de zile');
INSERT INTO supplies VALUES (225, 'Takeda', 'sales@takeda.com, +81 123 456 7890', 'Platã în avans');
INSERT INTO supplies VALUES (226, 'Lilly', 'info@lilly.com, +1 800 987 6543', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (227, 'Amgen', 'contact@amgen.com, +1 888 321 6540', 'Platã în 60 de zile');
INSERT INTO supplies VALUES (228, 'Cipla', 'sales@cipla.com, +91 123 456 7890', 'Platã în avans');
INSERT INTO supplies VALUES (229, 'Biocon', 'info@biocon.com, +91 987 654 1230', 'Platã în 45 de zile');
INSERT INTO supplies VALUES (230, 'Fresenius Kabi', 'sales@fresenius-kabi.com, +49 800 654 3210', 'Platã la livrare');
INSERT INTO supplies VALUES (231, 'Novo Nordisk', 'info@novonordisk.com, +45 123 456 789', 'Platã în avans');
INSERT INTO supplies VALUES (232, 'Alkem Laboratories', 'contact@alkem.com, +91 800 123 4567', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (233, 'Zydus Cadila', 'info@zydus.com, +91 123 987 6540', 'Platã în 60 de zile');
INSERT INTO supplies VALUES (234, 'Hikma', 'sales@hikma.com, +44 654 321 9870', 'Platã în avans');
INSERT INTO supplies VALUES (235, 'Dr. Reddy''s', 'contact@drreddys.com, +91 987 456 1230', 'Platã la livrare');
INSERT INTO supplies VALUES (236, 'Mallinckrodt', 'info@mallinckrodt.com, +1 800 321 6540', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (237, 'Actavis', 'contact@actavis.com, +1 123 456 7890', 'Platã în avans');
INSERT INTO supplies VALUES (238, 'Apotex', 'info@apotex.com, +1 800 654 3210', 'Platã în 60 de zile');
INSERT INTO supplies VALUES (239, 'Perrigo', 'sales@perrigo.com, +1 800 123 6540', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (240, 'Bausch Health', 'info@bauschhealth.com, +1 888 456 3210', 'Platã la livrare');
INSERT INTO supplies VALUES (241, 'Lupin', 'contact@lupin.com, +91 800 654 1234', 'Platã în avans');
INSERT INTO supplies VALUES (242, 'Vertex Pharmaceuticals', 'sales@vrtx.com, +1 888 654 3210', 'Platã în 45 de zile');
INSERT INTO supplies VALUES (243, 'Chiesi', 'contact@chiesi.com, +39 987 654 3210', 'Platã în avans');
INSERT INTO supplies VALUES (244, 'Ipsen', 'info@ipsen.com, +33 800 456 7890', 'Platã în 30 de zile');
INSERT INTO supplies VALUES (245, 'Orion Pharma', 'sales@orionpharma.com, +358 123 456 7890', 'Platã la livrare');
INSERT INTO supplies VALUES (246, 'Pharmstandard', 'info@pharmstd.com, +7 800 456 3210', 'Platã în avans');
INSERT INTO supplies VALUES (247, 'R-Pharm', 'contact@rpharm.com, +7 123 456 7890', 'Platã în 60 de zile');
INSERT INTO supplies VALUES (248, 'Medtronic', 'sales@medtronic.com, +1 800 123 4567', 'Platã în avans');
INSERT INTO supplies VALUES (249, 'Samsung Bioepis', 'info@samsungbioepis.com, +82 987 654 3210', 'Platã în 45 de zile');
INSERT INTO supplies VALUES (250, 'BionTech', 'contact@biontech.com, +49 123 456 7890', 'Platã la livrare');

DELETE FROM supplies;

prompt pharmacy_inserts

INSERT INTO pharmacy VALUES (301, 'Farmacia Dona', 'Strada Mihai Eminescu 12, Bucure?ti', '021-123-4567');
INSERT INTO pharmacy VALUES (302, 'Catena', 'Strada Victoriei 45, Cluj-Napoca', '0264-789-123');
INSERT INTO pharmacy VALUES (303, 'Sensiblu', 'Bulevardul Independen?ei 10, Ia?i', '0232-123-456');
INSERT INTO pharmacy VALUES (304, 'Help Net', 'Strada ?tefan cel Mare 20, Bra?ov', '0268-456-789');
INSERT INTO pharmacy VALUES (305, 'Farmacia Tei', 'Strada Drumul Taberei 50, Bucure?ti', '021-555-1234');
INSERT INTO pharmacy VALUES (306, 'Farmacia Richter', 'Strada Alexandru Ioan Cuza 14, Timi?oara', '0256-789-456');
INSERT INTO pharmacy VALUES (307, 'Farmacia Belladonna', 'Strada Libertã?ii 21, Constan?a', '0241-321-654');
INSERT INTO pharmacy VALUES (308, 'Plafar', 'Strada Unirii 5, Craiova', '0251-654-321');
INSERT INTO pharmacy VALUES (309, 'PharmaLand', 'Strada Universitã?ii 33, Sibiu', '0269-987-123');
INSERT INTO pharmacy VALUES (310, 'EcoFarmacia', 'Strada Avram Iancu 60, Oradea', '0259-321-789');
INSERT INTO pharmacy VALUES (311, 'Farmacia Ardealul', 'Strada Mihai Viteazul 15, Arad', '0257-789-456');
INSERT INTO pharmacy VALUES (312, 'PharmaPlus', 'Strada Revolu?iei 32, Ploie?ti', '0244-123-987');
INSERT INTO pharmacy VALUES (313, 'Maxi Farma', 'Strada George Co?buc 10, Gala?i', '0236-456-321');
INSERT INTO pharmacy VALUES (314, 'Farmacia Minerva', 'Strada Tudor Vladimirescu 7, Pite?ti', '0248-789-654');
INSERT INTO pharmacy VALUES (315, 'Farmacia Sanatatea', 'Strada Trandafirilor 8, Bacãu', '0234-987-654');
INSERT INTO pharmacy VALUES (316, 'HyperFarma', 'Bulevardul Dacia 100, Suceava', '0230-654-321');
INSERT INTO pharmacy VALUES (317, 'City Pharma', 'Strada Republicii 25, Buzãu', '0238-123-654');
INSERT INTO pharmacy VALUES (318, 'Farmacia Alfa', 'Strada Doroban?ilor 15, Brãila', '0239-321-987');
INSERT INTO pharmacy VALUES (319, 'Beta Pharma', 'Strada Primãverii 40, Satu Mare', '0261-123-789');
INSERT INTO pharmacy VALUES (320, 'Gamma Med', 'Strada Cri?an 11, Baia Mare', '0262-456-123');
INSERT INTO pharmacy VALUES (321, 'Farmacia Terra', 'Strada Horea 19, Târgu Mure?', '0265-654-789');
INSERT INTO pharmacy VALUES (322, 'Omega Pharma', 'Strada Tineretului 28, Alba Iulia', '0258-987-321');
INSERT INTO pharmacy VALUES (323, 'VitalFarma', 'Strada ?colii 5, Deva', '0254-321-456');
INSERT INTO pharmacy VALUES (324, 'Farmacia Natura', 'Strada Stadionului 17, Foc?ani', '0237-456-987');
INSERT INTO pharmacy VALUES (325, 'Mega Pharma', 'Bulevardul Ferdinand 29, Bistri?a', '0263-789-123');
INSERT INTO pharmacy VALUES (326, 'MedicoFarm', 'Strada Energiei 50, Tulcea', '0240-987-654');
INSERT INTO pharmacy VALUES (327, 'Farmacia Gloria', 'Strada Libertã?ii 88, Târgu Jiu', '0253-321-987');
INSERT INTO pharmacy VALUES (328, 'PharmaZone', 'Strada Zorilor 12, Piatra Neam?', '0233-654-789');
INSERT INTO pharmacy VALUES (329, 'Farmacia Apuseni', 'Strada Mare?al Averescu 9, Zalãu', '0260-987-321');
INSERT INTO pharmacy VALUES (330, 'BioFarma', 'Strada Principalã 77, Bârlad', '0235-456-123');
INSERT INTO pharmacy VALUES (331, 'Farmacia Viitorul', 'Strada Fabricii 13, Giurgiu', '0246-321-654');
INSERT INTO pharmacy VALUES (332, 'Farmacia Medico', 'Strada Mãrã?e?ti 20, Re?i?a', '0255-654-321');
INSERT INTO pharmacy VALUES (333, 'Farmacia Etalon', 'Strada Spicului 5, Cãlãra?i', '0242-987-123');
INSERT INTO pharmacy VALUES (334, 'Vital Med', 'Strada Speran?ei 11, Slatina', '0249-321-789');
INSERT INTO pharmacy VALUES (335, 'Farmacia Dr. Max', 'Strada Dr. Victor Babe? 19, Hunedoara', '0254-789-321');
INSERT INTO pharmacy VALUES (336, 'Farmacia Sãnãtate Plus', 'Strada Mihai Bravu 50, Alexandria', '0247-123-456');
INSERT INTO pharmacy VALUES (337, 'City Farma', 'Strada Mihail Sadoveanu 18, Slobozia', '0243-456-789');
INSERT INTO pharmacy VALUES (338, 'Farmacia Nouã', 'Strada Verde 8, Vaslui', '0235-987-321');
INSERT INTO pharmacy VALUES (339, 'Farmacia Rapid', 'Strada Independen?ei 35, Sfântu Gheorghe', '0267-321-654');
INSERT INTO pharmacy VALUES (340, 'Farmacia Universal', 'Strada Nouã 12, Miercurea Ciuc', '0266-654-789');
INSERT INTO pharmacy VALUES (341, 'PharmaMed', 'Strada Târgului 20, Sighetu Marma?iei', '0262-789-654');
INSERT INTO pharmacy VALUES (342, 'Farmacia Familia', 'Strada Grivi?ei 44, Roman', '0233-321-987');
INSERT INTO pharmacy VALUES (343, 'Farmacia Eficient', 'Strada Petru Rare? 14, Drobeta-Turnu Severin', '0252-456-321');
INSERT INTO pharmacy VALUES (344, 'Farmacia Practic', 'Strada Buzãului 9, Tulcea', '0240-654-987');
INSERT INTO pharmacy VALUES (345, 'Farmacia Clinic', 'Strada Speran?ei 5, Caracal', '0249-321-654');
INSERT INTO pharmacy VALUES (346, 'Farmacia Medica', 'Strada Primãriei 12, Horezu', '0253-987-456');
INSERT INTO pharmacy VALUES (347, 'Farmacia Salvare', 'Strada Cetã?ii 8, Râmnicu Vâlcea', '0250-321-123');
INSERT INTO pharmacy VALUES (348, 'Farmacia Horizon', 'Strada Dealului 33, Curtea de Arge?', '0248-654-321');
INSERT INTO pharmacy VALUES (349, 'Farmacia Vitalis', 'Strada Principalã 1, Fete?ti', '0243-789-654');
INSERT INTO pharmacy VALUES (350, 'Farmacia Litoral', 'Strada Portului 99, Mangalia', '0241-321-987');

DELETE FROM pharmacy;

prompt doctors_inserts

INSERT INTO doctors VALUES (401, 'Dr. Ion Popescu', 123456, 'Cardiologie');
INSERT INTO doctors VALUES (402, 'Dr. Elena Ionescu', 123457, 'Pediatrie');
INSERT INTO doctors VALUES (403, 'Dr. Mihai Vasilescu', 123458, 'Chirurgie Generalã');
INSERT INTO doctors VALUES (404, 'Dr. Andrei Dumitru', 123459, 'Dermatologie');
INSERT INTO doctors VALUES (405, 'Dr. Ioana Matei', 123460, 'Oncologie');
INSERT INTO doctors VALUES (406, 'Dr. Radu Iliescu', 123461, 'Neurologie');
INSERT INTO doctors VALUES (407, 'Dr. Ana Popa', 123462, 'Psihiatrie');
INSERT INTO doctors VALUES (408, 'Dr. Sorin Petrescu', 123463, 'Ortopedie');
INSERT INTO doctors VALUES (409, 'Dr. Vasile Munteanu', 123464, 'Endocrinologie');
INSERT INTO doctors VALUES (410, 'Dr. Maria Andrei', 123465, 'Oftalmologie');
INSERT INTO doctors VALUES (411, 'Dr. Cristian Rusu', 123466, 'Gastroenterologie');
INSERT INTO doctors VALUES (412, 'Dr. Alina Mihailescu', 123467, 'Reumatologie');
INSERT INTO doctors VALUES (413, 'Dr. Teodor Costache', 123468, 'Urologie');
INSERT INTO doctors VALUES (414, 'Dr. Gabriela Neagu', 123469, 'Medicinã de Familie');
INSERT INTO doctors VALUES (415, 'Dr. Daniel Tudor', 123470, 'Cardiologie');
INSERT INTO doctors VALUES (416, 'Dr. Monica Ene', 123471, 'Pediatrie');
INSERT INTO doctors VALUES (417, 'Dr. Florin Gheorghe', 123472, 'Chirurgie Toracicã');
INSERT INTO doctors VALUES (418, 'Dr. Raluca Voicu', 123473, 'Nefrologie');
INSERT INTO doctors VALUES (419, 'Dr. Marius Stan', 123474, 'Anestezie ?i Terapie Intensivã');
INSERT INTO doctors VALUES (420, 'Dr. Alexandra Dumitrescu', 123475, 'Medicinã Internã');
INSERT INTO doctors VALUES (421, 'Dr. Petru Bãlan', 123476, 'Oncologie');
INSERT INTO doctors VALUES (422, 'Dr. Laura Oprea', 123477, 'Radiologie');
INSERT INTO doctors VALUES (423, 'Dr. Adrian Marin', 123478, 'Geriatrie');
INSERT INTO doctors VALUES (424, 'Dr. Simona Dinu', 123479, 'Psihiatrie');
INSERT INTO doctors VALUES (425, 'Dr. Cãtãlin Iancu', 123480, 'Ortopedie');
INSERT INTO doctors VALUES (426, 'Dr. Paula Nistor', 123481, 'Cardiologie');
INSERT INTO doctors VALUES (427, 'Dr. Andreea Voineagu', 123482, 'Medicinã de Urgen?ã');
INSERT INTO doctors VALUES (428, 'Dr. Valeriu Popescu', 123483, 'Chirurgie Plasticã');
INSERT INTO doctors VALUES (429, 'Dr. Emilia Iftimie', 123484, 'Oftalmologie');
INSERT INTO doctors VALUES (430, 'Dr. Marcel Rãdulescu', 123485, 'Neurologie');
INSERT INTO doctors VALUES (431, 'Dr. Roxana Damian', 123486, 'Medicinã Internã');
INSERT INTO doctors VALUES (432, 'Dr. ?tefan Cristea', 123487, 'Endocrinologie');
INSERT INTO doctors VALUES (433, 'Dr. Livia Munteanu', 123488, 'Reumatologie');
INSERT INTO doctors VALUES (434, 'Dr. Sorina Pavel', 123489, 'Nefrologie');
INSERT INTO doctors VALUES (435, 'Dr. Mihnea Ciobanu', 123490, 'Anestezie ?i Terapie Intensivã');
INSERT INTO doctors VALUES (436, 'Dr. Andrada Tudor', 123491, 'Cardiologie');
INSERT INTO doctors VALUES (437, 'Dr. Radu Pãun', 123492, 'Chirurgie Generalã');
INSERT INTO doctors VALUES (438, 'Dr. Anca Popescu', 123493, 'Medicinã Internã');
INSERT INTO doctors VALUES (439, 'Dr. Nicolae Dumitrache', 123494, 'Ortopedie');
INSERT INTO doctors VALUES (440, 'Dr. Diana Stanciu', 123495, 'Psihiatrie');
INSERT INTO doctors VALUES (441, 'Dr. Vlad Ion', 123496, 'Dermatologie');
INSERT INTO doctors VALUES (442, 'Dr. Alin Marinescu', 123497, 'Medicinã de Urgen?ã');
INSERT INTO doctors VALUES (443, 'Dr. Camelia Gheorghiu', 123498, 'Cardiologie');
INSERT INTO doctors VALUES (444, 'Dr. Roxana Dumitru', 123499, 'Radiologie');
INSERT INTO doctors VALUES (445, 'Dr. Ionu? Vasile', 123500, 'Endocrinologie');
INSERT INTO doctors VALUES (446, 'Dr. Simona Tudorache', 123501, 'Gastroenterologie');
INSERT INTO doctors VALUES (447, 'Dr. Oana Cãlin', 123502, 'Chirurgie Plasticã');
INSERT INTO doctors VALUES (448, 'Dr. Bogdan Enescu', 123503, 'Medicinã Internã');
INSERT INTO doctors VALUES (449, 'Dr. Adriana Pintea', 123504, 'Reumatologie');
INSERT INTO doctors VALUES (450, 'Dr. Rãzvan Popovici', 123505, 'Chirurgie Generalã');

DELETE FROM doctors;

prompt patients_inserts

INSERT INTO patients VALUES (501, 'Popescu Ion', 'ion.popescu@example.com, +40 721 123 456', 'Allianz 123456789');
INSERT INTO patients VALUES (502, 'Ionescu Maria', 'maria.ionescu@example.com, +40 722 234 567', 'Signal Iduna 987654321');
INSERT INTO patients VALUES (503, 'Vasilescu Mihai', 'mihai.vasilescu@example.com, +40 723 345 678', 'Uniqa 456789123');
INSERT INTO patients VALUES (504, 'Dumitru Elena', 'elena.dumitru@example.com, +40 724 456 789', 'Omniasig 789123456');
INSERT INTO patients VALUES (505, 'Matei Andrei', 'andrei.matei@example.com, +40 725 567 890', 'Generali 654321987');
INSERT INTO patients VALUES (506, 'Iliescu Ana', 'ana.iliescu@example.com, +40 726 678 901', 'Asirom 123789456');
INSERT INTO patients VALUES (507, 'Popa Radu', 'radu.popa@example.com, +40 727 789 012', 'Groupama 987321654');
INSERT INTO patients VALUES (508, 'Petrescu Alina', 'alina.petrescu@example.com, +40 728 890 123', 'City Insurance 321654987');
INSERT INTO patients VALUES (509, 'Munteanu Sorin', 'sorin.munteanu@example.com, +40 729 901 234', 'Allianz 654789321');
INSERT INTO patients VALUES (510, 'Andrei Monica', 'monica.andrei@example.com, +40 730 123 456', 'Signal Iduna 147258369');
INSERT INTO patients VALUES (511, 'Rusu Cristian', 'cristian.rusu@example.com, +40 731 234 567', 'Omniasig 258369147');
INSERT INTO patients VALUES (512, 'Mihailescu Teodor', 'teodor.mihailescu@example.com, +40 732 345 678', 'Uniqa 369147258');
INSERT INTO patients VALUES (513, 'Costache Gabriela', 'gabriela.costache@example.com, +40 733 456 789', 'Groupama 123456789');
INSERT INTO patients VALUES (514, 'Neagu Daniel', 'daniel.neagu@example.com, +40 734 567 890', 'Allianz 789456123');
INSERT INTO patients VALUES (515, 'Tudor Laura', 'laura.tudor@example.com, +40 735 678 901', 'Signal Iduna 456123789');
INSERT INTO patients VALUES (516, 'Voicu Florin', 'florin.voicu@example.com, +40 736 789 012', 'Generali 321789456');
INSERT INTO patients VALUES (517, 'Stan Alexandra', 'alexandra.stan@example.com, +40 737 890 123', 'Omniasig 987654321');
INSERT INTO patients VALUES (518, 'Dumitrescu Petru', 'petru.dumitrescu@example.com, +40 738 901 234', 'City Insurance 654987321');
INSERT INTO patients VALUES (519, 'Bãlan Simona', 'simona.balan@example.com, +40 739 012 345', 'Asirom 147369258');
INSERT INTO patients VALUES (520, 'Oprea Adrian', 'adrian.oprea@example.com, +40 740 123 456', 'Groupama 258147369');
INSERT INTO patients VALUES (521, 'Marin Raluca', 'raluca.marin@example.com, +40 741 234 567', 'Allianz 369258147');
INSERT INTO patients VALUES (522, 'Dinu Mihnea', 'mihnea.dinu@example.com, +40 742 345 678', 'Signal Iduna 147369852');
INSERT INTO patients VALUES (523, 'Iancu Sorina', 'sorina.iancu@example.com, +40 743 456 789', 'Uniqa 852147369');
INSERT INTO patients VALUES (524, 'Nistor Radu', 'radu.nistor@example.com, +40 744 567 890', 'City Insurance 963258741');
INSERT INTO patients VALUES (525, 'Voineagu Paula', 'paula.voineagu@example.com, +40 745 678 901', 'Generali 741852963');
INSERT INTO patients VALUES (526, 'Popescu Valeriu', 'valeriu.popescu@example.com, +40 746 789 012', 'Omniasig 258963147');
INSERT INTO patients VALUES (527, 'Iftimie Emilia', 'emilia.iftimie@example.com, +40 747 890 123', 'Groupama 147852369');
INSERT INTO patients VALUES (528, 'Rãdulescu Marcel', 'marcel.radulescu@example.com, +40 748 901 234', 'Signal Iduna 369852147');
INSERT INTO patients VALUES (529, 'Damian Roxana', 'roxana.damian@example.com, +40 749 012 345', 'Allianz 852369147');
INSERT INTO patients VALUES (530, 'Cristea ?tefan', 'stefan.cristea@example.com, +40 750 123 456', 'Asirom 963741258');
INSERT INTO patients VALUES (531, 'Munteanu Andrada', 'andrada.munteanu@example.com, +40 751 234 567', 'Generali 147963258');
INSERT INTO patients VALUES (532, 'Pavel Vlad', 'vlad.pavel@example.com, +40 752 345 678', 'Groupama 258369741');
INSERT INTO patients VALUES (533, 'Ciobanu Diana', 'diana.ciobanu@example.com, +40 753 456 789', 'Uniqa 369741852');
INSERT INTO patients VALUES (534, 'Tudorache Bogdan', 'bogdan.tudorache@example.com, +40 754 567 890', 'City Insurance 963258741');
INSERT INTO patients VALUES (535, 'Popescu Andrei', 'andrei.popescu@example.com, +40 755 678 901', 'Omniasig 741369852');
INSERT INTO patients VALUES (536, 'Stanciu Simona', 'simona.stanciu@example.com, +40 756 789 012', 'Signal Iduna 852147963');
INSERT INTO patients VALUES (537, 'Marinescu Alin', 'alin.marinescu@example.com, +40 757 890 123', 'Allianz 147258369');
INSERT INTO patients VALUES (538, 'Gheorghiu Roxana', 'roxana.gheorghiu@example.com, +40 758 901 234', 'Groupama 963852741');
INSERT INTO patients VALUES (539, 'Dumitru Anca', 'anca.dumitru@example.com, +40 759 012 345', 'Asirom 258741963');
INSERT INTO patients VALUES (540, 'Cãlin Rãzvan', 'razvan.calin@example.com, +40 760 123 456', 'Uniqa 369852741');
INSERT INTO patients VALUES (541, 'Enescu Adrian', 'adrian.enescu@example.com, +40 761 234 567', 'City Insurance 852963741');
INSERT INTO patients VALUES (542, 'Pintea Gabriela', 'gabriela.pintea@example.com, +40 762 345 678', 'Omniasig 741852963');
INSERT INTO patients VALUES (543, 'Popovici Bogdan', 'bogdan.popovici@example.com, +40 763 456 789', 'Allianz 147369852');
INSERT INTO patients VALUES (544, 'Voinea Andrei', 'andrei.voinea@example.com, +40 764 567 890', 'Signal Iduna 963852147');
INSERT INTO patients VALUES (545, 'Neac?u Oana', 'oana.neacsu@example.com, +40 765 678 901', 'Generali 258147963');
INSERT INTO patients VALUES (546, 'Petre Alina', 'alina.petre@example.com, +40 766 789 012', 'Groupama 369741852');
INSERT INTO patients VALUES (547, 'Mateescu Mihai', 'mihai.mateescu@example.com, +40 767 890 123', 'Uniqa 741963258');
INSERT INTO patients VALUES (548, 'Ionescu Florin', 'florin.ionescu@example.com, +40 768 901 234', 'City Insurance 852741963');
INSERT INTO patients VALUES (549, 'Stãnescu Laura', 'laura.stanescu@example.com, +40 769 012 345', 'Omniasig 963741852');
INSERT INTO patients VALUES (550, 'Dima Simion', 'simion.dima@example.com, +40 770 123 456', 'Asirom 258963741');

DELETE FROM patients;

prompt orders_inserts

INSERT INTO orders VALUES (601, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 201, 301, 0, 'În a?teptare');
INSERT INTO orders VALUES (602, TO_DATE('2024-01-12', 'YYYY-MM-DD'), 202, 302, 0, 'Livrat');
INSERT INTO orders VALUES (603, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 203, 303, 0, 'Anulat');
INSERT INTO orders VALUES (604, TO_DATE('2024-01-18', 'YYYY-MM-DD'), 204, 304, 0, 'În procesare');
INSERT INTO orders VALUES (605, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 205, 305, 0, 'Livrat');
INSERT INTO orders VALUES (606, TO_DATE('2024-01-22', 'YYYY-MM-DD'), 206, 306, 0, 'Anulat');
INSERT INTO orders VALUES (607, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 207, 307, 0, 'Livrat');
INSERT INTO orders VALUES (608, TO_DATE('2024-01-27', 'YYYY-MM-DD'), 208, 308, 0, 'În a?teptare');
INSERT INTO orders VALUES (609, TO_DATE('2024-01-29', 'YYYY-MM-DD'), 209, 309, 0, 'Livrat');
INSERT INTO orders VALUES (610, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 210, 310, 0, 'În procesare');
INSERT INTO orders VALUES (611, TO_DATE('2024-02-03', 'YYYY-MM-DD'), 211, 311, 0, 'Livrat');
INSERT INTO orders VALUES (612, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 212, 312, 0, 'Anulat');
INSERT INTO orders VALUES (613, TO_DATE('2024-02-08', 'YYYY-MM-DD'), 213, 313, 0, 'În a?teptare');
INSERT INTO orders VALUES (614, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 214, 314, 0, 'Livrat');
INSERT INTO orders VALUES (615, TO_DATE('2024-02-12', 'YYYY-MM-DD'), 215, 315, 0, 'Anulat');
INSERT INTO orders VALUES (616, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 216, 316, 0, 'În procesare');
INSERT INTO orders VALUES (617, TO_DATE('2024-02-17', 'YYYY-MM-DD'), 217, 317, 0, 'Livrat');
INSERT INTO orders VALUES (618, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 218, 318, 0, 'În a?teptare');
INSERT INTO orders VALUES (619, TO_DATE('2024-02-22', 'YYYY-MM-DD'), 219, 319, 0, 'Livrat');
INSERT INTO orders VALUES (620, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 220, 320, 0, 'Anulat');
INSERT INTO orders VALUES (621, TO_DATE('2024-02-28', 'YYYY-MM-DD'), 221, 321, 0, 'În procesare');
INSERT INTO orders VALUES (622, TO_DATE('2024-03-02', 'YYYY-MM-DD'), 222, 322, 0, 'Livrat');
INSERT INTO orders VALUES (623, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 223, 323, 0, 'În a?teptare');
INSERT INTO orders VALUES (624, TO_DATE('2024-03-07', 'YYYY-MM-DD'), 224, 324, 0, 'Livrat');
INSERT INTO orders VALUES (625, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 225, 325, 0, 'Anulat');
INSERT INTO orders VALUES (626, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 226, 326, 0, 'În procesare');
INSERT INTO orders VALUES (627, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 227, 327, 0, 'Livrat');
INSERT INTO orders VALUES (628, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 228, 328, 0, 'Anulat');
INSERT INTO orders VALUES (629, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 229, 329, 0, 'În procesare');
INSERT INTO orders VALUES (630, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 230, 330, 0, 'Livrat');
INSERT INTO orders VALUES (631, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 231, 331, 0, 'În a?teptare');
INSERT INTO orders VALUES (632, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 232, 332, 0, 'Livrat');
INSERT INTO orders VALUES (633, TO_DATE('2024-03-29', 'YYYY-MM-DD'), 233, 333, 0, 'Anulat');
INSERT INTO orders VALUES (634, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 234, 334, 0, 'În procesare');
INSERT INTO orders VALUES (635, TO_DATE('2024-04-03', 'YYYY-MM-DD'), 235, 335, 0, 'Livrat');
INSERT INTO orders VALUES (636, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 236, 336, 0, 'Anulat');
INSERT INTO orders VALUES (637, TO_DATE('2024-04-08', 'YYYY-MM-DD'), 237, 337, 0, 'În a?teptare');
INSERT INTO orders VALUES (638, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 238, 338, 0, 'Livrat');
INSERT INTO orders VALUES (639, TO_DATE('2024-04-12', 'YYYY-MM-DD'), 239, 339, 0, 'În procesare');
INSERT INTO orders VALUES (640, TO_DATE('2024-04-15', 'YYYY-MM-DD'), 240, 340, 0, 'Livrat');
INSERT INTO orders VALUES (641, TO_DATE('2024-04-17', 'YYYY-MM-DD'), 241, 341, 0, 'Anulat');
INSERT INTO orders VALUES (642, TO_DATE('2024-04-20', 'YYYY-MM-DD'), 242, 342, 0, 'În procesare');
INSERT INTO orders VALUES (643, TO_DATE('2024-04-22', 'YYYY-MM-DD'), 243, 343, 0, 'Livrat');
INSERT INTO orders VALUES (644, TO_DATE('2024-04-25', 'YYYY-MM-DD'), 244, 344, 0, 'Anulat');
INSERT INTO orders VALUES (645, TO_DATE('2024-04-27', 'YYYY-MM-DD'), 245, 345, 0, 'Livrat');
INSERT INTO orders VALUES (646, TO_DATE('2024-04-29', 'YYYY-MM-DD'), 246, 346, 0, 'În a?teptare');
INSERT INTO orders VALUES (647, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 247, 347, 0, 'Livrat');
INSERT INTO orders VALUES (648, TO_DATE('2024-05-03', 'YYYY-MM-DD'), 248, 348, 0, 'Anulat');
INSERT INTO orders VALUES (649, TO_DATE('2024-05-05', 'YYYY-MM-DD'), 249, 349, 0, 'În procesare');
INSERT INTO orders VALUES (650, TO_DATE('2024-05-07', 'YYYY-MM-DD'), 250, 350, 0, 'Livrat');

UPDATE orders o
SET total_amount = (
    SELECT SUM(oi.unit_price * oi.quantity_ordered)
    FROM order_items oi
    WHERE oi.order_id = o.order_id
)
WHERE EXISTS (
    SELECT 1 
    FROM order_items oi 
    WHERE oi.order_id = o.order_id
);

DELETE FROM orders;

prompt order_items_inserts

INSERT INTO order_items VALUES (701, 601, 101, 10, 5.50, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (702, 602, 102, 20, 12.75, TO_DATE('2025-11-30', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (703, 603, 103, 15, 15.00, TO_DATE('2026-01-15', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (704, 604, 104, 25, 8.50, TO_DATE('2025-10-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (705, 605, 105, 30, 6.25, TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (706, 606, 106, 10, 10.00, TO_DATE('2026-02-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (707, 607, 107, 12, 12.00, TO_DATE('2025-09-15', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (708, 608, 108, 18, 7.50, TO_DATE('2025-08-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (709, 609, 109, 22, 4.50, TO_DATE('2026-01-01', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (710, 610, 110, 17, 3.50, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (711, 611, 111, 14, 22.00, TO_DATE('2025-12-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (712, 612, 112, 19, 120.00, TO_DATE('2026-03-01', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (713, 613, 113, 21, 18.00, TO_DATE('2026-02-28', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (714, 614, 114, 11, 10.50, TO_DATE('2025-09-30', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (715, 615, 115, 13, 9.75, TO_DATE('2025-08-31', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (716, 616, 116, 20, 12.25, TO_DATE('2026-05-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (717, 617, 117, 16, 15.25, TO_DATE('2026-04-01', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (718, 618, 118, 24, 8.00, TO_DATE('2025-06-15', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (719, 619, 119, 18, 6.00, TO_DATE('2026-07-01', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (720, 620, 120, 26, 50.00, TO_DATE('2025-10-01', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (721, 621, 121, 10, 13.50, TO_DATE('2025-10-10', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (722, 622, 122, 15, 20.00, TO_DATE('2026-02-20', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (723, 623, 123, 17, 5.25, TO_DATE('2026-01-10', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (724, 624, 124, 20, 6.75, TO_DATE('2025-12-20', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (725, 625, 125, 13, 3.75, TO_DATE('2025-12-15', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (726, 626, 126, 14, 4.50, TO_DATE('2026-04-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (727, 627, 127, 12, 5.00, TO_DATE('2025-11-15', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (728, 628, 128, 10, 9.00, TO_DATE('2025-12-10', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (729, 629, 129, 20, 22.50, TO_DATE('2026-05-01', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (730, 630, 130, 24, 15.50, TO_DATE('2026-02-28', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (731, 631, 131, 19, 18.00, TO_DATE('2025-11-20', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (732, 632, 132, 14, 50.00, TO_DATE('2025-10-15', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (733, 633, 133, 10, 10.50, TO_DATE('2026-03-15', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (734, 634, 134, 22, 12.25, TO_DATE('2026-05-10', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (735, 635, 135, 15, 5.75, TO_DATE('2025-08-20', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (736, 636, 136, 18, 23.00, TO_DATE('2026-04-15', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (737, 637, 137, 20, 8.50, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (738, 638, 138, 14, 3.25, TO_DATE('2025-10-01', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (739, 639, 139, 17, 5.00, TO_DATE('2026-01-10', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (740, 640, 140, 10, 9.50, TO_DATE('2025-11-15', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (741, 641, 141, 22, 10.75, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'În a?teptare');
INSERT INTO order_items VALUES (742, 642, 142, 16, 6.50, TO_DATE('2026-02-20', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (743, 643, 143, 18, 9.00, TO_DATE('2026-03-30', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (744, 644, 144, 25, 4.75, TO_DATE('2026-04-30', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (745, 645, 145, 19, 16.50, TO_DATE('2026-05-15', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (746, 646, 146, 20, 11.00, TO_DATE('2026-02-28', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (747, 647, 147, 15, 7.25, TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'Livrat');
INSERT INTO order_items VALUES (748, 648, 148, 12, 6.75, TO_DATE('2025-10-20', 'YYYY-MM-DD'), 'Anulat');
INSERT INTO order_items VALUES (749, 649, 149, 14, 4.25, TO_DATE('2025-12-01', 'YYYY-MM-DD'), 'În procesare');
INSERT INTO order_items VALUES (750, 650, 150, 18, 5.50, TO_DATE('2026-01-15', 'YYYY-MM-DD'), 'Livrat');

DELETE FROM order_items;

prompt prescriptions_inserts

INSERT INTO prescriptions VALUES (801, 501, 401, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 2, 1);
INSERT INTO prescriptions VALUES (802, 502, 402, TO_DATE('2024-01-02', 'YYYY-MM-DD'), 1, 0);
INSERT INTO prescriptions VALUES (803, 503, 403, TO_DATE('2024-01-03', 'YYYY-MM-DD'), 3, 2);
INSERT INTO prescriptions VALUES (804, 504, 404, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 4, 1);
INSERT INTO prescriptions VALUES (805, 505, 405, TO_DATE('2024-01-07', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (806, 506, 406, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 1, 3);
INSERT INTO prescriptions VALUES (807, 507, 407, TO_DATE('2024-01-12', 'YYYY-MM-DD'), 3, 2);
INSERT INTO prescriptions VALUES (808, 508, 408, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 2, 1);
INSERT INTO prescriptions VALUES (809, 509, 409, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 4, 0);
INSERT INTO prescriptions VALUES (810, 510, 410, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 2, 2);
INSERT INTO prescriptions VALUES (811, 511, 411, TO_DATE('2024-01-22', 'YYYY-MM-DD'), 3, 1);
INSERT INTO prescriptions VALUES (812, 512, 412, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 5, 3);
INSERT INTO prescriptions VALUES (813, 513, 413, TO_DATE('2024-01-27', 'YYYY-MM-DD'), 1, 0);
INSERT INTO prescriptions VALUES (814, 514, 414, TO_DATE('2024-01-30', 'YYYY-MM-DD'), 4, 2);
INSERT INTO prescriptions VALUES (815, 515, 415, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 3, 1);
INSERT INTO prescriptions VALUES (816, 516, 416, TO_DATE('2024-02-03', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (817, 517, 417, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 4, 1);
INSERT INTO prescriptions VALUES (818, 518, 418, TO_DATE('2024-02-07', 'YYYY-MM-DD'), 5, 3);
INSERT INTO prescriptions VALUES (819, 519, 419, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (820, 520, 420, TO_DATE('2024-02-12', 'YYYY-MM-DD'), 3, 1);
INSERT INTO prescriptions VALUES (821, 521, 421, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 4, 2);
INSERT INTO prescriptions VALUES (822, 522, 422, TO_DATE('2024-02-18', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (823, 523, 423, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 1, 3);
INSERT INTO prescriptions VALUES (824, 524, 424, TO_DATE('2024-02-22', 'YYYY-MM-DD'), 5, 1);
INSERT INTO prescriptions VALUES (825, 525, 425, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 3, 2);
INSERT INTO prescriptions VALUES (826, 526, 426, TO_DATE('2024-02-28', 'YYYY-MM-DD'), 4, 0);
INSERT INTO prescriptions VALUES (827, 527, 427, TO_DATE('2024-03-02', 'YYYY-MM-DD'), 2, 1);
INSERT INTO prescriptions VALUES (828, 528, 428, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 3, 3);
INSERT INTO prescriptions VALUES (829, 529, 429, TO_DATE('2024-03-07', 'YYYY-MM-DD'), 1, 0);
INSERT INTO prescriptions VALUES (830, 530, 430, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 5, 2);
INSERT INTO prescriptions VALUES (831, 531, 431, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (832, 532, 432, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 4, 1);
INSERT INTO prescriptions VALUES (833, 533, 433, TO_DATE('2024-03-17', 'YYYY-MM-DD'), 3, 2);
INSERT INTO prescriptions VALUES (834, 534, 434, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (835, 535, 435, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 5, 3);
INSERT INTO prescriptions VALUES (836, 536, 436, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 1, 1);
INSERT INTO prescriptions VALUES (837, 537, 437, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 4, 0);
INSERT INTO prescriptions VALUES (838, 538, 438, TO_DATE('2024-03-30', 'YYYY-MM-DD'), 3, 2);
INSERT INTO prescriptions VALUES (839, 539, 439, TO_DATE('2024-04-02', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (840, 540, 440, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 4, 1);
INSERT INTO prescriptions VALUES (841, 541, 441, TO_DATE('2024-04-07', 'YYYY-MM-DD'), 5, 3);
INSERT INTO prescriptions VALUES (842, 542, 442, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 3, 2);
INSERT INTO prescriptions VALUES (843, 543, 443, TO_DATE('2024-04-12', 'YYYY-MM-DD'), 1, 0);
INSERT INTO prescriptions VALUES (844, 544, 444, TO_DATE('2024-04-15', 'YYYY-MM-DD'), 4, 1);
INSERT INTO prescriptions VALUES (845, 545, 445, TO_DATE('2024-04-18', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (846, 546, 446, TO_DATE('2024-04-20', 'YYYY-MM-DD'), 3, 2);
INSERT INTO prescriptions VALUES (847, 547, 447, TO_DATE('2024-04-23', 'YYYY-MM-DD'), 5, 3);
INSERT INTO prescriptions VALUES (848, 548, 448, TO_DATE('2024-04-25', 'YYYY-MM-DD'), 2, 0);
INSERT INTO prescriptions VALUES (849, 549, 449, TO_DATE('2024-04-28', 'YYYY-MM-DD'), 4, 1);
INSERT INTO prescriptions VALUES (850, 550, 450, TO_DATE('2024-04-30', 'YYYY-MM-DD'), 3, 2);

DELETE FROM prescriptions;

prompt prescription_medicines_inserts

INSERT INTO prescription_medicines VALUES (801, 101, 2);
INSERT INTO prescription_medicines VALUES (802, 102, 1);
INSERT INTO prescription_medicines VALUES (803, 103, 3);
INSERT INTO prescription_medicines VALUES (804, 104, 4);
INSERT INTO prescription_medicines VALUES (805, 105, 2);
INSERT INTO prescription_medicines VALUES (806, 106, 1);
INSERT INTO prescription_medicines VALUES (807, 107, 3);
INSERT INTO prescription_medicines VALUES (808, 108, 2);
INSERT INTO prescription_medicines VALUES (809, 109, 4);
INSERT INTO prescription_medicines VALUES (810, 110, 2);
INSERT INTO prescription_medicines VALUES (811, 111, 3);
INSERT INTO prescription_medicines VALUES (812, 112, 5);
INSERT INTO prescription_medicines VALUES (813, 113, 1);
INSERT INTO prescription_medicines VALUES (814, 114, 4);
INSERT INTO prescription_medicines VALUES (815, 115, 3);
INSERT INTO prescription_medicines VALUES (816, 116, 2);
INSERT INTO prescription_medicines VALUES (817, 117, 4);
INSERT INTO prescription_medicines VALUES (818, 118, 5);
INSERT INTO prescription_medicines VALUES (819, 119, 2);
INSERT INTO prescription_medicines VALUES (820, 120, 3);
INSERT INTO prescription_medicines VALUES (821, 121, 4);
INSERT INTO prescription_medicines VALUES (822, 122, 2);
INSERT INTO prescription_medicines VALUES (823, 123, 1);
INSERT INTO prescription_medicines VALUES (824, 124, 5);
INSERT INTO prescription_medicines VALUES (825, 125, 3);
INSERT INTO prescription_medicines VALUES (826, 126, 4);
INSERT INTO prescription_medicines VALUES (827, 127, 2);
INSERT INTO prescription_medicines VALUES (828, 128, 3);
INSERT INTO prescription_medicines VALUES (829, 129, 1);
INSERT INTO prescription_medicines VALUES (830, 130, 5);
INSERT INTO prescription_medicines VALUES (831, 131, 2);
INSERT INTO prescription_medicines VALUES (832, 132, 4);
INSERT INTO prescription_medicines VALUES (833, 133, 3);
INSERT INTO prescription_medicines VALUES (834, 134, 2);
INSERT INTO prescription_medicines VALUES (835, 135, 5);
INSERT INTO prescription_medicines VALUES (836, 136, 1);
INSERT INTO prescription_medicines VALUES (837, 137, 4);
INSERT INTO prescription_medicines VALUES (838, 138, 3);
INSERT INTO prescription_medicines VALUES (839, 139, 2);
INSERT INTO prescription_medicines VALUES (840, 140, 4);
INSERT INTO prescription_medicines VALUES (841, 141, 5);
INSERT INTO prescription_medicines VALUES (842, 142, 3);
INSERT INTO prescription_medicines VALUES (843, 143, 1);
INSERT INTO prescription_medicines VALUES (844, 144, 4);
INSERT INTO prescription_medicines VALUES (845, 145, 2);
INSERT INTO prescription_medicines VALUES (846, 146, 3);
INSERT INTO prescription_medicines VALUES (847, 147, 5);
INSERT INTO prescription_medicines VALUES (848, 148, 2);
INSERT INTO prescription_medicines VALUES (849, 149, 4);
INSERT INTO prescription_medicines VALUES (850, 150, 3);

DELETE FROM prescription_medicines;
