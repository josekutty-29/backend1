from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import StudentRegistrationForm  # You'll need to define this
from django.contrib.auth import logout
from .models import Tutor, Student, Placement, StudentApplication, Notification, User  # Import new models
from django.http import JsonResponse
from django.urls import reverse


def signup(request):
    if request.method == "POST":
        print("Form submitted!")  # Debug print
        print("POST data:", request.POST)
        email = request.POST.get('email')
        password = request.POST.get('password')
        first_name = request.POST.get('firstname')  # assuming your form uses 'firstname'
        last_name = request.POST.get('lastname')
        regno = request.POST.get('regno')

        # Create the new user instance.
        new_user = User(
            email=email,
            first_name=first_name,
            last_name=last_name,
            regno=regno  # custom field on your user model
        )
        new_user.set_password(password)  # Hash the password
        try:
            new_user.save()
            print("User saved successfully.")
            print("Total users now:", User.objects.count())
            # Set the backend manually
            new_user.backend = 'django.contrib.auth.backends.ModelBackend'
            # Log the user in
            login(request, new_user)
            messages.success(request, "Signup successful!")
            # Redirect to student_register view after successful signup
            return redirect('student_register')
        except Exception as e:
            print("Error saving user:", e)
            messages.error(request, "Error during signup: " + str(e))
            return redirect('signup')
    return render(request, 'signup.html')


def login_view(request):
    if request.method == 'POST':
        email = request.POST.get('username')  # The form field for email
        password = request.POST.get('password')
        user = authenticate(request, username=email, password=password)
        if user is not None:
            login(request, user)
            messages.success(request, "Logged in successfully!")
            role = user.role.lower() if hasattr(user, 'role') and user.role else ""

            if role == "student":
                return redirect('student_dashboard')  # URL name for student dashboard.
            elif role == "tutor":
                return redirect('tutor_dashboard')
            elif role == "admin":
                return redirect('admin_dashboard')        # URL name for tutor page.
            else:

                return redirect('login')
        else:
            messages.error(request, "Invalid username or password.")
            return redirect('login')

    # For GET requests, render the login template.
    return render(request, 'index copy.html')



@login_required
def student_dashboard(request):
    filter_type = request.GET.get('filter', 'available')

    if filter_type == 'available':
        placements = Placement.objects.all()
    elif filter_type == 'liked':
        placements = request.user.liked_placements.all()
    elif filter_type == 'applied':
        placements = Placement.objects.filter(applications__reg_no__user=request.user)
    else:
        placements = Placement.objects.all()

    # NEW: Add has_applied to each placement object
    for placement in placements:
        placement.has_applied = StudentApplication.objects.filter(
            reg_no__user=request.user, offer_id=placement
        ).exists()


    notifications = request.user.notifications.filter(is_read=False)
    try:
        profile = Student.objects.get(user=request.user)
    except Student.DoesNotExist:
        profile = None

    context = {
        'placements': placements,
        'notifications': notifications,
        'filter': filter_type,
        'user': request.user,
        'profile': profile,
    }
    return render(request, 'student.html', context)

@login_required
def tutor_dashboard(request):
    # Assume the Tutor model has a field 'user' or 'email' that links it to the User
    tutor_instance = get_object_or_404(Tutor, user=request.user)

    # Now, filter students that have this Tutor instance as their tutor.
    students = Student.objects.filter(tutor=tutor_instance).exclude(id__isnull=True)

    context = {
        'user': request.user,
        'tutor': tutor_instance,
        'students': students,
    }
    return render(request, 'tutor.html', context)

@login_required
def student_detail(request, student_id):
    # Get the student object for the current tutor, or 404 if not found
    student = get_object_or_404(Student, id=student_id, tutor=request.user)
    context = {
        'student': student,
    }
    return render(request, 'student_detail.html', context)



@login_required
def admin_dashboard(request):
    # Prepare any context data needed for the tutor dashboard
    context = {
        'user': request.user,
        # Add other context variables if needed
    }
    return render(request, 'admin.html', context)


def logout_view(request):
    print("Session before flush:", request.session.items())
    request.session.flush()
    print("Session after flush:", request.session.items())
    logout(request)
    return redirect('login')



@login_required
def student_register(request):
    # Check if the student already has a profile. If yes, redirect them.
    try:
        profile = Student.objects.get(user=request.user)
        return redirect('student_dashboard')
    except Student.DoesNotExist:
        pass

    if request.method == 'POST':
        form = StudentRegistrationForm(request.POST)
        if form.is_valid():
            profile = form.save(commit=False)
            # Link this student profile to the logged-in user
            profile.user = request.user
            # Optionally, if you want to enforce consistency, update reg_no from the user
            profile.reg_no = request.user.regno
            profile.save()
            messages.success(request, "Profile updated successfully!")
            return redirect('student_dashboard')
        else:
            messages.error(request, "Please correct the errors below.")
    else:
        # Pre-populate the form with the registration number from the user
        initial_data = {'reg_no': request.user.regno}
        form = StudentRegistrationForm(initial=initial_data)

    return render(request, 'student_form.html', {'form': form})

# --- NEW VIEWS ---

@login_required
def placement_detail(request, placement_id):
    placement = get_object_or_404(Placement, pk=placement_id)
    # Check if the current user has applied for this placement
    has_applied = StudentApplication.objects.filter(reg_no__user=request.user, offer_id=placement).exists()
    context = {
        'placement': placement,
        'has_applied': has_applied,  # Pass this to the template
    }
    return render(request, 'placement_detail.html', context) # You'll create this template

@login_required
def apply_for_placement(request, placement_id):
    placement = get_object_or_404(Placement, pk=placement_id)
    if request.method == 'POST':
        # Use get_or_create to prevent duplicates, and get a boolean indicating if it was created
        application, created = StudentApplication.objects.get_or_create(
            reg_no=request.user.student_profile,  # Use the related student profile
            offer_id=placement
        )
        if created:
            messages.success(request, "Successfully applied for the placement!")
        else:
            messages.warning(request, "You have already applied for this placement.")
        return redirect(reverse('placement_detail', args=[placement_id]))
    return redirect(reverse('placement_detail', args=[placement_id]))  # Redirect GET requests


@login_required
def like_placement(request, placement_id):
    if request.method == 'POST' and request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        placement = get_object_or_404(Placement, pk=placement_id)
        if request.user in placement.liked_by.all():
            placement.liked_by.remove(request.user)
            is_liked = False
        else:
            placement.liked_by.add(request.user)
            is_liked = True
        return JsonResponse({'success': True, 'is_liked': is_liked})
    return JsonResponse({'success': False, 'message': 'Invalid request'})

@login_required
def student_profile(request):
    try:
      profile = Student.objects.get(user=request.user)
    except Student.DoesNotExist:
        profile = None # Pass user and profile

    context = {
        'profile': profile,
        'user': request.user
    }
    return render(request, 'profile_page.html', context) # Create a new template for details

  
@login_required
def student_notifications(request):
    notifications = request.user.notifications.all()  # Get all notifications
    context = {'notifications': notifications}
    return render(request, 'student_notifications.html', context)