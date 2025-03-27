from django.contrib import admin

from .models import Programme, Student, YearOfStudy, Semester, Instructor, Subject, StudentSubject


admin.site.register(Programme)
admin.site.register(Student)
admin.site.register(YearOfStudy)
admin.site.register(Semester)
admin.site.register(Instructor)
admin.site.register(Subject)
admin.site.register(StudentSubject)


