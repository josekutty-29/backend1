from django.urls import path
from django.contrib.auth import views as auth_views
from .views import * 

urlpatterns = [
    path('signup/', signup, name='signup'),
    path('login/', login_view, name='login'),
    path('student/',student_dashboard, name="student"),
    path('tutor/',tutor_dashboard, name="tutor"),
    path('student_register/',student_register,name="student_register"),
    path('student_apply_register/<int:pid>/',student_apply_register,name="student_apply_register"),
    path('student_update/<str:reg_no>/', student_update, name='student_update'),
    path('like-placement/<int:offer_id>/', toggle_like, name='toggle_like'),
    path('apply-placement/<int:offer_id>/', toggle_apply, name='toggle_apply'),
    path("logout/", auth_views.LogoutView.as_view(next_page="login"), name="logout"),
    path('tutor/student_detail/<str:student_id>/', student_detail, name='student_detail'),
    path('tutor/form/',tutor_form,name="tutor_form"),
    path('placementofficer/',placement_officer_dashboard,name="placement_officer"),
    path("placementofficer/delete/<int:offer_id>/", placement_offer_delete, name="placement_delete"),
    path("placementofficer/update/<int:offer_id>/", placement_offer_update, name="placement_update"),
    path("placementofficer/create/", placement_offer_create, name="placement_create"),
    path("export-marks/", export_marks_csv, name="export_marks_csv"),
    path('remove-applied/<int:offer_id>/<int:user_id>/', remove_applied, name='remove_applied'),
    path('student-profile/<int:user_id>/', student_profile, name='student_profile'),
    path('user/profile/', user_profile, name='user_profile'),
    path("export-applied-marks/<int:offer_id>", export_applied_students_marks, name="export_applied_students_marks"),
    path("confirm_approval/<int:id>", confirm_approval, name="confirm_approval"),
    path("accept_applied/<int:offer_id>/<int:user_id>",accept_applied,name="accept_applied")
]
