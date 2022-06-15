Problem Statement:

This database aims to store detailed health records (EHR) of patients, consisting of medical history, encounters, billing
information, and personal details. The database will also maintain data for various entities, namely departments,
infrastructure units, labs, employees, and facilitate their interactions within the hospital. The consolidated data will help
the administrator achieve a quick decision-making cycle resulting in efficient functioning of the system.

Problem Addressed:
1. The system enables patients to access detailed health records and provide their encounter details with a doctor,
billing information, and personal information.
2. The detailed health records consist of the patient’s vital signs, doctor’s assessment, admission history,
laboratory tests, and reports.
3. The system also helps provide the administrator with a bird’s eye view, making it easier for him to visualize and
manage the system, leading to a faster reaction time during emergencies.

Design Rules:

Each Staff can belong to one or more department.

Each Staff can have one and only one role.

Each Staff can have one or more address.

Each mapping of a Staff and Address will be a record in staff address relation.

Each Patient can have one or more encounters with Staff

Each Patient can have zero or more insurance.

Each Patient can have one or more address.

Each mapping of a Patient and Address will be a record in patient address relation.

Each Patient can have one or more billing records.

Each Patient encounter will have exactly one bill.

Each Patient encounter will have zero or more admission history records and laboratory tests.

Each Patient encounter will have exactly one vital sign record.

Each Lab test will have one or many Lab reports.

Each Patient admission record will have exactly one infrastructure unit occupied.

Each Infrastructure type will have one or more infrastructure unit.

Patient Accounts will calculate a consolidated bill for total treatment including admission 
fee.
