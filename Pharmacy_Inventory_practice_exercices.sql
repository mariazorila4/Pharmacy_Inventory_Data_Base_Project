--PRACTICE EXERCICES PHARMACY INVENTORY

--EX.1:Calculeaz� suma total� a medicamentelor �n stoc (quantity_in_stock) pentru fiecare produc�tor (manufacturer) din tabela medicines.

SELECT manufacturer, SUM(quantity_in_stock) AS total_in_stock
FROM medicines
GROUP BY manufacturer;

--EX.2:Afi?eaz� num�rul total de comenzi (orders) pentru fiecare furnizor (supplier_name) din tabela supplies.

SELECT s.supplier_name, COUNT(o.order_id) AS total_orders
FROM supplies s
JOIN orders o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_name;

--EX.3:Calculeaz� suma total� a valorii comenzilor (total_amount) pentru fiecare farmacie (pharmacy_name) din tabela pharmacy.

SELECT p.pharmacy_name, SUM(o.total_amount) AS total_value
FROM pharmacy p
JOIN orders o ON p.pharmacy_id = o.pharmacy_id
GROUP BY p.pharmacy_name;


--EX.4:Calculeaz� num�rul de pacien?i trata?i de fiecare doctor (doctor_name) folosind tabela prescriptions.

SELECT d.doctor_name, COUNT(p.prescription_id) AS total_prescriptions
FROM doctors d
JOIN prescriptions p ON d.doctor_id = p.doctor_id
GROUP BY d.doctor_name;


--EX.5:Calculeaz� suma total� ?i valoarea medie a medicamentelor comandate (quantity_ordered * unit_price) pentru fiecare order_id din tabela order_items.

SELECT order_id, 
       SUM(quantity_ordered * unit_price) AS total_value,
       AVG(quantity_ordered * unit_price) AS average_value
FROM order_items
GROUP BY order_id;

--EX.6:Afi?eaz� furnizorii (supplier_name) care au primit comenzi cu o valoare total� (total_amount) mai mare de 200.

SELECT s.supplier_name, SUM(o.total_amount) AS total_value
FROM supplies s
JOIN orders o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_name
HAVING SUM(o.total_amount) > 200;


--EX.7:Calculeaz� num�rul total de medicamente prescrise (quantity_prescribed) pentru fiecare prescription_id.

SELECT prescription_id, SUM(quantity_prescribed) AS total_quantity
FROM prescription_medicines
GROUP BY prescription_id;


--EX.8:Afi?eaz� farmaciile care au primit cel putin de o comanda, �mpreun� cu suma total� a comenzilor.

SELECT p.pharmacy_name, COUNT(o.order_id) AS total_orders
FROM pharmacy p
JOIN orders o ON p.pharmacy_id = o.pharmacy_id
GROUP BY p.pharmacy_name
HAVING COUNT(o.order_id) >= 1;


--EX.9:Identific� doctorii care au emis cel putin o reteta, folosind tabela prescriptions.

SELECT d.doctor_name, COUNT(p.prescription_id) AS total_prescriptions
FROM doctors d
JOIN prescriptions p ON d.doctor_id = p.doctor_id
GROUP BY d.doctor_name
HAVING COUNT(p.prescription_id) >= 1;


--EX.10:Afi?eaz� medicamentele (generic_name) din tabela medicines care au fost comandate �n cantit�?i mai mari de 10 din tabela order_items.

SELECT m.generic_name, SUM(oi.quantity_ordered) AS total_ordered
FROM medicines m
JOIN order_items oi ON m.medicine_id = oi.medicine_id
GROUP BY m.generic_name
HAVING SUM(oi.quantity_ordered) > 10;


--EX.11:Clasific� comenzile din tabela orders astfel:
--total_amount > 200: Valoare Mare
--total_amount �ntre 100 ?i 200: Valoare Medie
--total_amount < 100: Valoare Mic�

SELECT order_id, total_amount,
       CASE 
           WHEN total_amount > 200 THEN 'Valoare Mare'
           WHEN total_amount BETWEEN 100 AND 200 THEN 'Valoare Medie'
           ELSE 'Valoare Mic�'
       END AS clasificare
FROM orders;


--EX.12:Clasific� medicamentele din tabela medicines �n func?ie de pre? (price):
--Pre? < 10: Ieftin
--Pre? �ntre 10 ?i 20: Medie
--Pre? > 20: Scump

SELECT generic_name, price,
       CASE 
           WHEN price < 10 THEN 'Ieftin'
           WHEN price BETWEEN 10 AND 20 THEN 'Medie'
           ELSE 'Scump'
       END AS categorie
FROM medicines;


--EX.13:Acord� reduceri comenzilor astfel:
--Dac� supplier_id este �ntre 201 ?i 210, aplic� o reducere de 10%.
--Dac� supplier_id este �ntre 211 ?i 220, aplic� o reducere de 15%.
--Altfel, aplic� o reducere de 5%.

SELECT order_id, supplier_id, total_amount,
       CASE 
           WHEN supplier_id BETWEEN 201 AND 210 THEN total_amount * 0.9
           WHEN supplier_id BETWEEN 211 AND 220 THEN total_amount * 0.85
           ELSE total_amount * 0.95
       END AS total_reduced
FROM orders;

--EX.14:Afi?eaz� numele medicamentelor ?i efectele lor din tabelele medicines ?i effects.

SELECT m.generic_name, e.effect_name
FROM medicines m
JOIN effects e ON m.effect_id = e.effect_id


--EX.15:Afi?eaz� comenzile (order_id) care con?in medicamente cu efectul Ameliorarea durerilor de cap.

SELECT DISTINCT o.order_id
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN medicines m ON oi.medicine_id = m.medicine_id
JOIN effects e ON m.effect_id = e.effect_id
WHERE e.effect_name = 'Ameliorarea durerilor de cap';


--EX.16:Identific� pacien?ii (patient_name) care au primit re?ete pentru medicamente fabricate de Pfizer.

SELECT DISTINCT p.patient_name
FROM patients p
JOIN prescriptions pr ON p.patient_id = pr.patient_id
JOIN prescription_medicines pm ON pr.prescription_id = pm.prescription_id
JOIN medicines m ON pm.medicine_id = m.medicine_id
WHERE m.manufacturer = 'Pfizer';


--EX.17:Afi?eaz� comenzile (order_id) emise �n luna februarie 2024.

SELECT * 
FROM orders
WHERE EXTRACT(MONTH FROM order_date) = 2 AND EXTRACT(YEAR FROM order_date) = 2024;

--EX.18:Afi?eaz� medicamentele care vor expira �n urm�toarele 6 luni.

SELECT generic_name, expiration_date
FROM medicines
WHERE expiration_date <= ADD_MONTHS(SYSDATE, 6);


--EX.19:Folose?te MINUS pentru a afi?a medicamentele din tabela medicines care nu au fost comandate �n order_items.

SELECT medicine_id, generic_name
FROM medicines
MINUS
SELECT DISTINCT m.medicine_id, m.generic_name
FROM medicines m
JOIN order_items oi ON m.medicine_id = oi.medicine_id;


--EX.20:Folose?te UNION pentru a afi?a toate comenzile care sunt fie Livrate, fie au total_amount = 0.

SELECT * 
FROM orders
WHERE order_status = 'Livrat'
UNION
SELECT * 
FROM orders
WHERE total_amount = 0;

--EX.21:Identific� pacien?ii care au primit cele mai multe medicamente diferite, �mpreun� cu num�rul lor total.

SELECT p.patient_id, p.patient_name, COUNT(DISTINCT pm.medicine_id) AS numar_medicamente
FROM patients p
JOIN prescriptions pr ON p.patient_id = pr.patient_id
JOIN prescription_medicines pm ON pr.prescription_id = pm.prescription_id
GROUP BY p.patient_id, p.patient_name
ORDER BY numar_medicamente DESC;


--EX.22:Afi?eaz� numele doctorilor ?i num�rul total de re?ete emise pentru pacien?i, doar pentru medicamente cu un pre? mai mare de 10.

SELECT d.doctor_name, COUNT(pr.prescription_id) AS total_retete
FROM doctors d
JOIN prescriptions pr ON d.doctor_id = pr.doctor_id
JOIN prescription_medicines pm ON pr.prescription_id = pm.prescription_id
JOIN medicines m ON pm.medicine_id = m.medicine_id
WHERE m.price > 10
GROUP BY d.doctor_name
ORDER BY total_retete DESC;


--EX.23:G�se?te comenzile care au cel pu?in un produs expirat (din order_items) ?i afi?eaz� ID-ul comenzii, data comenzii ?i num�rul de produse expirate.
SELECT o.order_id, o.order_date, COUNT(oi.order_item_id) AS produse_expirate
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.expected_expiration_date < SYSDATE
GROUP BY o.order_id, o.order_date
HAVING COUNT(oi.order_item_id) > 0;


--EX.24:Afi?eaz� furnizorii care au livrat medicamente asociate cu efectul "Ameliorarea durerilor de cap". Afi?eaz� numele furnizorului ?i num�rul total de medicamente livrate.
SELECT s.supplier_name, COUNT(oi.medicine_id) AS numar_medicamente_livrate
FROM supplies s
JOIN orders o ON s.supplier_id = o.supplier_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN medicines m ON oi.medicine_id = m.medicine_id
JOIN effects e ON m.effect_id = e.effect_id
WHERE e.effect_name = 'Ameliorarea durerilor de cap'
GROUP BY s.supplier_name
ORDER BY numar_medicamente_livrate DESC;


--EX.25:Identific� farmaciile care au plasat comenzi cu valoare total� mai mare dec�t media tuturor comenzilor ?i afi?eaz� numele farmaciei ?i suma total� a comenzilor.
SELECT p.pharmacy_name, SUM(o.total_amount) AS suma_comenzi
FROM pharmacy p
JOIN orders o ON p.pharmacy_id = o.pharmacy_id
GROUP BY p.pharmacy_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount) 
    FROM orders
)
ORDER BY suma_comenzi DESC;

--EX.26:Afi?eaz� top 5 medicamente cu cele mai mari cantit�?i comandate, �mpreun� cu numele generic, produc�torul ?i cantitatea total� comandat�.
SELECT m.generic_name, m.manufacturer, SUM(oi.quantity_ordered) AS total_cantitate
FROM medicines m
JOIN order_items oi ON m.medicine_id = oi.medicine_id
GROUP BY m.generic_name, m.manufacturer
ORDER BY total_cantitate DESC
FETCH FIRST 5 ROWS ONLY;

