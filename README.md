# **Event Management App Documentation**

## **Overview**
The Event Management App is a Flutter-based mobile application designed to simplify event organization and participation. It provides users with a seamless platform for browsing events, booking tickets, and receiving notifications. Event organizers can list their events, manage ticket sales, and analyze attendance data. The app is built to cater to event enthusiasts and organizers, offering a user-friendly experience and robust backend support.

---

## **Features**

### **User Features:**
1. **Event Browsing:**
   - Users can explore upcoming events with detailed descriptions, images, and dates.
2. **Event Details:**
   - Each event has a dedicated page with complete information, including an option to book tickets.
3. **Ticket Booking:**
   - Secure ticket purchasing system with booking confirmation.
4. **Profile Management:**
   - Users can manage their profiles and view their booked events.
5. **Dark Mode Support:**
   - Toggle between light and dark themes based on user preference.

### **Admin/Organizer Features:**
1. **Event Listing:**
   - Organizers can add, edit, or remove events from the platform.
2. **Notifications:**
   - Send reminders and updates to users about their booked events.
3. **Analytics Dashboard (Future Scope):**
   - View attendance statistics and ticket sales insights.

---

## **Technology Stack**

### **Frontend:**
- Flutter (Dart)
- Responsive and intuitive UI components for cross-platform support.

### **Backend:**
- Firebase:
  - Authentication for secure login/sign-up.
  - Firestore for real-time database operations.
  - Cloud Storage for media assets (e.g., event images).
  - Cloud Messaging for notifications.
- Payment Gateway Integration (e.g., Stripe, Razorpay for ticket payments).

### **Deployment:**
- Firebase Hosting for backend services.
- DigitalOcean or similar platforms for scaling enterprise solutions (optional).

---

## **Setup Instructions**

### **Prerequisites:**
- Install Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
- Firebase account setup: [Firebase Console](https://console.firebase.google.com/).
- IDE: Android Studio or Visual Studio Code.

### **Steps to Run Locally:**
1. Clone the repository:
   ```bash
   git clone https://github.com/krymoevanag/event-management-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd event-management-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Configure Firebase:
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) from your Firebase project.
   - Place them in the respective folders:
     - Android: `android/app/`
     - iOS: `ios/Runner/`
5. Run the app:
   ```bash
   flutter run
   ```

---

## **How It Works**

### **User Flow:**
1. Launch the app and log in using Firebase Authentication.
2. Browse events on the home screen and view event details.
3. Book tickets via the ticket booking option.
4. Manage bookings and view profile information.

### **Admin/Organizer Flow:**
1. Log in as an admin or organizer.
2. List new events with complete details and images.
3. View ticket sales and user engagement.

---

## **Monetization Plan**
1. **Freemium Model:**
   - Basic features available for free, with premium features (e.g., advanced analytics) requiring a subscription.
2. **Ticket Commission:**
   - A small percentage of ticket sales is charged as a service fee.
3. **Enterprise Solutions:**
   - Custom packages for large-scale event organizers.

---

## **Future Enhancements**
- Advanced Analytics Dashboard for organizers.
- Real-time chat support for users and organizers.
- Integration with social media platforms for easy event sharing.
- QR Code-based check-in system for ticket verification.

---

## **Contact Information**
For any queries or support, please contact:

**Evans Kirimi**  
Email: [kirimievansgitonga@gmail.com](mailto:kirimievansgitonga@gmail.com)  
Phone: +254 708 873 060  
GitHub: [krymoevanag](https://github.com/krymoevanag)  
Location: Chuka, Kenya

