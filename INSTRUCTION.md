## How to validate the changes

1. **Clone the repository:**
   ```
   git clone <repository_url>
   cd <repository_directory>
   ```

2. **Install dependencies:**
   Ensure you have Python 3.8+ and the required dependencies:
   ```
   pip install -r requirements.txt
   ```

3. **Create the database schema:**
   ```
   python manage.py migrate
   ```

4. **Start the server:**
   ```
   python manage.py runserver
   ```

5. **Access the app:**
   Open your browser and go to:
   - [http://localhost:8000](http://localhost:8000/) (main page)
   - [http://localhost:8000/api/](http://localhost:8000/api/) (API)

6. **Verify the Ingress:**
   Ensure the Ingress is properly configured:
   - Access the app at [http://localhost](http://localhost)
   - Make sure there are no 404 errors in the browser console

7. **Testing the Ingress configuration:**
   - Check if the Ingress is routing traffic to the app correctly. 
   - Verify that the `/` path works as expected without errors.

8. **Create a pull request:**
   Push your changes and create a pull request for validation on the platform.
