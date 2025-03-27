from rest_framework import viewsets
from .models import Programme, Student, Course, StudentCourse, Semester, Instructor, YearOfStudy
from .serializers import (
    ProgrammeSerializer, StudentSerializer, CourseSerializer,
    StudentCourseSerializer, SemesterSerializer, InstructorSerializer, YearOfStudySerializer
)

class ProgrammeViewSet(viewsets.ModelViewSet):
    queryset = Programme.objects.all()
    serializer_class = ProgrammeSerializer

class StudentViewSet(viewsets.ModelViewSet):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

class SubjectViewSet(viewsets.ModelViewSet):
    queryset = Subject.objects.all()
    serializer_class = SubjectSerializer

class StudentCourseViewSet(viewsets.ModelViewSet):
    queryset = StudentCourse.objects.all()
    serializer_class = StudentCourseSerializer

class SemesterViewSet(viewsets.ModelViewSet):
    queryset = Semester.objects.all()
    serializer_class = SemesterSerializer

class InstructorViewSet(viewsets.ModelViewSet):
    queryset = Instructor.objects.all()
    serializer_class = InstructorSerializer

class YearOfStudyViewSet(viewsets.ModelViewSet):
    queryset = YearOfStudy.objects.all()
    serializer_class = YearOfStudySerializer
