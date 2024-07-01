<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");

require 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $script = $pdo->query("SELECT produto_tipo.* 
                            FROM produto_tipo 
                            WHERE COALESCE(produto_tipo.ativo, 'S') = 'S' 
                            ORDER BY descricao");
    $tipos = $script->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($tipos);
} elseif ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $acao = $data['acao'] ?? '';

    if ($acao == 'editar') {
        $id = $data['id'];
        $descricao = $data['descricao'];
        $perc_imposto = $data['perc_imposto'];

        try {
            $script = $pdo->prepare("UPDATE produto_tipo SET descricao = ?, perc_imposto = ? WHERE id = ?");
            $script->execute([$descricao, $perc_imposto, $id]);

            echo json_encode(['message' => 'Tipo de produto editado com sucesso!']);
        } catch (PDOException $ex) {
            http_response_code(500);
            echo json_encode(['error' => "Erro ao editar tipo de produto: " . $ex->getMessage()]);
        }
    } elseif ($acao == 'inativar') {
        $id = $data['id'];

        try {
            $script = $pdo->prepare("UPDATE produto_tipo SET ativo = 'N' WHERE id = ?");
            $script->execute([$id]);
            echo json_encode(['message' => 'Tipo de produto inativado com sucesso!']);
        } catch (PDOException $ex) {
            http_response_code(500);
            echo json_encode(['error' => "Erro ao inativar tipo de produto: " . $ex->getMessage()]);
        }
    } elseif ($acao == 'novo') {
        $descricao = $data['descricao'];
        $perc_imposto = $data['perc_imposto'];

        try {
            $script = $pdo->prepare("INSERT INTO produto_tipo (descricao, perc_imposto) VALUES (?, ?)");
            $script->execute([$descricao, $perc_imposto]);

            echo json_encode(['message' => 'Tipo de produto cadastrado com sucesso!']);
        } catch (PDOException $ex) {
            echo "Erro ao inserir tipo de produto: " . $ex->getMessage();
        }
    } else {
        http_response_code(400);
        echo json_encode(['error' => 'Ação não fornecida.']);
    }
}
