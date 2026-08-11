# eSupport — Oracle Database & APEX

eSupport is a service-management database project built with **Oracle SQL**, **PL/SQL**, and **Oracle APEX**.

The project models clients, devices, service points, users and roles, service tickets, invoices, invoice details, and technical documentation. An Oracle APEX application provides a web interface for working with the database.

## Features

- Client management
- Device management
- Service ticket tracking
- Service catalog
- Invoice management
- Service-point and role-based data model
- Warranty and repeat-defect logic
- PL/SQL functions and procedures
- Database views for reporting
- Oracle APEX web interface
- Dashboard overview with live database counts

## Project Structure

```text
esupport-oracle-apex/
├── sql/
│   ├── 01_tables.sql
│   ├── 02_sequences.sql
│   ├── 03_functions.sql
│   ├── 04_procedures.sql
│   ├── 05_views.sql
│   └── 06_insert_data.sql
├── apex/
│   └── f13584.sql
├── README.md
└── .gitignore
```

## Database Setup

Run the SQL scripts in this exact order:

1. `sql/01_tables.sql`
2. `sql/02_sequences.sql`
3. `sql/03_functions.sql`
4. `sql/04_procedures.sql`
5. `sql/05_views.sql`
6. `sql/06_insert_data.sql`

The final script loads the project data used to demonstrate the application.

## Oracle APEX

The exported APEX application is stored in:

```text
apex/f13584.sql
```

Import this file from Oracle APEX using the application import workflow after the database schema objects are available.

## Main Database Objects

### Tables

- `KLIENTI`
- `ROL`
- `PIKA_SHERBIMI`
- `LLOJ_PAJISJE`
- `MARKA`
- `LLOJ_SHERBIMI`
- `PERDORUES`
- `PAJISJE`
- `PIKA_SHP_SHERBIM`
- `TICKET`
- `FATURA`
- `FATURA_DETAJE`
- `DOKUMENTIM`

### PL/SQL

The project contains functions and procedures for operations such as warranty checks, repeat-defect checks, invoice calculations, client registration, ticket creation, service processing, and documentation management.

### Views

Views are included for presenting ticket information for different application use cases and roles.

## Technologies

- Oracle Database
- SQL
- PL/SQL
- Oracle APEX

## Purpose

This project was developed as a database coursework project and demonstrates relational database design, constraints, sequences, PL/SQL programming, reporting views, sample data, and a web application built on top of the Oracle schema.
