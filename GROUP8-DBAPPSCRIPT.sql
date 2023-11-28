-- -----------------------------------------------------
-- Schema hoa_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS financial_leasing;
CREATE SCHEMA IF NOT EXISTS financial_leasing;
USE financial_leasing;

-- -----------------------------------------------------
-- Table zipcodes
-- -----------------------------------------------------
DROP TABLE IF EXISTS zipcodes;
CREATE TABLE IF NOT EXISTS zipcodes (
  zipcode		INT NOT NULL,
  brgy			VARCHAR(45) NOT NULL,
  PRIMARY KEY	(zipcode)
);

-- -----------------------------------------------------
-- Table address
-- -----------------------------------------------------
DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address (
  address_id	INT NOT NULL,
  street_no		VARCHAR(45) NOT NULL,
  street_name	VARCHAR(45) NOT NULL,
  barangay		VARCHAR(45) NOT NULL,
  city			VARCHAR(45) NOT NULL,
  province		VARCHAR(45) NOT NULL,
  zipcode		INT NOT NULL,
  PRIMARY KEY	(address_id),
  INDEX			(zipcode ASC),
  FOREIGN KEY	(zipcode)
    REFERENCES	zipcodes(zipcode)
);

-- -----------------------------------------------------
-- Table lessees
-- -----------------------------------------------------
DROP TABLE IF EXISTS lessees;
CREATE TABLE IF NOT EXISTS lessees (
    lessee_id           INT NOT NULL,
    name_last           VARCHAR(45) NOT NULL,
    name_middle			VARCHAR(45) NOT NULL,
    name_first          VARCHAR(45) NOT NULL,
    email               VARCHAR(100) NOT NULL,
    date_of_birth       DATE NOT NULL,
    address             INT NOT NULL,
    PRIMARY KEY         (lessee_id),
    INDEX               (address ASC),
    FOREIGN KEY         (address)
        REFERENCES      address(address_id)
);

-- -----------------------------------------------------
-- Table mobile
-- -----------------------------------------------------
DROP TABLE IF EXISTS mobile;
CREATE TABLE IF NOT EXISTS mobile (
  phone_no		BIGINT(10) NOT NULL,
  lessee_id     INT NOT NULL,
  PRIMARY KEY	(phone_no),
  INDEX			(lessee_id ASC),
  FOREIGN KEY	(lessee_id)
    REFERENCES	lessees(lessee_id)
);

-- -----------------------------------------------------
-- Table assets
-- -----------------------------------------------------
DROP TABLE IF EXISTS assets;
CREATE TABLE IF NOT EXISTS assets (
    asset_id        INT,
    asset_name      VARCHAR(100) NOT NULL,
    description     TEXT,
    asset_type		VARCHAR(45) NOT NULL,
    category        VARCHAR(50) NOT NULL,
    purchase_date   DATE,
    purchase_cost   FLOAT,
    warranty_info   TEXT,
    asset_condition ENUM('Excellent', 'Good', 'Fair', 'Poor', 'Out of Service'),
	address_id		INT,
	PRIMARY KEY	(asset_id),
	INDEX		(asset_id ASC),
	FOREIGN KEY	(address_id)
		REFERENCES	address(address_id)
);

-- -----------------------------------------------------
-- Table maintenance_schedule
-- -----------------------------------------------------
DROP TABLE IF EXISTS maintenance_schedule;
CREATE TABLE IF NOT EXISTS maintenance_schedule (
    maintenance_id      INT NOT NULL,
    frequency           ENUM('daily', 'weekly', 'quarterly', 'semi annual', 'annualy', 'as needed') NOT NULL,
    last_maintenance    DATE,
    next_maintenance    DATE,
    asset_id            INT NOT NULL,
    PRIMARY KEY         (maintenance_id),
    INDEX               (asset_id ASC),
    FOREIGN KEY         (asset_id)
        REFERENCES      assets(asset_id)
);


-- -----------------------------------------------------
-- Table lease_contracts
-- -----------------------------------------------------
DROP TABLE IF EXISTS lease_contracts;
CREATE TABLE IF NOT EXISTS lease_contracts (
    contract_id             INT NOT NULL,
    start_date              DATE NOT NULL,
    end_date                DATE NOT NULL,
    monthly_due             FLOAT NOT NULL,
    status                  ENUM('active', 'expired', 'terminated', 'renewed') NOT NULL,
    payment_history         TEXT,
    terms_and_conditions    TEXT NOT NULL,
    renewal_option          BOOLEAN,
    deposit_amount          FLOAT,
    lessee_id               INT,
    asset_id                INT,
    PRIMARY KEY             (contract_id),
    INDEX                   (lessee_id ASC),
    INDEX                   (asset_id ASC),
    FOREIGN KEY             (lessee_id)
        REFERENCES          lessees(lessee_id),
    FOREIGN KEY             (asset_id)
        REFERENCES          assets(asset_id)
);

-- -----------------------------------------------------
-- Table asset_usage
-- -----------------------------------------------------
DROP TABLE IF EXISTS asset_usage;
CREATE TABLE IF NOT EXISTS asset_usage (
    usage_id         INT,
    asset_id         INT,
    start_date       DATE,
    end_date         DATE,
    usage_description TEXT,
    PRIMARY KEY (usage_id),
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
);

-- -----------------------------------------------------
-- Table asset_finance
-- -----------------------------------------------------
DROP TABLE IF EXISTS asset_finance;
CREATE TABLE IF NOT EXISTS asset_finance (
    finance_id      INT PRIMARY KEY,
    asset_id        INT,
    lease_contract_id INT,
    purchase_price  FLOAT,
    leasing_cost    FLOAT,
    down_payment    FLOAT,
    financing_start_date DATE,
    financing_end_date DATE,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    FOREIGN KEY (lease_contract_id) REFERENCES lease_contracts(contract_id)
);


-- -----------------------------------------------------
-- Table payment_record
-- -----------------------------------------------------
DROP TABLE IF EXISTS payment_record;
CREATE TABLE IF NOT EXISTS payment_record(
    payment_id				INT,
    leesee_id				INT NOT NULL,
    date_of_payment			DATETIME NOT NULL,
    amount_paid				FLOAT NOT NULL,
    payment_method			VARCHARACTER(45),
    status					ENUM('Completed', 'Pending', 'Disputed'),
    lease_contract			INT,
    late_fee				FLOAT,
    PRIMARY KEY				(payment_id),
    FOREIGN KEY				(leesee_id) REFERENCES lessees(lessee_id ),
    FOREIGN KEY				(lease_contract) REFERENCES lease_contracts(contract_id)
);

-- -----------------------------------------------------
-- Table employment_info
-- -----------------------------------------------------
DROP TABLE IF EXISTS employment_info;
CREATE TABLE IF NOT EXISTS employment_info (
    employment_id       INT,
    lessee_id			INT NOT NULL,
    job_title			VARCHAR(100) NOT NULL,
    company_name		VARCHAR(100) NOT NULL,
    monthly_salary		FLOAT NOT NULL,
    employer_name		VARCHAR(100),
    PRIMARY KEY         (employment_id),
    FOREIGN KEY         (lessee_id)
        REFERENCES      lessees(lessee_id)
);

-- -----------------------------------------------------
-- Table insurance_info
-- -----------------------------------------------------
DROP TABLE IF EXISTS insurance_info;
CREATE TABLE IF NOT EXISTS insurance_info (
    insurance_id        INT,
    lessee_id			INT NOT NULL,
    policy_no			INT NOT NULL,
    coverage			FLOAT NOT NULL,
    insurance_company	VARCHAR(100) NOT NULL,
    expiration_date		DATE NOT NULL,
    file_terms			VARCHAR(100) NOT NULL,
    PRIMARY KEY         (insurance_id),
    FOREIGN KEY         (lessee_id)
        REFERENCES      lessees(lessee_id)
);

-- -----------------------------------------------------
-- Table financial_info
-- -----------------------------------------------------
DROP TABLE IF EXISTS financial_info;
CREATE TABLE IF NOT EXISTS financial_info (
    finance_id	       			INT,
    lessee_id					INT NOT NULL,
    credit_score				INT NOT NULL,
    bank_name					VARCHAR(100) NOT NULL,
    net_income 					FLOAT NOT NULL,
    file_credit_history 		VARCHAR(100) NOT NULL,
    file_cashflow_statement 	VARCHAR(100) NOT NULL,
    PRIMARY KEY         (finance_id),
    FOREIGN KEY         (lessee_id)
        REFERENCES      lessees(lessee_id)
);

-- Add records to zipcodes table
INSERT INTO zipcodes VALUES
(1000, 'Intramuros'),
(2000, 'San Miguel'),
(3000, 'Ermita'),
(4000, 'Malate'),
(5000, 'Paco'),
(6000, 'Pandacan'),
(7000, 'Sampaloc'),
(8000, 'Santa Ana'),
(9000, 'Santa Cruz');

-- Add records to address table
INSERT INTO address VALUES
(1001, '123', 'Main Street', 'Intramuros', 'Manila', 'Metro Manila', 1000),
(1002, '456', 'Broadway Ave', 'San Miguel', 'Manila', 'Metro Manila', 2000),
(1003, '789', 'Ocean Drive', 'Ermita', 'Manila', 'Metro Manila', 3000),
(1004, '101', 'Sunset Blvd', 'Malate', 'Manila', 'Metro Manila', 4000),
(1005, '273', 'Rosewood Ave', 'Paco', 'Manila', 'Metro Manila', 5000),
(1006, '408', 'Pine Drive', 'Pandacan', 'Manila', 'Metro Manila', 6000),
(1007, '440', 'Cedar Street', 'Sampaloc', 'Manila', 'Metro Manila', 7000),
(1008, '555', 'Maple Street', 'Santa Ana', 'Manila', 'Metro Manila', 8000),
(1009, '678', 'Oak Street', 'Santa Cruz', 'Manila', 'Metro Manila', 9000);

-- Add records to lessees table
-- Note: The addresses in the next statements must already exist in the address table
INSERT INTO lessees VALUES
(99991, 'Doe', 'M', 'John', 'john.doe@gmail.com', '1990-05-15', 1001),
(99992, 'Smith', 'A', 'Alice', 'alice.smith@gmail.com', '1985-08-22', 1002),
(99993, 'Johnson', 'R', 'Robert', 'robert.johnson@gmail.com', '1992-03-10', 1003),
(99994, 'Williams', 'S', 'Sarah', 'sarah.williams@gmail.com', '1988-11-28', 1004),
(99995, 'Jones', 'T', 'Thomas', 'jones.thomas@gmail.com', '1991-07-01', 1005),
(99996, 'Brown', 'E', 'Elizabeth', 'brown.elizabeth@gmail.com', '1987-04-12', 1006),
(99997, 'Davis', 'W', 'William', 'davis.william@gmail.com', '1993-09-05', 1007),
(99998, 'Miller', 'J', 'Jennifer', 'miller.jennifer@gmail.com', '1989-12-31', 1008),
(99999, 'Wilson', 'C', 'Charles', 'wilson.charles@gmail.com', '1994-02-18', 1009); 

-- Add records to mobile table
-- Note: The lessees in the next statements must already exist in the lessees table
INSERT INTO mobile VALUES
(1234567890, 99991),
(2345678901, 99992),
(3456789012, 99993),
(4567890123, 99994),
(5678901234, 99995),
(6789012345, 99996),
(7890123456, 99997),
(8901234567, 99998),
(9012345678, 99999);

-- Add records to assets table
INSERT INTO assets VALUES
(55551, 'Laptop', 'High-performance laptop for business use', 'Electronics', 'IT Equipment', '2022-01-15', 1200.00, '1-year warranty', 'Excellent', 1001),
(55552, 'Office Chair', 'Ergonomic office chair with adjustable features', 'Furniture', 'Office Furniture', '2022-02-10', 150.00, 'No warranty', 'Good', 1002),
(55553, 'Delivery Van', 'Commercial delivery van for transporting goods', 'Vehicle', 'Transportation', '2021-12-05', 25000.00, '2-year warranty', 'Excellent', 1003),
(55554, 'Desktop Computer', 'Powerful desktop computer for graphic design', 'Electronics', 'IT Equipment', '2022-03-20', 1800.00, '2-year warranty', 'Excellent', 1004),
(55555, 'Office Desk', 'Modern office desk with built-in storage', 'Furniture', 'Office Furniture', '2022-04-25', 200.00, 'No warranty', 'Fair', 1005),
(55556, 'Delivery Truck', 'Commercial delivery truck for transporting goods', 'Vehicle', 'Transportation', '2022-05-30', 35000.00, '2-year warranty', 'Excellent', 1006),
(55557, 'Nintendo Switch', 'Portable gaming console', 'Electronics', 'Gaming Console', '2022-06-15', 800.00, '1-year warranty', 'Excellent', 1007),
(55558, 'Office Chair', 'Ergonomic office chair with adjustable features', 'Furniture', 'Office Furniture', '2022-07-10', 150.00, 'No warranty', 'Good', 1008),
(55559, 'Delivery Van', 'Commercial delivery van for transporting goods', 'Vehicle', 'Transportation', '2022-08-05', 25000.00, '2-year warranty', 'Excellent', 1009);

-- Add records to maintenance_schedule table
-- Note: The assets in the next statements must already exist in the assets table
INSERT INTO maintenance_schedule VALUES
(11111, 'daily', '2022-01-15', '2022-01-15', 55551),
(11112, 'weekly', '2022-02-10', '2022-02-17', 55552),
(11113, 'quarterly', '2022-03-20', '2022-06-20', 55553),
(11114, 'semi annual', '2022-04-25', '2022-10-25', 55554),
(11115, 'annualy', '2022-05-30', '2023-05-30', 55555),
(11116, 'as needed', '2022-06-15', '2022-06-15', 55556),
(11117, 'daily', '2022-07-10', '2022-07-10', 55557),
(11118, 'weekly', '2022-08-05', '2022-08-12', 55558),
(11119, 'quarterly', '2022-09-01', '2022-12-01', 55559);

-- Add records to lease_contracts table
-- Note: The lessees and assets in the next statements must already exist in their respective tables
INSERT INTO lease_contracts VALUES
(10001, '2023-01-01', '2023-12-31', 1500.00, 'active', 'Payment history for contract 10001', 'Standard terms and conditions', 1, 2000.00, 99991, 55551),
(10002, '2023-02-15', '2023-11-30', 1200.00, 'expired', 'Payment history for contract 10002', 'Special terms and conditions', 0, 1500.00, 99992, 55552),
(10003, '2023-03-10', '2024-03-09', 1800.00, 'terminated', 'Payment history for contract 10003', 'Custom terms and conditions', 1, 2500.00, 99993, 55553),
(10004, '2023-04-05', '2024-04-04', 2000.00, 'renewed', 'Payment history for contract 10004', 'Renewal terms and conditions', 0, 3000.00, 99994, 55554),
(10005, '2023-05-01', '2023-10-31', 1500.00, 'active', 'Payment history for contract 10005', 'Standard terms and conditions', 1, 2000.00, 99995, 55555),
(10006, '2023-06-15', '2023-09-30', 1200.00, 'expired', 'Payment history for contract 10006', 'Special terms and conditions', 0, 1500.00, 99996, 55556),
(10007, '2023-07-10', '2024-07-09', 1800.00, 'terminated', 'Payment history for contract 10007', 'Custom terms and conditions', 1, 2500.00, 99997, 55557),
(10008, '2023-08-05', '2024-08-04', 2000.00, 'renewed', 'Payment history for contract 10008', 'Renewal terms and conditions', 0, 3000.00, 99998, 55558),
(10009, '2023-09-01', '2023-12-31', 1500.00, 'active', 'Payment history for contract 10009', 'Standard terms and conditions', 1, 2000.00, 99999, 55559);

-- Add records to asset_usage table
-- Note: The assets in the next statements must already exist in the assets table
INSERT INTO asset_usage VALUES
(20001, 55551, '2023-01-01', '2023-12-31', 'Utilized for day-to-day operations'),
(20002, 55552, '2023-02-15', '2023-11-30', 'Deployed for ergonomic office setup'),
(20003, 55553, '2023-03-10', '2024-03-09', 'In use for efficient goods transportation'),
(20004, 55554, '2023-04-05', '2024-04-04', 'Utilized for graphic design and multimedia tasks'),
(20005, 55555, '2023-05-01', '2023-10-31', 'Serving as a workstation for daily tasks'),
(20006, 55556, '2023-06-15', '2023-09-30', 'Deployed for timely and reliable deliveries'),
(20007, 55557, '2023-07-10', '2024-07-09', 'Used for entertainment and gaming purposes'),
(20008, 55558, '2023-08-05', '2024-08-04', 'Providing comfort in the office environment'),
(20009, 55559, '2023-09-01', '2023-12-31', 'Supporting efficient goods transportation');

-- Add records to asset_finance table
-- Note: The assets and lease contracts in the next statements must already exist in their respective tables
INSERT INTO asset_finance VALUES
(30001, 55551, 10001, 1200.00, 1500.00, 300.00, '2023-01-01', '2023-12-31'),
(30002, 55552, 10002, 150.00, 1200.00, 300.00, '2023-02-15', '2023-11-30'),
(30003, 55553, 10003, 25000.00, 1800.00, 300.00, '2023-03-10', '2024-03-09'),
(30004, 55554, 10004, 1800.00, 2000.00, 300.00, '2023-04-05', '2024-04-04'),
(30005, 55555, 10005, 200.00, 1500.00, 300.00, '2023-05-01', '2023-10-31'),
(30006, 55556, 10006, 35000.00, 1200.00, 300.00, '2023-06-15', '2023-09-30'),
(30007, 55557, 10007, 800.00, 1800.00, 300.00, '2023-07-10', '2024-07-09'),
(30008, 55558, 10008, 150.00, 2000.00, 300.00, '2023-08-05', '2024-08-04'),
(30009, 55559, 10009, 25000.00, 1500.00, 300.00, '2023-09-01', '2023-12-31');

-- Add records to payment_record table
-- Note: The lessees and lease contracts in the next statements must already exist in their respective tables
INSERT INTO payment_record VALUES
(40001, 99991, '2023-01-01', 1500.00, 'Credit Card', 'Completed', 10001, 0.00),
(40002, 99992, '2023-02-15', 1200.00, 'Bank Transfer', 'Pending', 10002, 0.00),
(40003, 99993, '2023-03-10', 1800.00, 'Cheque', 'Disputed', 10003, 25.00),
(40004, 99994, '2023-04-05', 2000.00, 'Cash', 'Completed', 10004, 0.00),
(40005, 99995, '2023-05-01', 1500.00, 'PayPal', 'Pending', 10005, 0.00),
(40006, 99996, '2023-06-15', 1200.00, 'Credit Card', 'Disputed', 10006, 30.00),
(40007, 99997, '2023-07-10', 1800.00, 'Bank Transfer', 'Completed', 10007, 0.00),
(40008, 99998, '2023-08-05', 2000.00, 'Cheque', 'Pending', 10008, 0.00),
(40009, 99999, '2023-09-01', 1500.00, 'Cash', 'Disputed', 10009, 20.00);

-- Add records to employment_info table
-- Note: The lessees in the next statements must already exist in the lessees table
INSERT INTO employment_info VALUES
(50001, 99991, 'Software Engineer', 'ABC Tech Solutions', 50000.00, 'Tech HR Department'),
(50002, 99992, 'Accountant', 'XYZ Financial Services', 60000.00, 'Finance Department'),
(50003, 99993, 'Sales Representative', '123 Sales Corp', 40000.00, 'Sales Department'),
(50004, 99994, 'Marketing Manager', '456 Marketing Solutions', 70000.00, 'Marketing Department'),
(50005, 99995, 'Software Engineer', 'Tech Innovators', 50000.00, 'Tech HR Department'),
(50006, 99996, 'Accountant', 'Financial Wizards Inc.', 60000.00, 'Finance Department'),
(50007, 99997, 'Sales Representative', 'Global Sales Network', 40000.00, 'Sales Department'),
(50008, 99998, 'Marketing Manager', 'Dynamic Marketing Strategies', 70000.00, 'Marketing Department'),
(50009, 99999, 'Software Engineer', 'Innovate Software Solutions', 50000.00, 'Tech HR Department');

-- Add records to insurance_info table
-- Note: The lessees in the next statements must already exist in the lessees table
INSERT INTO insurance_info VALUES
(60001, 99991, 123456789, 100000.00, 'Insurance Innovators Inc.', '2023-01-01', 'Comprehensive coverage'),
(60002, 99992, 234567890, 200000.00, 'Global Assurance Group', '2023-02-15', 'Flexible terms and conditions'),
(60003, 99993, 345678901, 300000.00, 'Secure Shield Insurance', '2023-03-10', 'Tailored coverage options'),
(60004, 99994, 456789012, 400000.00, 'ProSafe Insurance Solutions', '2023-04-05', 'Enhanced protection features'),
(60005, 99995, 567890123, 500000.00, 'Guardian Insurance Services', '2023-05-01', 'Personalized coverage plans'),
(60006, 99996, 678901234, 600000.00, 'Prime Insure Group', '2023-06-15', 'Comprehensive and flexible terms'),
(60007, 99997, 789012345, 700000.00, 'SafeNet Insurance Solutions', '2023-07-10', 'Tailored insurance solutions'),
(60008, 99998, 890123456, 800000.00, 'Secure Horizon Insurance', '2023-08-05', 'Enhanced coverage'),
(60009, 99999, 901234567, 900000.00, 'EagleEye Insurance Group', '2023-09-01', 'Personalized coverage');

-- Add records to financial_info table
-- Note: The lessees in the next statements must already exist in the lessees table
INSERT INTO financial_info VALUES
(70001, 99991, 800, 'Tech Finance Corp', 50000.00, 'Excellent credit history for lessee 99991', 'Stable cashflow statement for lessee 99991'),
(70002, 99992, 700, 'Global Financial Services', 60000.00, 'Good credit history for lessee 99992', 'Balanced cashflow statement for lessee 99992'),
(70003, 99993, 600, 'Secure Banking Group', 40000.00, 'Fair credit history for lessee 99993', 'Moderate cashflow statement for lessee 99993'),
(70004, 99994, 500, 'ProFinance Solutions', 70000.00, 'Poor credit history for lessee 99994', 'Varied cashflow statement for lessee 99994'),
(70005, 99995, 800, 'Innovate Bank', 50000.00, 'Excellent credit history for lessee 99995', 'Stable cashflow statement for lessee 99995'),
(70006, 99996, 700, 'Financial Wizards Inc.', 60000.00, 'Good credit history for lessee 99996', 'Balanced cashflow statement for lessee 99996'),
(70007, 99997, 600, 'Global Sales Finance', 40000.00, 'Fair credit history for lessee 99997', 'Moderate cashflow statement for lessee 99997'),
(70008, 99998, 500, 'Dynamic Marketing Bank', 70000.00, 'Poor credit history for lessee 99998', 'Varied cashflow statement for lessee 99998'),
(70009, 99999, 800, 'Innovate Banking Solutions', 50000.00, 'Excellent credit history for lessee 99999', 'Stable cashflow statement for lessee 99999');





