<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");

require 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit;
}


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $itens = $data['itens'];
    $total = 0;
    $total_imposto = 0;

    foreach ($itens as $item) {
        $produto_id = $item['produto_id'];
        $qtde = $item['quantidade'];

        $scpt = $pdo->prepare("SELECT preco, produto_tipo_id FROM produto WHERE id = ?");
        $scpt->execute([$produto_id]);
        $produto = $scpt->fetch(PDO::FETCH_ASSOC);

        $preco = $produto['preco'];
        $scpt = $pdo->prepare("SELECT perc_imposto FROM produto_tipo WHERE id = ?");
        $scpt->execute([$produto['produto_tipo_id']]);
        $perc_imposto = $scpt->fetch(PDO::FETCH_ASSOC)['perc_imposto'];

        $total_item = $preco * $qtde;
        $imp_item = $total_item * ($perc_imposto / 100);

        $total += $total_item;
        $total_imposto += $imp_item;

        $itens_insert[] = [
            'produto_id' => $produto_id,
            'quantidade' => $qtde,
            'preco' => $preco,
            'imposto' => $perc_imposto
        ];
    }

    try {
        $scpt = $pdo->prepare("INSERT INTO venda (total_venda, total_imposto) VALUES (?, ?)");
        $scpt->execute([$total, $total_imposto]);
        $venda_id = $pdo->lastInsertId();

        $scpt = $pdo->prepare("INSERT INTO venda_itens (venda_id, produto_id, quantidade, preco_unitario, perc_imposto) VALUES (?, ?, ?, ?, ?)");

        foreach ($itens_insert as $item_insert){
            $scpt->execute([$venda_id, $item_insert['produto_id'], $item_insert['quantidade'], $item_insert['preco'], $item_insert['imposto']]);
        }

        echo json_encode(['message' => 'Venda registrada com sucesso!']);
    } catch (PDOException $ex) {
        echo "Erro ao inserir venda: ".$ex->getMessage();
    }
} elseif ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $scpt = $pdo->query("SELECT * FROM venda");
    $venda = $scpt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($venda);
}
?>
