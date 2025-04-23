# Students API

## Overview
This is a RESTful API built with Django and Django REST Framework (DRF) to manage student and course details. The API allows users to perform CRUD operations on students, courses, instructors, programs, and more.

## Features
- Student registration and management
- Course enrollment
- Instructor assignment
- Program and semester tracking
- Secure authentication and authorization

## Technologies Used
- **Django** (Backend framework)
- **Django REST Framework** (API development)
- **MySQL** (Database)
- **django-crispy-forms** with **crispy-bootstrap5** (Frontend forms handling)

## Installation & Setup

### Prerequisites
Ensure you have the following installed:
- Python (>=3.8)
- MySQL
- pip & virtualenv
- Git

### 1️⃣ Clone the Repository
```bash
git clone <repository-url>
cd students-api
```

### 2️⃣ Create a Virtual Environment & Install Dependencies
```bash
python -m venv venv
source venv/bin/activate  # For Linux/macOS
venv\Scripts\activate    # For Windows

pip install -r requirements.txt
```

### 3️⃣ Configure MySQL Database
Create a MySQL database and update `settings.py` with your database credentials:
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'students_db',
        'USER': 'your_mysql_user',
        'PASSWORD': 'your_mysql_password',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

### 4️⃣ Run Migrations
```bash
python manage.py migrate
```

### 5️⃣ Create a Superuser
```bash
python manage.py createsuperuser
```

### 6️⃣ Run the Development Server
```bash
python manage.py runserver
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/students/` | Get all students |
| POST | `/api/students/` | Add a new student |
| GET | `/api/students/{id}/` | Get a specific student |
| PUT | `/api/students/{id}/` | Update student details |
| GET | `/api/subjects/` | Get all courses |
| POST | `/api/subjects/` | Add a new course |

## Deployment
To deploy the API on **AWS**, follow these steps:
1. Set up an **EC2 instance** with Ubuntu.
2. Install Python, MySQL, and necessary dependencies.
3. Clone the repository and set up the virtual environment.
4. Configure **Gunicorn** and **NGINX** for production.
5. Set up a domain or public IP for API access.

## Backup Strategies
In server administration and system maintenance, backups are crucial for disaster recovery, data integrity, and business continuity. Below are three primary types of backup strategies used in real-world scenarios:

---

### 1. 🔄 **Full Backup**

**Definition:**  
A *full backup* copies all data—every file and directory—to the backup storage location. It is the most straightforward and complete form of backup.

**Execution Strategy:**
```bash
tar -czf full_backup_$(date +%F).tar.gz /var/www/my_api/
```

**Example:**  
You run this every Sunday at midnight. It stores the entire `/var/www/my_api/` directory into a single compressed file.

**Advantages:**
- Fast and simple restore process.
- All files are stored together in a single backup.
- Easy to manage and audit.

**Disadvantages:**
- Takes the most time to back up.
- Requires the most storage space.
- Redundant data is backed up every time.

**Best for:**
- Critical data environments where fast recovery is crucial.
- Weekly or monthly backup cycles where storage isn't a concern.

---

### 2. ➕ **Incremental Backup**

**Definition:**  
An *incremental backup* saves only the data that has changed since the **last backup of any type (full or incremental)**.

**Execution Strategy:**
Using `tar` with `--listed-incremental`:
```bash
tar --listed-incremental=backup.snar -czf inc_backup_$(date +%F).tar.gz /var/www/my_api/
```

**Example:**  
You run a full backup on Sunday, then run incremental backups on Monday–Saturday. Each incremental backup is much smaller and faster.

**Advantages:**
- Saves time and disk space.
- Efficient for daily backups.
- Reduces I/O load on the system.

**Disadvantages:**
- Restore requires **all incremental backups + full backup**.
- More complex to manage and prone to failure if any backup in the chain is missing.

**Best for:**
- Large data sets with minimal daily changes.
- Systems with limited storage resources.

---

### 3. 🔁 **Differential Backup**

**Definition:**  
A *differential backup* saves all the data that has changed **since the last full backup**. It doesn’t reset like incremental backups.

**Execution Strategy:**
Using `rsync`:
```bash
rsync -a --compare-dest=/path/to/full/ /var/www/my_api/ /path/to/diff/
```

**Example:**  
You take a full backup on Sunday. Monday’s differential backup contains Monday’s changes. Tuesday’s backup includes both Monday and Tuesday’s changes (since they both came after the last full).

**Advantages:**
- Faster restore than incremental (requires only 2 backups: latest full + latest diff).
- Simpler than incremental for recovery.
- Moderate space and time usage.

**Disadvantages:**
- Size of differential backups increases over time.
- More storage needed than incremental backups.

**Best for:**
- Systems needing faster restores but still want to save space/time compared to full backups.
- Mid-size projects with daily updates.

---

### ⚖️ Backup Strategy Comparison Table

| Backup Type     | Speed (Backup) | Speed (Restore) | Storage Use | Dependencies     |
|------------------|----------------|------------------|--------------|------------------|
| Full             | Slow           | Fast             | High         | None             |
| Incremental      | Fast           | Slow             | Low          | All increments   |
| Differential     | Moderate       | Moderate         | Medium       | Last full backup |

---


## 🖥️ Bash Scripts for Server Management

This project includes three Bash scripts designed to automate system health checks, backups, and updates for the API hosted on an AWS EC2 Ubuntu server using Gunicorn and Nginx.

### 📁 Directory Structure

All scripts are located in the `bash_scripts/` directory:

```
bash_scripts/
├── health_check.sh
├── backup_api.sh
└── update_server.sh
```

---

### 🔧 Setup Instructions

1. **Clone or pull the latest project:**

```bash
git clone https://github.com/eddynorman/student_records.git
cd student_records/bash_scripts
```

2. **Make the scripts executable:**

```bash
chmod +x health_check.sh backup_api.sh update_server.sh
```

3. **Install required dependencies:**

Ensure the following tools are installed:

```bash
sudo apt update
sudo apt install curl gzip tar nginx
```

If you're backing MySQL database, install:
- For MySQL:
  ```bash
  sudo apt install mysql-client
  ```

4. **Create required directories and log files:**

```bash
sudo mkdir -p /var/log
sudo touch /var/log/server_health.log /var/log/backup.log /var/log/update.log
```

5. **Test each script manually:**

```bash
sudo ./health_check.sh
sudo ./backup_api.sh
sudo ./update_server.sh
```

---

### ⏰ Cron Job Scheduling

To schedule the scripts automatically, open crontab with:
we use sudo to run the crontab command as the root user. This allows also access to write to the log files.
```bash
sudo crontab -e
```

Then add the following lines:

```bash
# Health check every 6 hours
0 */6 * * * /home/ubuntu/student_records/bash_scripts/health_check.sh

# Backup daily at 2 AM
0 2 * * * /home/ubuntu/student_records/bash_scripts/backup_api.sh

# Update every 3 days at 3 AM
0 3 */3 * * /home/ubuntu/student_records/bash_scripts/update_server.sh
```

---

### 📄 Log Files

Each script writes its activity to the following log files for monitoring and troubleshooting:

- `/var/log/server_health.log`
- `/var/log/backup.log`
- `/var/log/update.log`


---
## License
This project is licensed under the MIT License.

---

**Maintainer:** Edmond Norman Zuberi

