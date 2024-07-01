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
    $acao = $data['acao'] ?? '';

    if ($acao == 'editar') {
        $id = $data['id'];
        $descricao = $data['descricao'];
        $produto_tipo_id = $data['produto_tipo_id'];
        $preco = $data['preco'];

        try {
            $script = $pdo->prepare("UPDATE public.produto SET descricao=?, produto_tipo_id=?, preco=? WHERE id = ?");
            $script->execute([$descricao, $produto_tipo_id, $preco, $id]);

            echo json_encode(['message' => 'Produto editado com sucesso!']);
        } catch (PDOException $ex) {
            http_response_code(500);
            echo json_encode(['error' => "Erro ao editar produto: " . $ex->getMessage()]);
        }
    } elseif ($acao == 'inativar') {
        $id = $data['id'];

        try {
            $script = $pdo->prepare("UPDATE produto SET ativo = 'N' WHERE id = ?");
            $script->execute([$id]);
            echo json_encode(['message' => 'Produto inativado com sucesso!']);
        } catch (PDOException $ex) {
            http_response_code(500);
            echo json_encode(['error' => "Erro ao inativar produto: " . $ex->getMessage()]);
        }
    } elseif ($acao == 'novo') {
        $descricao = $data['descricao'];
        $produto_tipo_id = $data['produto_tipo_id'];
        $preco = $data['preco'];

        try {
            $script = $pdo->prepare("INSERT INTO produto (descricao, produto_tipo_id, preco) VALUES (?, ?, ?)");
            $script->execute([$descricao, $produto_tipo_id, $preco]);

            echo json_encode(['message' => 'Produto cadastrado com sucesso!']);
        } catch (PDOException $ex) {
            echo "Erro ao inserir produto: " . $ex->getMessage();
        }
    } else {
        http_response_code(400);
        echo json_encode(['error' => 'Ação não fornecida.']);
    }
} elseif ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $script = $pdo->query("SELECT produto.*, produto_tipo.perc_imposto, produto_tipo.descricao desc_tipo_produto
                            FROM produto
                            INNER JOIN produto_tipo ON (produto_tipo.id = produto.produto_tipo_id)
                            WHERE COALESCE(produto.ativo, 'S') = 'S'
                            ORDER BY produto.descricao");
    $produto = $script->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($produto);
}
