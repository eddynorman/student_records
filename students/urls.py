from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ProgrammeViewSet, StudentViewSet, CourseViewSet,
    StudentCourseViewSet, SemesterViewSet, InstructorViewSet, YearOfStudyViewSet
)

router = DefaultRouter()
router.register(r'programmes', ProgrammeViewSet)
router.register(r'students', StudentViewSet)
router.register(r'subjects', SubjectViewSet)
router.register(r'student-courses', StudentCourseViewSet)
router.register(r'semesters', SemesterViewSet)
router.register(r'instructors', InstructorViewSet)
router.register(r'years-of-study', YearOfStudyViewSet)

urlpatterns = [
    path('api/', include(router.urls)),
]
