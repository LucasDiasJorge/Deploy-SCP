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