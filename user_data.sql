CREATE SCHEMA IF NOT EXISTS user_data;
USE user_data;
CREATE TABLE IF NOT EXISTS users (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    last_name VARCHAR(100),

    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,

    gender ENUM('MALE','FEMALE','OTHER'),

    status ENUM('ACTIVE','INACTIVE','SUSPENDED') DEFAULT 'ACTIVE',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS auth_credentials (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL UNIQUE,

    password_hash VARCHAR(255) NOT NULL,
    failed_login_attempts INT DEFAULT 0,
    account_locked BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_auth_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id)
);
CREATE TABLE IF NOT EXISTS password_history (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    password_hash VARCHAR(255) NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_password_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id)
);
CREATE TABLE IF NOT EXISTS user_contacts (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    contact_type ENUM('EMERGENCY','REFERENCE') NOT NULL,
    contact_name VARCHAR(100) NOT NULL,
    relationship VARCHAR(50),

    phone VARCHAR(15),
    email VARCHAR(150),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_contacts_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id)
);
CREATE TABLE IF NOT EXISTS addresses (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    country_id INT NOT NULL,
    state_id INT NOT NULL,
    city_id INT NOT NULL,

    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    pincode VARCHAR(10),

    address_type ENUM('CURRENT','PERMANENT','OFFICE'),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_address_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id),

    CONSTRAINT fk_address_country
        FOREIGN KEY (country_id)
        REFERENCES meta_data.countries(row_id),

    CONSTRAINT fk_address_state
        FOREIGN KEY (state_id)
        REFERENCES meta_data.states(row_id),

    CONSTRAINT fk_address_city
        FOREIGN KEY (city_id)
        REFERENCES meta_data.cities(row_id)
);
CREATE TABLE IF NOT EXISTS user_emails (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    email VARCHAR(150) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_user_email UNIQUE (user_id, email),

    CONSTRAINT fk_user_emails_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id)
);
CREATE TABLE IF NOT EXISTS user_phones (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    phone VARCHAR(15) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_user_phone UNIQUE (user_id, phone),

    CONSTRAINT fk_user_phones_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id)
);
CREATE TABLE IF NOT EXISTS user_skills (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,
    skill_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_user_skill UNIQUE (user_id, skill_id),

    CONSTRAINT fk_user_skills_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id),

    CONSTRAINT fk_user_skills_skill
        FOREIGN KEY (skill_id)
        REFERENCES meta_data.skills(row_id)
);
CREATE TABLE IF NOT EXISTS user_languages (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,
    language_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_user_language UNIQUE (user_id, language_id),

    CONSTRAINT fk_user_languages_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id),

    CONSTRAINT fk_user_languages_language
        FOREIGN KEY (language_id)
        REFERENCES meta_data.languages(row_id)
);
CREATE TABLE IF NOT EXISTS user_interests (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,
    interest_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_user_interest UNIQUE (user_id, interest_id),

    CONSTRAINT fk_user_interests_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id),

    CONSTRAINT fk_user_interests_interest
        FOREIGN KEY (interest_id)
        REFERENCES meta_data.areas_of_interest(row_id)
);
CREATE TABLE IF NOT EXISTS education (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,
    college_id INT NOT NULL,
    course_id INT NOT NULL,

    start_year INT,
    end_year INT,
    grade VARCHAR(20),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_education_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id),

    CONSTRAINT fk_education_college
        FOREIGN KEY (college_id)
        REFERENCES meta_data.colleges(row_id),

    CONSTRAINT fk_education_course
        FOREIGN KEY (course_id)
        REFERENCES meta_data.courses(row_id)
);
CREATE TABLE IF NOT EXISTS work_experience (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    company_name VARCHAR(150),
    designation VARCHAR(100),

    start_date DATE,
    end_date DATE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_work_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id)
);
CREATE TABLE IF NOT EXISTS school_profile (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL UNIQUE,

    school_name VARCHAR(150),
    standard VARCHAR(50),
    board VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_school_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id)
);
CREATE TABLE IF NOT EXISTS job_preferences (
    row_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL UNIQUE,

    preferred_city_id INT,
    work_mode ENUM('REMOTE','HYBRID','ONSITE'),
    expected_salary INT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_job_user
        FOREIGN KEY (user_id)
        REFERENCES users(row_id),

    CONSTRAINT fk_job_city
        FOREIGN KEY (preferred_city_id)
        REFERENCES meta_data.cities(row_id)
);

