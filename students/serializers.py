from rest_framework import serializers
from .models import Programme, Student, Subject, StudentCourse, Semester, Instructor, YearOfStudy

class ProgrammeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Programme
        fields = '__all__'

class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = '__all__'

class SubjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subject
        fields = '__all__'

class StudentCourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudentCourse
        fields = '__all__'

class SemesterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Semester
        fields = '__all__'

class InstructorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Instructor
        fields = '__all__'

class YearOfStudySerializer(serializers.ModelSerializer):
    class Meta:
        model = YearOfStudy
        fields = '__all__'
