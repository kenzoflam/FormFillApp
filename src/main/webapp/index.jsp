<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Two Numbers</title>
</head>

<body>

    <h2>Add Two Numbers</h2>

    <form method="post">

        <label>First Number:</label>
        <input type="number" name="num1" required>

        <br><br>

        <label>Second Number:</label>
        <input type="number" name="num2" required>

        <br><br>

        <input type="submit" value="Add">

    </form>

    <%
        String num1 = request.getParameter("num1");
        String num2 = request.getParameter("num2");

        if (num1 != null && num2 != null) {

            try {
                int number1 = Integer.parseInt(num1);
                int number2 = Integer.parseInt(num2);

                int result = number1 + number2;
    %>

                <h3>Result: <%= result %></h3>

    <%
            } catch (NumberFormatException e) {
    %>

                <h3>Please enter valid numbers.</h3>

    <%
            }
        }
    %>

</body>
</html>
