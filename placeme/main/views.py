
from django.shortcuts import render, redirect,get_object_or_404
from .models import User
from django.contrib.auth import authenticate, login
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import StudentRegistrationForm, TutorForm, PlacementOfferForm
from django.contrib.auth import logout
import csv
from .models import Tutor, Student, PlacementOffer, Marks, PlacementOfficer

def signup(request):
    if request.method == "POST":
        print("Form submitted!")  # Debug print
        print("POST data:", request.POST)
        email = request.POST.get('email')
        password = request.POST.get('password')
        first_name = request.POST.get('firstname')  # assuming your form uses 'firstname'
        last_name = request.POST.get('lastname')
        # Create the new user instance.
        new_user = User(
            email=email,
            first_name=first_name,
            last_name=last_name,
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
            print(role)
            if role == "student":
                return redirect('student_dashboard')  # URL name for student dashboard.
            elif role == "tutor":
                return redirect('tutor')   
            elif role == "admin":
                return redirect('admin_dashboard')        # URL name for tutor page.
            elif role == 'placement_officer':
                return redirect('placement_officer')
            else:
                
                return redirect('login')
        else:
            messages.error(request, "Invalid username or password.")
            return redirect('login')
    
    # For GET requests, render the login template.
    return render(request, 'index copy.html')

@login_required
def student_dashboard(request):
    try:
        profile = Student.objects.get(user=request.user)
    except Student.DoesNotExist:
        profile = None
    placements = PlacementOffer.objects.all()
    context = {
        'user': request.user,
        'profile': profile,
        'placements': placements
    }
    return render(request, 'student.html', context)

@csrf_exempt
@login_required
def toggle_like(request, offer_id):
    if request.method == "POST":
        user = request.user
        placement = get_object_or_404(PlacementOffer, offer_id=offer_id)

        if user in placement.liked_by.all():
            placement.liked_by.remove(user)
            liked = False
        else:
            placement.liked_by.add(user)
            liked = True

        return JsonResponse({"liked": liked})
    
    return JsonResponse({"error": "Invalid request"}, status=400)

@login_required
@csrf_exempt
def toggle_apply(request, offer_id):
    if request.method == "POST":
        user = request.user
        placement = get_object_or_404(PlacementOffer, offer_id=offer_id)

        if user in placement.applied_by.all():
            placement.applied_by.remove(user)
            applied = False
        else:
            placement.applied_by.add(user)
            applied = True
        return JsonResponse({"applied": applied})
    return JsonResponse({"error": "Invalid request"}, status=400)




@login_required
def tutor_dashboard(request):
    if request.method == "POST" and request.FILES.get("csv_file"):
        csv_file = request.FILES["csv_file"]

        # Ensure the file is a CSV
        if not csv_file.name.endswith(".csv"):
            messages.error(request, "File is not a CSV format")
            return redirect("tutor_dashboard")

        # Read and process the CSV file
        decoded_file = csv_file.read().decode("utf-8").splitlines()
        reader = csv.DictReader(decoded_file)

        for row in reader:
            try:
                student = Student.objects.get(reg_no=row["reg_no"])
                mark, created = Marks.objects.update_or_create(
                    reg_no=student,
                    sem=row["sem"],
                    defaults={
                        "cgpa": row["cgpa"],
                        "backlog": row["backlog"]
                    }
                )
                messages.success(request, f"{student.user.first_name} {student.user.last_name}'s mark updated successfully")
            except Student.DoesNotExist:
                messages.error(request, f"Student with register number {row['reg_no']} not found.")
        return redirect("tutor_dashboard")  # Redirect back to tutor dashboard

    # Fetch tutor instance
    tutor_instance = get_object_or_404(Tutor, user=request.user)

    # Get all students for this tutor
    students = Student.objects.filter(tutor=tutor_instance).exclude(reg_no__isnull=True)

    # Filtering logic
    sem_filter = request.GET.get("sem")
    backlog_filter = request.GET.get("backlog")
    print(sem_filter,backlog_filter)
    if sem_filter and int(sem_filter) > 0:
        print("filtering..")
        students = students.filter(semester=sem_filter)
    if backlog_filter:
        students = students.filter(marks__backlog=backlog_filter)

    # Sorting logic
    sort_by = request.GET.get("sort")
    print(sort_by)
    if sort_by == "name":
        students = students.order_by("user__first_name")
    elif sort_by == "semester":
        students = students.order_by("semester")  # Descending CGPA
    elif sort_by == "reg_no":
        students = students.order_by("reg_no")  # Ascending Backlogs
    placements = PlacementOffer.objects.all()
    marks_dict = {student.reg_no: [] for student in students}
    for mark in Marks.objects.filter(reg_no__in=students):
        marks_dict[mark.reg_no.reg_no].append(mark)

    print(students)
    context = {
        'user': request.user,
        'tutor': tutor_instance,
        'students': students,
        'placements': placements,
        'marks_dict':marks_dict
    }
    return render(request, 'tutor.html', context)


@login_required
def export_marks_csv(request):
    # Create the HttpResponse object with CSV header
    response = HttpResponse(content_type="text/csv")
    response["Content-Disposition"] = 'attachment; filename="student_marks.csv"'

    writer = csv.writer(response)
    # Write the header row
    writer.writerow(["Register Number", "Semester", "CGPA", "Backlogs"])

    # Query all marks and write them into the CSV file
    for mark in Marks.objects.all():
        writer.writerow([mark.reg_no.reg_no, mark.cgpa, mark.backlog, mark.sem])
    return response


@login_required
def placement_officer_dashboard(request):
    try:
        profile = PlacementOfficer.objects.get(user=request.user)
    except PlacementOfficer.DoesNotExist:
        profile = None
    placement_officer = get_object_or_404(PlacementOfficer,user=request.user)
    placements = PlacementOffer.objects.filter(created_by=placement_officer)
    liked = [student for placement in placements for student in placement.liked_by.all()]
    applied = [student for placement in placements for student in placement.applied_by.all()]
    print(placements)
    context = {
        'user': request.user,
        'profile': profile,
        'placements': placements,
        "liked_students": liked,
        "applied_students":applied,
    }
    return render(request, 'placement_officer.html', context)


@login_required
def placement_offer_create(request):
    if request.method == "POST":
        form = PlacementOfferForm(request.POST)
        if form.is_valid():
            placement_offer = form.save(commit=False)
            placement_offer.created_by = request.user.placementofficer  # Assign current placement officer
            placement_offer.save()
            return redirect("placement_officer")  # Redirect to placement officer dashboard
    else:
        form = PlacementOfferForm()

    return render(request, "placement_offer_form.html", {"form": form})


@login_required
def placement_offer_update(request, offer_id):
    placement_offer = get_object_or_404(PlacementOffer, offer_id=offer_id)
    if request.user != placement_offer.created_by.user:
        messages.error(request,"Not Authorized")
        return redirect("placement_officer")  # Redirect if not authorized
    if request.method == "POST":
        form = PlacementOfferForm(request.POST, instance=placement_offer)
        if form.is_valid():
            form.save()
            return redirect("placement_officer")
    else:
        form = PlacementOfferForm(instance=placement_offer)
    return render(request, "tutor_form.html", {"form": form, "edit": True})

@login_required
def placement_offer_delete(request,offer_id):
    placement_offer = get_object_or_404(PlacementOffer, offer_id=offer_id)
    print("Delete process started...",placement_offer.created_by.user,"   ",request.user)
    if request.user != placement_offer.created_by.user:
        messages.error(request,"Not authorized")
        print("not authorized...")
        return redirect("placement_officer")  # Redirect if not authorized
    d = placement_offer.delete()
    if d:
        print("Delete successfull...")
        messages.success(request,"Deleted successfully")
    return redirect('placement_officer')

@login_required
def student_detail(request, student_id):
    # Get the student object for the current tutor, or 404 if not found
    print("Requesting student details...",student_id,request.user)
    student = get_object_or_404(Student, reg_no=student_id)
    form = StudentRegistrationForm(instance=student)
    context = {
        'form': form,
    }
    return render(request, 'student_form.html', context)

@login_required
def tutor_form(request):
    tutor = get_object_or_404(Tutor,user=request.user)
    if request.method == "POST":    
        form = TutorForm(request.POST, instance=tutor)
        if form.is_valid():
            form.save()
            return redirect("tutor_dashboard")  # Redirect after saving
    else:
        form = TutorForm(instance=tutor)  # Prefill the form for editing
    return render(request, "tutor_form.html", {"form": form, "tutor": tutor})


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
    print(request.user.regno)
    try:
        # Try to get the student profile for the logged-in user
        profile = Student.objects.get(reg_no=request.user.regno)
    except Student.DoesNotExist:
        profile = None  # No profile exists yet
    print(profile,request.method)

    if request.method == 'POST':
        form = StudentRegistrationForm(request.POST, instance=profile)  # Preload data
        if form.is_valid():
            profile = form.save(commit=False)
            profile.user = request.user  # Ensure it's linked to the logged-in user
            profile.reg_no = request.user.regno  # Ensure reg_no remains correct
            profile.save()
            messages.success(request, "Profile updated successfully!")
            return redirect('student_dashboard')
        else:
            messages.error(request, form.errors)
    else:
        print("get...")
        if profile:
            form = StudentRegistrationForm(instance=profile)  # Load existing data into form
        else:
            print("else...")
            form = StudentRegistrationForm(initial = {'reg_no':request.user.regno})

    return render(request, 'student_form.html', {'form': form})

@login_required
def student_update(request, reg_no):
    student = Student.objects.filter(reg_no=reg_no).first()

    if not student:
        messages.error(request, "No profile found. Please register first.")
        return redirect('student_register', reg_no=reg_no)

    if request.method == 'POST':
        form = StudentRegistrationForm(request.POST, instance=student)
        if form.is_valid():
            form.save()
            messages.success(request, "Profile updated successfully!")
            return redirect('tutor_dashboard')
        else:
            messages.error(request, "Please correct the errors in the form.")
    else:
        form = StudentRegistrationForm(instance=student)

    return render(request, 'student_update.html', {'form': form, 'reg_no': reg_no})
