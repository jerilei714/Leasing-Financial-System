# Leasing Financial System

A comprehensive web-based application for managing asset leasing, contracts, lessees, and payment records. This system is designed for financial institutions and leasing companies to streamline their operations.

## 📋 Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Database Setup](#database-setup)
- [Build & Deployment](#build--deployment)
- [Usage](#usage)
- [Modules](#modules)
- [Project Structure Details](#project-structure-details)

## ✨ Features

- **Asset Management**: Track and manage leased assets with detailed information, conditions, and maintenance schedules
- **Lessee Management**: Maintain comprehensive records of lessees including contact information and addresses
- **Lease Contracts**: Create, update, and manage lease agreements between lessees and assets
- **Payment Management**: Process and track lease payments with detailed payment records and reporting
- **Asset Condition Reporting**: Monitor asset conditions and generate condition reports
- **Asset Utilization Reports**: Generate reports on asset utilization rates
- **Maintenance Scheduling**: Plan and track maintenance schedules for assets
- **Advanced Filtering & Search**: Filter and search across all modules by various criteria

## 🗂️ Project Structure

```
GROUP 8-DBAPP/
├── src/
│   ├── conf/
│   │   └── MANIFEST.MF
│   └── java/
│       ├── AssetManagement/      # Asset management classes
│       ├── contractsmgt/         # Lease contract management classes
│       ├── lesseemgt/            # Lessee management classes
│       └── PaymentManagement/    # Payment processing classes
├── web/
│   ├── index.html                # Landing page
│   ├── *.jsp                      # JavaServer Pages for UI
│   ├── *.html                     # HTML pages for navigation
│   └── META-INF/
│       └── context.xml            # Tomcat configuration
├── nbproject/                     # NetBeans project configuration
├── build.xml                      # Apache Ant build configuration
└── GROUP8-DBAPPSCRIPT.sql        # Database initialization script
```

## 🛠️ Technology Stack

- **Backend**: Java, JSP
- **Frontend**: HTML5, CSS3
- **Build Tool**: Apache Ant
- **Database**: MySQL/MariaDB
- **Application Server**: Apache Tomcat
- **IDE**: NetBeans (recommended)

## 📦 Prerequisites

Before running this application, ensure you have installed:

- Java Development Kit (JDK) 8 or higher
- Apache Tomcat 8.0 or higher
- MySQL Server 5.7 or higher (or MariaDB 10.0+)
- Apache Ant 1.10.0 or higher
- NetBeans IDE 8.0 or higher (optional but recommended)

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd Leasing-Financial-System
```

### 2. Set Up the Database

1. Open your MySQL/MariaDB client
2. Create a database and import the schema:

```bash
mysql -u your_username -p < GROUP8-DBAPPSCRIPT.sql
```

3. Update the database connection details in your Tomcat context configuration

### 3. Configure the Application

1. Update `GROUP 8-DBAPP/web/META-INF/context.xml` with your database credentials:

```xml
<Resource name="jdbc/financial_leasing"
    auth="Container"
    type="javax.sql.DataSource"
    driverClassName="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/financial_leasing"
    username="your_username"
    password="your_password"
    maxActive="20"
    maxIdle="10"
    maxWait="10000"/>
```

## 🔧 Build & Deployment

### Build with Ant

```bash
cd "GROUP 8-DBAPP"
ant build
```

### Deploy to Tomcat

1. Build the WAR file:
   ```bash
   ant dist
   ```

2. Copy the generated WAR file to Tomcat's webapps directory:
   ```bash
   cp dist/GROUP_8-DBAPP.war $CATALINA_HOME/webapps/
   ```

3. Start Tomcat:
   ```bash
   $CATALINA_HOME/bin/startup.sh
   ```

4. Access the application at `http://localhost:8080/GROUP_8-DBAPP/`

### Using NetBeans

1. Open the project in NetBeans
2. Right-click on the project and select "Build"
3. Right-click again and select "Run" to deploy to the configured server

## 📖 Usage

1. **Access the Application**: Navigate to `http://localhost:8080/GROUP_8-DBAPP/index.html`
2. **Main Menu**: The landing page provides navigation to all modules
3. **Asset Management**: Add, view, update, and delete assets
4. **Lessee Management**: Manage lessee information and records
5. **Lease Contracts**: Create and manage lease agreements
6. **Payment Processing**: Record and track payments
7. **Reports**: Generate utilization and condition reports

## 📚 Modules

### Asset Management (`AssetManagement/`)

- **Asset.java**: Core asset entity and operations
- **AssetConditionReport.java**: Generate condition reports for assets
- **AssetUtilizationReport.java**: Track and report asset utilization
- **MaintenanceSchedule.java**: Manage scheduled maintenance

**Web Pages**:
- `add_asset.jsp` / `add_asset.html` - Add new assets
- `search_asset.jsp` - Search and filter assets
- `asset_info.html` - View asset details
- `assetDetails.jsp` - Detailed asset information

### Lessee Management (`lesseemgt/`)

- **LesseeRecord.java**: Lessee information and management

**Web Pages**:
- `lessee_add.jsp` - Add new lessee
- `lessee_search.jsp` - Search lessee records
- `lessee_filter.jsp` - Filter by criteria
- `lessee_update.jsp` - Update lessee information
- `lessee_delete.jsp` - Delete lessee records
- `lessee_info.html` - View lessee details

### Lease Contract Management (`contractsmgt/`)

- **LeaseContracts.java**: Contract management and operations

**Web Pages**:
- `lease_contract_form.jsp` - Create new contracts
- `search_lease_contract.jsp` - Search contracts
- `filter_contracts.jsp` - Filter contracts by criteria
- `update_contract.jsp` - Update contract terms
- `delete_contract.jsp` - Delete contracts
- `lease_contracts.html` - Contract information page

### Payment Management (`PaymentManagement/`)

Handle payment processing and tracking

**Web Pages**:
- `add_payment.jsp` - Record new payment
- `search_payment.jsp` - Search payment records
- `filter_payment_by_contract.jsp` - Filter by contract
- `filter_payment_by_lessee.jsp` - Filter by lessee
- `payment_records_contract.jsp` - View payments by contract
- `payment_records_lessee.jsp` - View payments by lessee
- `payment_update_form.jsp` - Update payment details
- `payment_reports.jsp` - Generate payment reports
- `payment_info.html` - Payment information page

## 🗄️ Database Schema

The system uses the following main tables:

- **lessees**: Lessee information
- **address**: Address records
- **zipcodes**: Zipcode references
- **mobile**: Contact phone numbers
- **assets**: Asset details and information
- **maintenance_schedule**: Equipment maintenance schedules
- **lease_contracts**: Lease agreement records
- **payment_records**: Payment transaction records

## 📝 Notes

- Ensure MySQL/MariaDB service is running before starting the application
- Configure database connection strings before deployment
- JDBC driver must be present in Tomcat's lib directory
- Use HTTPS in production environments
- Regularly backup your database

## 🤝 Contributing

For contributions or bug reports, please contact the development team.

## 📄 License

[Add your license information here]

## 👥 Authors

Group 8 - Database Applications Development

---

For more information or support, please contact your system administrator.
