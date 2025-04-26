FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies for mysqlclient and build tools
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    python3-dev \
    && apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project files
COPY . .

# Expose port 8000
EXPOSE 8000

# Run Django dev server by default
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#for gunicorn
#CMD ["gunicorn", "studentrecords.wsgi:application", "--bind", "0.0.0.0:8000"]
