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

## License
This project is licensed under the MIT License.

---

**Maintainer:** Edmond Norman Zuberi

