# README - Script de Envio de Pastas via SCP

Este projeto contém um script Bash para enviar pastas de forma automatizada para um servidor remoto utilizando `scp` e `sshpass`. O script lê as configurações de um arquivo de configuração e realiza a transferência de forma prática e eficiente.

## Requisitos

1. **Ambiente Linux/Unix** com suporte a Bash.
2. Ferramenta `sshpass` instalada.
   - Em sistemas baseados em Debian, pode ser instalada com:  
     ```bash
     sudo apt-get install sshpass
     ```
3. Acesso ao servidor remoto configurado com as credenciais necessárias.

## Estrutura do Projeto

O script principal é o seguinte:

```bash
#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 <arquivo_de_configuracao>"
  exit 1
fi

source "$1"

if [ -z "$LOGIN" ] || [ -z "$IP" ] || [ -z "$SENHA" ] || [ -z "$PASTA" ]; then
  echo "O arquivo de configuração deve conter as variáveis LOGIN, IP, SENHA e ARQUIVO"
  exit 1
fi

sshpass -p "$SENHA" scp -r "$PASTA" "$LOGIN@$IP:~/"

if [ $? -eq 0 ]; then
  echo "Pasta enviada com sucesso!"
else
  echo "Falha ao enviar a pasta."
fi
```

## Uso

1. Crie um arquivo de configuração (por exemplo, `config.env`) com as seguintes variáveis:

   ```bash
   LOGIN=usuario
   IP=192.168.1.100
   SENHA=senha123
   PASTA=/caminho/para/a/pasta
   ```

2. Execute o script passando o arquivo de configuração como argumento:

   ```bash
   ./script.sh config.env
   ```

   Onde:
   - `LOGIN`: Usuário remoto.
   - `IP`: Endereço IP do servidor remoto.
   - `SENHA`: Senha para autenticação.
   - `PASTA`: Caminho absoluto da pasta a ser enviada.

3. O script tentará enviar a pasta para o diretório `~/` no servidor remoto.

## Mensagens de Saída

- **"Pasta enviada com sucesso!"**: Indica que a transferência foi concluída.
- **"Falha ao enviar a pasta."**: Indica que houve algum problema na transferência.
- **Erros de configuração**: Informações sobre variáveis ausentes no arquivo de configuração.

## Observações

- Certifique-se de que a pasta especificada existe e que o servidor remoto está acessível.
- Para maior segurança, evite armazenar senhas diretamente em arquivos. Considere o uso de chaves SSH no lugar de senhas.
- Caso `sshpass` não seja permitido por políticas organizacionais, configure autenticação baseada em chave SSH.

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para enviar pull requests ou abrir issues com sugestões de melhorias.