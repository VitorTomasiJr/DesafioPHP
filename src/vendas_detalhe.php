<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");

require 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($_GET['id'])) {
        $id = $_GET['id'];

        if (!is_numeric($id)) {
            $error = array('error' => 'ID deve ser um número inteiro válido');
            echo json_encode($error);
            exit;
        }

        $scpt = $pdo->prepare("SELECT produto.descricao, venda_itens.quantidade, venda_itens.preco_unitario, venda_itens.perc_imposto
                        FROM venda_itens 
                        INNER JOIN produto ON (produto.id = venda_itens.produto_id)
                        WHERE venda_itens.venda_id=?");
        $scpt->execute([$id]);

        $venda = $scpt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($venda);
    }
}
