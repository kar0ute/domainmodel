
<?php
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    exit(0);
}

$connection = mysqli_connect('localhost', 'root', '', 'finapp');

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $result = mysqli_query($connection, 'SELECT * FROM customers LEFT JOIN orders ON customers.id = orders.customer_id');
    $customers = array();
    while($row = mysqli_fetch_array($result)) {
        $customers[] = array(
            'id' => $row['id'],
            'name' => $row['name'],
            'email' => $row['email'],
            'order_date' => $row['order_date'],
            'amount' => $row['total_amount']
        );
    }
    echo json_encode(["records" => $customers]);
} elseif ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    $input = json_decode(file_get_contents('php://input'), true);
    $id = $input['id'];
    $name = $input['name'];
    $email = $input['email'];
    $order_date = $input['order_date'];
    $amount = $input['amount'];

    $query = "UPDATE customers SET name='$name', email='$email' WHERE id='$id'";
    mysqli_query($connection, $query);

    $query = "UPDATE orders SET order_date='$order_date', total_amount='$amount' WHERE customer_id='$id'";
    mysqli_query($connection, $query);

    echo json_encode(["message" => "Customer updated successfully."]);
} elseif ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    $id = $_GET['id'];

    $query = "DELETE FROM orders WHERE customer_id='$id'";
    mysqli_query($connection, $query);

    $query = "DELETE FROM customers WHERE id='$id'";
    mysqli_query($connection, $query);

    echo json_encode(["message" => "Customer deleted successfully."]);
} else {
    http_response_code(405);
    echo json_encode(["message" => "Method not allowed"]);
}

mysqli_close($connection);
?>
