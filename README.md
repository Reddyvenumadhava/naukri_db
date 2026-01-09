📦 Multi-Database Architecture – Job Portal System

This repository documents a multi-database MySQL architecture designed for a scalable job portal application (similar to Naukri / Internshala / LinkedIn).

The design separates data based on nature, sensitivity, and access patterns, following industry best practices.

🧱 Database Overview

The system uses three independent databases:

Database	Responsibility
meta_data	Master / lookup data
user_data	User identity & security
job_data	Career, education & preferences

This separation improves:

Scalability

Security

Maintainability

Performance

Clean schema design

🟩 1. meta_data Database

(Master / Lookup Data)

Purpose

Stores reference data shared across the system

Data changes very rarely

Used by multiple modules

Tables

salutations

skills

languages

colleges

courses

areas_of_interest

Characteristics

Stable

Low write operations

Cache-friendly

No user-specific data

Example Data

Skills: Java, Python, SQL

Languages: English, Hindi

Colleges: IITs, NITs

🟩 2. user_data Database

(User Identity & Security)

Purpose

Stores core user profile and authentication data

Contains sensitive and personal information

Tables

users

auth_credentials

password_history

user_contacts

addresses

user_emails

user_phones

school_profile

Key Rule

✅ All foreign keys exist only within this database
❌ No cross-database foreign keys

Why Separate?

Strong security isolation

Easier compliance (privacy, audits)

Independent backups

Restricted access control

🟨 3. job_data Database

(Career & Job Information)

Purpose

Stores frequently changing, high-volume data

Optimized for job search, matching & analytics

Tables

education

work_experience

job_preferences

user_skills

user_languages

user_interests

Design Rule

❗ No database-level foreign keys
Only logical references using IDs:

user_id

skill_id

language_id

Why?

High read/write performance

Easier horizontal scaling

Analytics-friendly

No FK locking overhead

🔗 Cross-Database Relationship Strategy
Database	Relationship Handling
meta_data	Reference IDs
user_data	Strict FK constraints
job_data	Logical references only

👉 Cross-database joins are handled at the application layer, not at the database layer.

🧠 Design Philosophy
“Keep master data stable, user data secure, and job data scalable.”

🛠 Technologies
MySQL
SQL
GitHub version control
