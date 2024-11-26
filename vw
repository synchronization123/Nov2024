<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>View Cookies</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container mt-4">
    <h2 class="text-center">User Cookies</h2>
    <table class="table table-bordered table-striped">
      <thead class="thead-dark">
        <tr>
          <th>Row</th>
          <th>Cookies</th>
        </tr>
      </thead>
      <tbody id="cookieTableBody">
        <!-- Cookie rows will be appended here -->
      </tbody>
    </table>
  </div>

  <script>
    // Extract URL parameters to get cookies
    const params = new URLSearchParams(window.location.search);
    const cookies = params.get("cookies");

    // Populate the table if cookies are present
    if (cookies) {
      const tableBody = document.getElementById("cookieTableBody");
      const rows = cookies.split(";").map((cookie, index) => {
        return `<tr><td>${index + 1}</td><td>${cookie.trim()}</td></tr>`;
      });
      tableBody.innerHTML = rows.join("");
    }
  </script>
</body>
</html>