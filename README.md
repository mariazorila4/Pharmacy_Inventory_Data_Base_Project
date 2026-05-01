# Pharmacy_Inventory_Data_Base_Project

<p align="center">
  <img src="pharmacy inventory app logo.jpg" alt="Logo" width="600">
</p>
<p align="center">
  <em>Created using Canva AI tools. I do not claim ownership of the visual elements.<br>
  If this image presents an issue, please feel free to contact me.</em>
</p>



## Project Overview

This project involves the development of a relational database designed for managing inventory and operations within a pharmacy. The database supports the pharmacy’s internal processes, including medicine stock management, supplier details, customer prescriptions, and order tracking.

The project was developed using SQL and includes tables, relationships, and constraints that form an efficient system for managing essential data in the pharmaceutical sector.

### Main Objectives

- Efficient database design
- Query optimization
- Relational data modeling

### Features

- **Medicine Management:** Recording essential medicine details such as generic and brand names, dosage, stock levels, and expiration dates.
- **Supplier Management:** Maintaining records of pharmaceutical suppliers, including contact information and payment terms.
- **Pharmacy Locations:** Managing multiple pharmacy branches and their inventory levels.
- **Order Processing:** Tracking orders placed with suppliers, including statuses (pending, delivered, canceled).
- **Customer Prescription Management:** Storing and linking prescriptions to patients and doctors.

### Schema Diagram

You can view the updated database schema diagram in the main folder of this repository: **Pharmacy_Inventory_ERD_diagram.png** or **Pharmacy_Inventory_ERD_diagram.pdf**

## Technologies Used

- **Database:** SQL (compatible with MySQL, PostgreSQL, SQL Server)
- **Tools:** SQLDeveloper, MySQL Workbench, pgAdmin

## How to use

### Prerequisites:

- An SQL-compatible database (e.g., MySQL, PostgreSQL, SQL Server)
- An SQL editor (e.g., MySQL Workbench, DBeaver, pgAdmin)

### Steps to run:

1. **Download the SQL file:** Access the file **Pharmacy_Inventory_script.sql** from this repository.
2. **Import the database:** Load the SQL file into a compatible database management system.
3. **Run the queries:** Execute the SQL scripts to create tables and populate the database with necessary data.
4. **Practice exercises:** Access the file **Pharmacy_Inventory_practice_exercises.sql** and execute to observe how complex SQL queries are implemented for extracting, analyzing, and manipulating data in order to meet specific management requirements.

## Part 2: PL/SQL Extension (Procedural Programming)

**Introductory Note:** This section builds upon the SQL Database project, extending its functionalities by using procedural programming (PL/SQL) for advanced data management and internal process automation.

Through this extension:
* Essential tables are managed, such as `effects`, `medicines`, `supplies`, `orders`, `order_items` (containing quantity and unit price), `patients`, `prescriptions`, `doctors`, `prescriptions_medicines` (an intermediate table between prescriptions and medicines), and `pharmacy`.
* Table relationships are enforced through primary and foreign keys to ensure data integrity.

**Entities:**
* `effects`: effect_id (PK), effect_name.
* `medicines`: medicine_id (PK), generic_name, brand_name, dosage, form_of_medicine, manufacturer, expiration_date, quantity_in_stock, price, effect_id (FK).
* `supplies`: supplier_id (PK), supplier_name, contact_information, payment_terms.
* `orders`: order_id (PK), order_date, supplier_id (FK), pharmacy_id (FK), total_amount, order_status.
* `order_items`: order_item_id (PK), order_id (FK), medicine_id (FK), quantity_ordered, unit_price, expected_expiration_date, delivery_status.
* `patients`: patient_id (PK), patient_name, contact_information, insurance_information.
* `doctors`: doctor_id (PK), doctor_name, medical_license, speciality.
* `prescriptions`: prescription_id (PK), patient_id (FK), doctor_id (FK), prescription_date, quantity_prescribed, refills_allowed.
* `prescriptions_medicines`: prescription_id (PK & FK), medicine_id (PK & FK), quantity_prescribed.
* `pharmacy`: pharmacy_id (PK), pharmacy_name, location, contact_information.

This project demonstrates the utility of databases in the pharmaceutical context, offering efficient solutions for order tracking, product and supplier management, prescription handling, associating doctors with patients, and quickly finding medicines based on their effects. It also includes prescription analysis for evaluating doctor activity and patient needs.

### 1. Control Structures

**Exercice 1:** Check if a medicine is currently within its validity period.
```sql
SET SERVEROUTPUT ON
DECLARE
    v_name CHAR(50);
    v_termen NUMBER(2);
    v_id medicines.medicine_id%TYPE:=&id;
BEGIN
    SELECT generic_name, (expiration_date-SYSDATE)/31
    INTO v_name, v_termen
    FROM medicines
    WHERE medicine_id=v_id;
    
    IF v_termen>0 THEN
        DBMS_OUTPUT.PUT_LINE('The medicine '||v_name||' is valid and will expire in '||v_termen||' months.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The medicine '||v_name||' has expired.');
    END IF;
END;
/
```

(Output example: The medicine Ibuprofen Lysine is within its validity period and will expire in 7 months.)

<img width="763" height="458" alt="image" src="https://github.com/user-attachments/assets/7de54eb0-38eb-491f-825f-18db1eaf6919" />
<br>
<br>

**Exercice 2:** Apply a discount to orders such that:

- If the order is `anulat`, apply a *50% discount*.  

- If it is `in asteptare`, apply a *25% discount*.  

- If it is `in procesare`, apply a *10% discount*.  

- If it is `livrat`, *no discount* is applied.

```sql
ACCEPT id PROMPT 'Enter the order ID: '
SET SERVEROUTPUT ON
DECLARE
    v_id orders.order_id%TYPE:=&id;
    v_amount NUMBER(10,2);
    v_status CHAR(50);
BEGIN
    SELECT total_amount, order_status
    INTO v_amount, v_status
    FROM orders
    WHERE order_id=v_id;
    
    DBMS_OUTPUT.PUT_LINE('The order with ID '||v_id||' has an initial total value of '||v_amount||' RON.');
    
    IF v_status='Anulat' THEN
        v_amount:=v_amount-(0.50*v_amount);
    ELSIF v_status='In asteptare' THEN
        v_amount:=v_amount-(0.25*v_amount);
    ELSIF  v_status='In procesare' THEN
        v_amount:=v_amount-(0.10*v_amount);
    ELSE
        v_amount:=v_amount-(0*v_amount);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('The order with ID '||v_id||' has the status '||v_status||' and a final value of '||v_amount||' RON.');
END;
/
```
<img width="940" height="543" alt="image" src="https://github.com/user-attachments/assets/a36f6fcd-a75c-4598-ba76-266b0c90d3f2" />
<br>
<br>

**Exercice 3:** Display in order the medicines with IDs in the range 101-125 as long as their price is lower than the average.

```sql
SET SERVEROUTPUT ON
DECLARE
    v_name CHAR(50);
    v_price medicines.price%TYPE;
    v_medium_price v_price%TYPE;
    i NUMBER(3):=101;
BEGIN
    SELECT avg(price) INTO v_medium_price FROM medicines;
    DBMS_OUTPUT.PUT_LINE('The average price is '||v_medium_price||' RON.');
    
    LOOP
        SELECT generic_name, price INTO v_name, v_price FROM medicines WHERE medicine_id=i;
        DBMS_OUTPUT.PUT_LINE('The medicine '||v_name||' with ID '||i||' costs '||v_price||' RON.');
        i:=i+1;
        EXIT WHEN v_price<v_medium_price OR i>125;
    END LOOP;
END;
/
```
<img width="864" height="564" alt="image" src="https://github.com/user-attachments/assets/1f1bb59a-1011-41ac-8aeb-416b52d91d3b" />
<br>
<br>

**Exercice 4:** Iterate through all medicines.
```sql
SET SERVEROUTPUT ON
DECLARE
    v_name medicines.generic_name%TYPE;
    v_price NUMBER;
    v_min medicines.medicine_id%TYPE;
    v_max v_min%TYPE;
    v NUMBER;
BEGIN
    SELECT MIN(medicine_id), MAX(medicine_id)
    INTO v_min, v_max
    FROM medicines;
    
    FOR i IN v_min..v_max LOOP
        SELECT COUNT(medicine_id) INTO v
        FROM medicines
        WHERE medicine_id=i;
        
        IF v=1 THEN
            SELECT generic_name, price
            INTO v_name, v_price
            FROM medicines
            WHERE medicine_id=i;
            DBMS_OUTPUT.PUT_LINE('The medicine '||v_name||' costs '||v_price||' RON.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('The medicine '||i||' does not exist.');
        END IF;
    END LOOP;
END;
/
```
<img width="816" height="480" alt="image" src="https://github.com/user-attachments/assets/e4e2278d-6fc1-4360-b632-0592c6efa3af" />
<br>
<br>
<br>
<br>

### 2. Exception Handling

**Exercice 1:** Verify if there are medicines corresponding to the effect ID read from the keyboard; if not, display a message
```sql
SET SERVEROUTPUT ON
ACCEPT a PROMPT 'Enter the effect ID: '
DECLARE
    v_id effects.effect_id%TYPE:=&a;
    nr_medicines NUMBER:=0;
    CURSOR c IS SELECT generic_name FROM medicines WHERE effect_id=v_id;
    r c%ROWTYPE;
BEGIN
    BEGIN
        OPEN c;
        LOOP
            FETCH c INTO r;
            EXIT WHEN c%NOTFOUND;
            nr_medicines:=nr_medicines+1;
            DBMS_OUTPUT.PUT_LINE('The medicine name is '||r.generic_name);
        END LOOP;
        CLOSE c;

        IF nr_medicines=0 THEN
            RAISE NO_DATA_FOUND;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There are no medicines.');
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('C '||SQLCODE||' '||SQLERRM);
END;
/
```

a. The effect exist:
<img width="748" height="411" alt="image" src="https://github.com/user-attachments/assets/bf768b9b-6d37-4e07-ac7f-8d54dc206f0f" />

<br>
b. The effect doesn't exist:
<img width="940" height="500" alt="image" src="https://github.com/user-attachments/assets/4bc32b6b-9634-4780-a3b4-d859d9410aa7" />

<br>
<br>

**Exercice 2:** Read a medicine ID from the keyboard and verify if it has been included in one or more orders.

```sql
SET SERVEROUTPUT ON
ACCEPT a PROMPT 'Enter the medicine ID: '
DECLARE
    v_id medicines.medicine_id%TYPE:=&a;
    v_nume medicines.generic_name%TYPE;
    v_order_id orders.order_id%TYPE;
    v_data orders.order_date%TYPE;
    valoare NUMBER;
    total_comenzi NUMBER:=0;
    comanda_neincheiata EXCEPTION;
    mai_multe_comenzi EXCEPTION;
    PRAGMA EXCEPTION_INIT(mai_multe_comenzi, -01422);
BEGIN
    BEGIN
        SELECT generic_name INTO v_nume FROM medicines WHERE medicine_id=v_id;
        DBMS_OUTPUT.PUT_LINE('The medicine with ID '||v_id||' is named '||v_nume||'.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('The medicine with this ID does not exist.');
        RETURN;
    END;

    BEGIN
        FOR c IN (
            SELECT order_id, order_date, total_amount
            INTO v_order_id, v_data, valoare
            FROM orders JOIN order_items USING (order_id)
            WHERE medicine_id=v_id
        ) LOOP 
            DBMS_OUTPUT.PUT_LINE('The order with ID '||c.order_id||' was placed on '||c.order_date||' and has a value of '||c.total_amount);
            total_comenzi:=total_comenzi+1;
        END LOOP;

        IF total_comenzi=0 THEN
            DBMS_OUTPUT.PUT_LINE('The medicine '||v_nume||' has not been included in any order.');
        ELSIF total_comenzi=1 THEN
            DBMS_OUTPUT.PUT_LINE('The medicine '||v_nume||' was included in one order.');
        ELSE
            RAISE mai_multe_comenzi;
        END IF;

    EXCEPTION
        WHEN mai_multe_comenzi THEN DBMS_OUTPUT.PUT_LINE('The medicine '||v_nume||' was included in multiple orders.');
    END;
END;
/
```
<img width="940" height="514" alt="image" src="https://github.com/user-attachments/assets/fde04d91-3427-4937-b3e4-ff2e0deda7eb" />
<br>
<br>

**Exercise 3:** Increase the price of the medicine whose code is read from the keyboard by 20%; if it does not exist, display a message.
```sql
SET SERVEROUTPUT ON
ACCEPT a PROMPT 'Enter the medicine code: '
DECLARE
    v_id NUMBER:=&a;
    medicament_inexistent EXCEPTION;
BEGIN
    UPDATE medicines
    SET price=price*1.2
    WHERE medicine_id=v_id;

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('OK');
    ELSE
        RAISE medicament_inexistent;
    END IF;
EXCEPTION
    WHEN medicament_inexistent THEN DBMS_OUTPUT.PUT_LINE('The medicine does not exist.');
END;
/
```

a. The medicine exist:
<img width="940" height="499" alt="image" src="https://github.com/user-attachments/assets/e6856d15-9c6b-4f6b-8fa5-86a63cd9c674" />
<br>

b.The medicine doesn't exist:
<img width="940" height="513" alt="image" src="https://github.com/user-attachments/assets/1f63b827-74f1-4018-9807-bddb740e6dd6" />
<br>
<br>

**Exercise 4:** Display the name and ordered quantity for a medicine; if it has not been ordered, invoke an exception. Also, consider the case where the medicine does not exist.
```sql
SET SERVEROUTPUT ON
ACCEPT a PROMPT 'Enter the medicine ID: '
DECLARE
    v_id medicines.medicine_id%TYPE:=&a;
    v_nume medicines.generic_name%TYPE;
    v_suma NUMBER;
    medicament_necomandat EXCEPTION;
BEGIN
    SELECT generic_name
      INTO v_nume
      FROM medicines
      WHERE medicine_id=v_id;
      DBMS_OUTPUT.PUT_LINE(v_nume);

      SELECT SUM(quantity_ordered) INTO v_suma
      FROM order_items
      WHERE medicine_id=v_id;
  
      IF v_suma IS NOT NULL THEN
          DBMS_OUTPUT.PUT_LINE(v_suma);
      ELSE
          RAISE medicament_necomandat;
      END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('The medicine does not exist.');
    WHEN medicament_necomandat THEN DBMS_OUTPUT.PUT_LINE('The medicine exists, but it has not been ordered.');
END;
/
```
<img width="940" height="514" alt="image" src="https://github.com/user-attachments/assets/23afee26-f285-4eb6-9ab5-f750e264f0c4" />
<br>
<br>

**Exercise 5:** Use a parameterized cursor to retrieve the name, price, and validity of medicines for an effect provided as a parameter.
```sql
SET SERVEROUTPUT ON
ACCEPT a PROMPT 'Enter the effect ID: '
DECLARE
CURSOR c (p NUMBER) IS SELECT generic_name, price, (SYSDATE-expiration_date)/31 AS valabilitate
    FROM medicines
    WHERE effect_id=p;    
v_id NUMBER:=&a;
v_parametru effects.effect_id%TYPE;
i NUMBER:=0;
fara_medicamente EXCEPTION;
BEGIN
    SELECT effect_id INTO v_parametru FROM effects WHERE effect_id=v_id;
    
    FOR v IN c (v_id) LOOP
        DBMS_OUTPUT.PUT_LINE(v.generic_name);
        i:=i+1;
    END LOOP;
    
    IF i=0 THEN
        RAISE fara_medicamente;
    ELSE
        DBMS_OUTPUT.PUT_LINE(i||' medicines');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('The effect does not exist.');
    WHEN fara_medicamente THEN DBMS_OUTPUT.PUT_LINE('No medicines.');
END;
/
```

a. The effect exist:
<img width="789" height="435" alt="image" src="https://github.com/user-attachments/assets/962b3e05-8a85-431f-9898-228c7c1d2dd9" />

b. The effect doesn't exist:
<img width="788" height="439" alt="image" src="https://github.com/user-attachments/assets/0f7911fc-2140-4e3e-93c6-12940e0964a1" />
<br>
<br>

Exercise 6: Update the medicine name with ID 180 only if it exists and display a corresponding message otherwise.
```sql
SET SERVEROUTPUT ON
DECLARE
    invalid_med EXCEPTION;
BEGIN
    UPDATE medicines
    SET generic_name='Dormydus'
    WHERE medicine_id=180;

    IF SQL%NOTFOUND THEN
        RAISE invalid_med;
    END IF;
EXCEPTION
    WHEN invalid_med THEN
        DBMS_OUTPUT.PUT_LINE('The medicine with this ID does not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: '||SQLERRM);
END;
/
```
<img width="945" height="365" alt="image" src="https://github.com/user-attachments/assets/1c8058ee-6bb4-493d-a290-d59fa4db337c" />
<br>
<br>
<br>
<br>

### 3. Cursor Management

#### Implicit Cursors

**Exercise 1:** Delete medicines in the form of 'Comprimate' that have not been prescribed, and display the number of deleted prescriptions.
```sql
SET SERVEROUTPUT ON
BEGIN
    DELETE FROM medicines m
    WHERE form_of_medicine='Comprimate' AND NOT EXISTS (
        SELECT 1 FROM prescription_medicines pr_m WHERE m.medicine_id=pr_m.medicine_id
    );
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' prescriptions deleted.');
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' prescriptions affected.');
END;
/
```

<img width="940" height="320" alt="image" src="https://github.com/user-attachments/assets/c72a4b0c-6f8a-44f6-bb22-1473ae622938" />
<br>
<br>

**Exercise 2:** Attempt to add a doctor and then modify the medicine with code 160.
```sql
BEGIN
    INSERT INTO doctors VALUES(451, 'Dr. Roman Alina', 132456, 'Endocrinologie');
    UPDATE medicines
    SET generic_name='Euthyrox'
    WHERE medicine_id=160;
    
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('The medicine with this code does not exist.');
    END IF;
    ROLLBACK;
END;
/
```
<img width="940" height="349" alt="image" src="https://github.com/user-attachments/assets/97739980-e3c7-4d23-9b1e-5335d0fbf366" />
<br>
<br>

**Exercise 3:** Delete the doctor whose ID is entered via the g_did variable from the doctors table, and display the message using the nr_sters variable.
```sql
ACCEPT g_did PROMPT 'Enter the doctor ID: '
VARIABLE nr_sters VARCHAR2(100)
DECLARE
BEGIN
    DELETE FROM doctors WHERE doctor_id=&g_did;
    :nr_sters:=TO_CHAR(SQL%ROWCOUNT)||' RECORDS DELETED';
END;
/
PRINT nr_sters
ROLLBACK;
```
<img width="940" height="506" alt="image" src="https://github.com/user-attachments/assets/63cf41d8-393e-4748-8804-4877f6b5518f" />
<br>
<br>

**Exercise 4:** Increase the prices of medicines by 10% for the effect ID read from the keyboard
```sql
SET SERVEROUTPUT ON
ACCEPT a PROMPT 'Enter the effect ID: '
DECLARE
    v_id NUMBER:=&a;
    v NUMBER;
BEGIN
    SELECT COUNT(*) INTO v
    FROM effects
    WHERE effect_id=v_id;
    
    IF v=0 THEN
        DBMS_OUTPUT.PUT_LINE('The effect does not exist.');
    ELSE
        UPDATE medicines
        SET price=price*1.1
        WHERE effect_id=&a;
        
        IF SQL%ROWCOUNT=0 THEN
            DBMS_OUTPUT.PUT_LINE('The effect exists, but there are no corresponding medicines.');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
        END IF;
    END IF;
END;
/
```

<img width="940" height="505" alt="image" src="https://github.com/user-attachments/assets/fb3ddef0-d42b-492a-ad49-b3b1154ffb98" />
<br>
<br>

#### Explicit Cursors

**Exercise 5:** Display the list of medicine names and prices that have the effect with effect_id=6 using an explicit cursor and 3 scalar variables.
```sql
SET SERVEROUTPUT ON
DECLARE
    CURSOR med_cursor IS SELECT medicine_id, generic_name, price FROM medicines
    WHERE effect_id=6;
    med_id medicines.medicine_id%TYPE;
    med_name medicines.generic_name%TYPE;
    med_price medicines.price%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('The list of medicine prices for effect 6, namely Treating bacterial infections.');
    OPEN med_cursor;
    LOOP
        FETCH med_cursor INTO med_id, med_name, med_price;
        EXIT WHEN med_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('The medicine '||med_name||' has the price: '||med_price);
    END LOOP;
    CLOSE med_cursor;
END;
/
```

<img width="940" height="501" alt="image" src="https://github.com/user-attachments/assets/d658e965-8881-4b81-ab92-81c3a0317770" />
<br>
<br>

**Exercise 6:** Display order information (ID, date, value, status) for each supplier (ID and name). Also, display the total amount paid at the level of each supplier.
```sql
SET SERVEROUTPUT ON
DECLARE
    CURSOR s IS SELECT supplier_id, supplier_name
    FROM supplies
    WHERE supplier_id IN (SELECT supplier_id FROM orders);
    
    CURSOR o (p NUMBER) IS SELECT order_id, order_date, total_amount, order_status, supplier_id FROM orders
    WHERE supplier_id=p;
    
    total NUMBER;
BEGIN
    FOR v IN s LOOP
        total:=0;
        DBMS_OUTPUT.PUT_LINE(v.supplier_id||' '||v.supplier_name);
        
        FOR w IN o (v.supplier_id) LOOP
            total:=total+w.total_amount;
            DBMS_OUTPUT.PUT_LINE(' '||w.order_id||' '||w.order_date||' '||w.order_status);
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('**Total order value: '||total);
    END LOOP;
END;
/
```

<img width="869" height="469" alt="image" src="https://github.com/user-attachments/assets/c2e442d7-aac9-44e9-b915-3d3782f2004b" />
<br>
<br>

**Exercise 7:** Display the top 3 doctors who have issued the most prescriptions.
```sql
SET SERVEROUTPUT ON
DECLARE
    CURSOR c IS SELECT COUNT(prescription_id) AS nr, doctor_id, doctor_name FROM prescriptions JOIN doctors USING(doctor_id)
    GROUP BY doctor_id, doctor_name
    ORDER BY COUNT(prescription_id) DESC
    FETCH FIRST 3 ROWS ONLY;
    v c%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('List with the first 3 doctors who have the most prescriptions issued.');
    OPEN c;
    LOOP
        FETCH c INTO v;
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Doctor '||v.doctor_name||' with ID '||v.doctor_id||' has a total of prescriptions issued: '||v.nr);
    END LOOP;
    CLOSE c;
END;
/
```

<img width="940" height="505" alt="image" src="https://github.com/user-attachments/assets/2f223f86-5ca3-478f-9e4d-8cc403eb4773" />
<br>
<br>

**Exercise 8:** Display information about the medicines from 'Farmacia Dona'.
```sql
SET SERVEROUTPUT ON
DECLARE
    CURSOR c IS SELECT generic_name, price FROM medicines
    JOIN order_items USING(medicine_id)
    JOIN orders USING(order_id)
    JOIN pharmacy USING(pharmacy_id)
    WHERE pharmacy_name='Farmacia Dona';
    v c%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('List with the medicines from Farmacia Dona.');
    OPEN c;
    LOOP
        FETCH c INTO v;
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('The medicine '||v.generic_name||' costs: '||v.price);
    END LOOP;
    CLOSE c;
END;
/
```

<img width="940" height="501" alt="image" src="https://github.com/user-attachments/assets/61216efc-f8c5-45fb-96f0-670133665f71" />
<br>
<br>
<br>
<br>

### 4. Functions, Procedures, Packages

**Exercise 1:** Create a package that contains:  

- A function named `pret_mediu` that calculates the average price of medicines specific to an effect provided as a parameter named `p_effect`.  

- A function named `cantitate_med` that takes `p_effect_name` and `p_an` as parameters and calculates the quantity of medicines in stock for the given effect and year to see which medicines expire in that year.  

- A procedure named `actualizare_stoc` that takes `p_medicine_id` and `p_added_quantity` as parameters, adding quantity to the stock for the medicine whose ID was entered, verifying if it has expired (if so, the stock is not updated).  

- A procedure named `medicamente_furnizor` that takes `p_supplier_id` as a parameter and displays the brand and form of the medicine(s) specific to the supplier.

```sql
CREATE OR REPLACE PACKAGE Info_medicamente AS
    FUNCTION pret_mediu(p_effect IN effects.effect_name%TYPE) RETURN NUMBER;
    FUNCTION cantitate_med(p_effect_name IN effects.effect_name%TYPE, p_an IN NUMBER) RETURN NUMBER;
    PROCEDURE actualizare_stoc(p_medicine_id IN medicines.medicine_id%TYPE, p_added_quantity IN NUMBER);
    PROCEDURE medicamente_furnizor(p_supplier_id IN supplies.supplier_id%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY Info_medicamente AS
    FUNCTION pret_mediu(p_effect IN effects.effect_name%TYPE) RETURN NUMBER AS
        v_pret_mediu NUMBER;
    BEGIN
        SELECT AVG(price) AS medie_pret INTO v_pret_mediu
        FROM medicines JOIN effects USING (effect_id)
        WHERE effect_name=p_effect;
        RETURN NVL(v_pret_mediu, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN 0;
    END;

    FUNCTION cantitate_med(p_effect_name IN effects.effect_name%TYPE, p_an IN NUMBER) RETURN NUMBER AS
        v_quantity NUMBER;
    BEGIN
        SELECT SUM(quantity_in_stock) AS quantity INTO v_quantity
        FROM medicines JOIN effects USING (effect_id)
        WHERE effect_name=p_effect_name
        AND EXTRACT(YEAR FROM expiration_date)=p_an;
        RETURN NVL(v_quantity, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN 0;
    END;

    PROCEDURE actualizare_stoc(p_medicine_id IN medicines.medicine_id%TYPE, p_added_quantity IN NUMBER) AS
        v_data_expirare DATE;
        v_final_quantity NUMBER;
    BEGIN
        SELECT expiration_date INTO v_data_expirare FROM medicines WHERE medicine_id=p_medicine_id;
        
        IF v_data_expirare<SYSDATE THEN
            DBMS_OUTPUT.PUT_LINE('The medicine is expired. The stock cannot be updated.');
        ELSE
            UPDATE medicines
            SET quantity_in_stock=quantity_in_stock+p_added_quantity
            WHERE medicine_id=p_medicine_id
            RETURNING quantity_in_stock INTO v_final_quantity;
            DBMS_OUTPUT.PUT_LINE('Stock updated successfully, final stock: '||v_final_quantity);
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('The medicine does not exist.');
    END;

    PROCEDURE medicamente_furnizor(p_supplier_id IN supplies.supplier_id%TYPE) AS
        nu_exista_medicamente EXCEPTION;
        v_count NUMBER := 0;
        CURSOR c IS SELECT brand_name, form_of_medicine
        FROM supplies JOIN orders USING(supplier_id)
        JOIN order_items USING (order_id)
        JOIN medicines USING (medicine_id)
        WHERE supplier_id=p_supplier_id;
    BEGIN
        FOR v IN c LOOP
            v_count := v_count + 1;
            DBMS_OUTPUT.PUT_LINE('Brand: '||v.brand_name||', Form: '||v.form_of_medicine);
        END LOOP;
        
        IF v_count = 0 THEN
            RAISE nu_exista_medicamente;
        END IF;
    EXCEPTION
        WHEN nu_exista_medicamente THEN
            DBMS_OUTPUT.PUT_LINE('There are no medicines for the given supplier.');
    END;
END;
/

-- Call
SET SERVEROUTPUT ON
DECLARE
    v_pret_mediu NUMBER;
    v_quantity NUMBER;
BEGIN
    v_pret_mediu:=Info_medicamente.pret_mediu('&effect_name');
    DBMS_OUTPUT.PUT_LINE('The average price of the medicines with the entered effect is: '||v_pret_mediu);
    
    v_quantity:=Info_medicamente.cantitate_med('&effect_name','&an_expirare');
    DBMS_OUTPUT.PUT_LINE('The quantity of medicines for the entered effect expiring in the specified year is: '||v_quantity||' pieces');
    
    Info_medicamente.actualizare_stoc(&id_medicament, &cantitate_adaugata);
    Info_medicamente.medicamente_furnizor('&id_supplier');
END;
/
```

<img width="864" height="456" alt="image" src="https://github.com/user-attachments/assets/e65a4336-8cb0-44d7-9cd3-1b9b7055e80d" />
<br>
<br>

**Exercise 2:** Create a subprogram package that contains:  

- A function named `valoare_totala_comanda` that takes `p_pharmacy_id` as a parameter and returns the total value of orders for that pharmacy.  

- A function named `inventar_medicamente` that takes `p_id_pharmacy` as a parameter and returns the number of medicines in that pharmacy (referring to the unique IDs of medicines, not stock quantity, to see how many different commercial names exist in a specific pharmacy).  

- A private function named `valoare_comanda` that takes `p_order_id` as a parameter and outputs the value of each order (while the first function shows the overall total for the pharmacy ID).  

- A procedure named `detalii_comenzi_farmacie` that takes `p_pharmacy_id` as a parameter and displays the orders within the pharmacy, their dates, and value for each, by calling the private function valoare_comanda.  

- A procedure named `afiseaza_farmacie` that takes `p_id_pharmacy` as a parameter and displays details regarding the name and location of the pharmacy for which the ID was entered.

```sql
CREATE OR REPLACE PACKAGE Info_farmacie AS
    FUNCTION valoare_totala_comanda(p_pharmacy_id IN pharmacy.pharmacy_id%TYPE) RETURN NUMBER;
    FUNCTION inventar_medicamente(p_id_pharmacy IN pharmacy.pharmacy_id%TYPE) RETURN NUMBER;
    PROCEDURE detalii_comenzi_farmacie(p_pharmacy_id IN pharmacy.pharmacy_id%TYPE);
    PROCEDURE afiseaza_farmacie(p_id_pharmacy IN pharmacy.pharmacy_id%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY Info_farmacie AS
    FUNCTION valoare_comanda(p_order_id IN orders.order_id%TYPE) RETURN NUMBER AS
        v_total NUMBER;
    BEGIN
        SELECT SUM(quantity_ordered * unit_price) INTO v_total
        FROM order_items WHERE order_id = p_order_id;
        RETURN NVL(v_total, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN 0;
    END;

    FUNCTION valoare_totala_comanda(p_pharmacy_id IN pharmacy.pharmacy_id%TYPE) RETURN NUMBER AS
        v_total NUMBER;
    BEGIN
        SELECT SUM(quantity_ordered*unit_price) INTO v_total
        FROM order_items JOIN orders USING (order_id)
        JOIN pharmacy USING (pharmacy_id)
        WHERE pharmacy_id=p_pharmacy_id;
        RETURN NVL(v_total, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN 0;
    END;

    FUNCTION inventar_medicamente(p_id_pharmacy IN pharmacy.pharmacy_id%TYPE) RETURN NUMBER AS
        v_med NUMBER;
    BEGIN
        SELECT COUNT(medicine_id) AS nr_medicamente INTO v_med
        FROM medicines JOIN order_items USING (medicine_id)
        JOIN orders USING (order_id)
        JOIN pharmacy USING (pharmacy_id)
        WHERE pharmacy_id=p_id_pharmacy;
        RETURN NVL(v_med, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN 0;
    END;

    PROCEDURE detalii_comenzi_farmacie(p_pharmacy_id IN pharmacy.pharmacy_id%TYPE) AS
        fara_comenzi EXCEPTION;
        v_count NUMBER := 0;
        CURSOR c IS SELECT order_id, order_date, pharmacy_id
        FROM orders WHERE pharmacy_id = p_pharmacy_id;
    BEGIN
        FOR v IN c LOOP
            v_count := v_count + 1;
            DBMS_OUTPUT.PUT_LINE('Order: '||v.order_id||', Date: '||v.order_date||', Value: '||valoare_comanda(v.order_id));
        END LOOP;
        
        IF v_count = 0 THEN
            RAISE fara_comenzi;
        END IF;
    EXCEPTION
        WHEN fara_comenzi THEN DBMS_OUTPUT.PUT_LINE('There are no orders for the given pharmacy.');
    END;

    PROCEDURE afiseaza_farmacie(p_id_pharmacy IN pharmacy.pharmacy_id%TYPE) AS
        v_name pharmacy.pharmacy_name%TYPE;
        v_location pharmacy.location%TYPE;
    BEGIN
        SELECT pharmacy_name, location INTO v_name, v_location
        FROM pharmacy WHERE pharmacy_id=p_id_pharmacy;
        DBMS_OUTPUT.PUT_LINE('Pharmacy name: '||v_name||', Location: '||v_location);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('The pharmacy for the entered ID does not exist.');
    END;
END;
/

-- Call
SET SERVEROUTPUT ON
DECLARE
    v_valoare NUMBER;
    v_med NUMBER;
BEGIN
    v_valoare:=Info_farmacie.valoare_totala_comanda(&id_pharmacy);
    DBMS_OUTPUT.PUT_LINE('Total order value for the entered pharmacy: '||v_valoare);
    
    v_med:=Info_farmacie.inventar_medicamente(&id_pharmacy);
    DBMS_OUTPUT.PUT_LINE('The number of medicines for the entered pharmacy is: '||v_med);
    
    Info_farmacie.detalii_comenzi_farmacie('&id_pharmacy');
    Info_farmacie.afiseaza_farmacie('&id_pharmacy');
END;
/
```

<img width="945" height="500" alt="image" src="https://github.com/user-attachments/assets/6af294b2-df7b-405f-9481-7f34be9f218a" />
<br>
<br>
<br>
<br>

### 5. Triggers

**Exercise 1:** Create a trigger that fires when inserting a new prescription exceeds the *limit of 3 prescriptions per day for a patient*.
```sql
CREATE OR REPLACE TRIGGER trg_limita_zilnica_prescriptii
BEFORE INSERT ON prescriptions
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM prescriptions
    WHERE patient_id = :NEW.patient_id
    AND TRUNC(prescription_date) = TRUNC(:NEW.prescription_date);
    
    IF v_count >= 3 THEN
        RAISE_APPLICATION_ERROR(-20002, 'The patient already has 3 prescriptions today.');
    END IF;
END;
/
```

<img width="865" height="455" alt="image" src="https://github.com/user-attachments/assets/7b42e513-69f5-4fd6-bc15-86388bd65c77" />
<br>
<br>

**Exercise 2:** Create a trigger that fires when inserting a new prescription specifies an ID for a patient that does not exist.
```sql
CREATE OR REPLACE TRIGGER trg_verificare_existenta_pacient
BEFORE INSERT ON prescriptions
FOR EACH ROW
DECLARE
    v_pacient NUMBER;
BEGIN
    SELECT 1 INTO v_pacient
    FROM patients
    WHERE patient_id = :NEW.patient_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'The patient does not exist!');
END;
/
```

<img width="945" height="503" alt="image" src="https://github.com/user-attachments/assets/f55382a5-6e37-44d6-9560-d7d61042b239" />
<br>
<br>

**Exercise 3:** Create a trigger that fires when attempting to update the `refills_allowed` property for a prescription that has *refills_allowed > 3*.
```sql
CREATE OR REPLACE TRIGGER trg_limita_refolosire
BEFORE UPDATE OF refills_allowed ON prescriptions
FOR EACH ROW
BEGIN
    IF :NEW.refills_allowed > :OLD.refills_allowed THEN
        DBMS_OUTPUT.PUT_LINE('That prescription can be used ' || :NEW.refills_allowed || ' times.');
        IF :NEW.refills_allowed > 3 THEN
            RAISE_APPLICATION_ERROR(-20002, 'The prescription cannot be used more than 3 times.');
        END IF;
    END IF;
END;
/
```

<img width="945" height="497" alt="image" src="https://github.com/user-attachments/assets/60855342-bf4b-42ed-baef-cc27b849e7a3" />
<br>
<br>
<br>
`Stay tuned for future updates!`
