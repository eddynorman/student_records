from django.db import models
from django.utils import timezone

class Programme(models.Model):
    name = models.CharField(max_length=100)
    length_in_years = models.IntegerField()
    
    def __str__(self):
        return self.name
    
class Student(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=20)
    date_of_birth = models.DateField()
    programme = models.ForeignKey(Programme, on_delete=models.CASCADE, related_name="students")
    registration_number = models.CharField(max_length=20, unique=True, blank=True)
    date_enrolled = models.DateField()
    date_graduated = models.DateField(null=True, blank=True)
    is_graduated = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    
    def generate_registration_number(self):
        return f"T-{timezone.now().year}-{self.id:04d}"

    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    
    def save(self, *args, **kwargs):
        is_new = self.pk is None
        super().save(*args, **kwargs)  
        if is_new and not self.registration_number:
            self.registration_number = self.generate_registration_number()
            super().save(update_fields=["registration_number"])
    
class YearOfStudy(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Semester(models.Model):
    name = models.CharField(max_length=100)
    
    def __str__(self):
        return self.name

class Instructor(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=20)
    date_of_birth = models.DateField()
    date_employed = models.DateField()
    
    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    
class Subject(models.Model):  
    name = models.CharField(max_length=100)
    code = models.CharField(max_length=10, unique=True)
    year = models.ForeignKey(YearOfStudy, on_delete=models.CASCADE, related_name="subjects")
    semester = models.ForeignKey(Semester, on_delete=models.CASCADE, related_name="courses")
    credits = models.FloatField() 
    instructor = models.ForeignKey(Instructor, on_delete=models.CASCADE, related_name="courses")

    def __str__(self):
        return f"{self.code} - {self.name}"
    
class StudentSubject(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE, related_name="courses")
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE, related_name="students")
    
    class Meta:
        unique_together = ("student", "subject")  
