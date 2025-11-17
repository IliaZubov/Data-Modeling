<h1>Data Modeling Exercise</h1>

<h2>Conceptual data model</h2>
<img width="1262" height="830" alt="Screenshot 2025-11-17 133538" src="https://github.com/user-attachments/assets/c842d3a0-8848-4bad-83ac-9dd0420a09b0" />

<h2>Logical data model</h2>
<img width="1781" height="791" alt="Data Model drawio (2)" src="https://github.com/user-attachments/assets/fb3ff993-730d-4e4f-9df9-4e371e87e4af" />

<h2>Exercise 2</h2>
The data model is normalized. The design follows the main principles of database normalization:

<b>1st Normal Form (1NF) —</b>
  - All tables contain atomic values, each row is uniquely identifiable by a primary key, and repeating groups are separated into their own tables (e.g., order lines, product prices).

<b>2nd Normal Form (2NF) —</b>
  - Non-key attributes depend fully on the primary key. For example, order line quantities and totals depend on the combined context of an order and product, not on any partial key.

<b>3rd Normal Form (3NF) —</b>
  - Non-key attributes do not depend on other non-key attributes.
  - Product information is stored in the products table, not repeated in order lines.
  - Customer data is stored only in customers, not duplicated in orders.
  - Product prices are maintained in a separate product_prices table to avoid storing historical price changes incorrectly inside the product or order tables.

<b>By separating customers, orders, order lines, suppliers, product categories, and product prices into their own tables, the model reduces redundancy and prevents update anomalies.</b>

<b>A fully denormalized version would simplify some queries but would introduce major risks, including inconsistency, storage inefficiency, harder updates, and significantly more complex application logic.</b>

<h2>Exercise 3</h2>
<b>SCD Type 2 is used when the system must keep a full history of changes to an attribute over time:</b>


  * Customers can move between loyalty levels (Bronze → Silver → Gold, or downgrade).
  * Each loyalty tier is valid only for a specific time period.
  * We must retain past loyalty levels for accurate reporting and historical analysis.

<img width="2151" height="791" alt="Data Model drawio (6)" src="https://github.com/user-attachments/assets/b7531dab-88cd-46be-8c6e-f5c7489cc89e" />
