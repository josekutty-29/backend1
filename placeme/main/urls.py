from django.urls import path
from .views import (signup, login_view, student_dashboard, tutor_dashboard, student_detail,
                    admin_dashboard, logout_view, student_register, placement_detail,
                    apply_for_placement, like_placement, student_profile)  # Import new views
from django.contrib.auth import views as auth_views
from django.urls import path
from . import views
from django.contrib.auth import views as auth_views
urlpatterns = [
    path('signup/', signup, name='signup'),
    path('login/', login_view, name='login'),
    path('student_dashboard/', student_dashboard, name='student_dashboard'),
    path('tutor_dashboard/', tutor_dashboard, name='tutor_dashboard'),
    path('student_detail/<int:student_id>/', student_detail, name='student_detail'),
    path('admin_dashboard/', admin_dashboard, name='admin_dashboard'),
    path('logout/', auth_views.LogoutView.as_view(next_page='login'), name='logout'), # Using Django's LogoutView
    path('student_register/', student_register, name='student_register'),

    # NEW URLS
    path('placement/<int:placement_id>/', placement_detail, name='placement_detail'),
    path('apply_for_placement/<int:placement_id>/', apply_for_placement, name='apply_for_placement'),
    path('like_placement/<int:placement_id>/', like_placement, name='like_placement'),
    path('student_profile/', student_profile, name='student_profile'),
    path('student_notifications/', views.student_notifications, name='student_notifications'), # Add this line
    path('student_dashboard/', views.student_dashboard, name='student_dashboard'),
    path('placement/<int:placement_id>/', views.placement_detail, name='placement_detail'),
    path('apply_for_placement/<int:placement_id>/', views.apply_for_placement, name='apply_for_placement'),
    path('like_placement/<int:placement_id>/', views.like_placement, name='like_placement'),
    path('logout/', auth_views.LogoutView.as_view(next_page='login'), name='logout'), # Using Django's LogoutView
    path('student_profile/', views.student_profile, name='student_profile'),    
    path('student_notifications/', views.student_notifications, name='student_notifications'),
]