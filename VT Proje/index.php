<?php
$servername = "localhost:49878";
$username = "root";
$password = "root";
$dbname = "klinikyonetimi";

$conn = new mysqli (49878, root, 123, console);

if ($conn->connect_error) {
    die("Bağlantı hatası: " . $conn->connect_error);
}

$sql = "SELECT id, isim, soyisim, dogum_tarihi, cinsiyet FROM hastalar";
$result = $conn->query($sql);

?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Sağlık Klinik Yönetimi</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<h2>Hasta Kayıtları</h2>

<?php
if ($result->num_rows > 0) {
    echo "<table>";
    echo "<tr><th>ID</th><th>İsim</th><th>Soyisim</th><th>Doğum Tarihi</th><th>Cinsiyet</th></tr>";
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . $row["id"] . "</td>";
        echo "<td>" . $row["isim"] . "</td>";
        echo "<td>" . $row["soyisim"] . "</td>";
        echo "<td>" . $row["dogum_tarihi"] . "</td>";
        echo "<td>" . $row["cinsiyet"] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
} else {
    echo "0 sonuç";
}

$conn->close();
?>

</body>
</html>
