# INSTRUCTION.md

## Validating Changes in the Project

Follow the steps below to validate the changes made in the project:

1. **Activate the Virtual Environment (if applicable)**:
    - Ensure you have a virtual environment created for the project.
    - Activate it using:
      ```bash
      source <virtual_env_name>/bin/activate  # For macOS/Linux
      <virtual_env_name>\Scripts\activate     # For Windows
      ```

2. **Install Dependencies**:
    - Run the following command to ensure all the required dependencies are installed:
      ```bash
      pip install -r requirements.txt
      ```

3. **Run Migrations**:
    - Apply any migrations to update the database schema:
      ```bash
      python manage.py migrate
      ```

4. **Run Tests**:
    - Execute the test suite to ensure that the project changes have not broken existing functionality. Run:
      ```bash
      python manage.py test
      ```

5. **Run Development Server**:
    - Start the development server to manually test the changes:
      ```bash
      python manage.py runserver
      ```

6. **Manual Testing**:
    - Access the application in your web browser at `http://127.0.0.1:8000`.
    - Navigate through the application and verify that the changes behave as expected.

7. **Code Linting and Formatting (Optional but Recommended)**:
    - Run a linter like `flake8` or `pylint` to ensure the code quality:
      ```bash
      flake8 .
      ```
    - You can format the code using `black` (if used in the project):
      ```bash
      black .
      ```

8. **Check Logs and Debug**:
    - Monitor the logs in the terminal or log file for any errors or warnings during testing.

9. **Deploy Changes (if required)**:
    - If deploying to production, follow the deployment instructions specific to the project.

By performing the steps above, you can validate the changes made in the project.