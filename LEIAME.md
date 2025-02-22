# 🚀 LLM Chat Deployment com LibreChat e Ollama

Este projeto permite hospedar um modelo de linguagem grande (LLM) em uma máquina Ubuntu usando Docker. A aplicação usa [LibreChat](https://www.librechat.ai/) como interface web para interação com o modelo [Llama 3.2:1b](https://ollama.com/library/llama3.2:1b), rodando sobre a plataforma [Ollama](https://ollama.com/). Além disso, o sistema usa um banco de dados vetorial ([PGVector](https://github.com/pgvector/pgvector)) utilizado pelo [RAG API](https://github.com/danny-avila/rag_api) e o [MongoDB](https://hub.docker.com/_/mongo) para armazenar conversas e dados relevantes.

![screenshot](/data/docs/screenshot-pdf-png.png)

## 📌 Visão Geral da Arquitetura

![sistem_design](/data/docs/system_design.png)

A aplicação é composta pelos seguintes serviços:

- **Web Chat**: `LibreChat` - Interface web para interação com o LLM.
- **RAG API**: Serviço responsável pelo processo de recuperação aumentada de geração (RAG).
- **Banco de Dados**:
  - `MongoDB`: Para armazenamento de metadados das conversas.
  - `PGVector (PostgreSQL)`: Para armazenamento vetorial de embeddings.
- **Modelo de LLM**: `Llama 3.2:1b` - Executado via Ollama.
- **Containers**: Todos os serviços são gerenciados pelo `Docker`.
- **Ambiente**: `Ubuntu` como sistema operacional.

## 🔧 Pré-requisitos

Antes de iniciar a instalação, certifique-se de ter os seguintes requisitos atendidos:

- **Ubuntu** instalado e atualizado (24.04).
- **Docker** e **Docker Compose** (27.5) instalados.
- **GPU compatível** (opcional visto que o Ollama roda em CPU) para aceleração de inferência do modelo LLM.

## 📥 Instalação e Configuração

1. **Clone o repositório**
   ```bash
   git clone https://github.com/glaucomunsberg/llm_charts
   cd llm_charts
   ```

2. **Configure as variáveis de ambiente**
   - Copie os arquivos `.env.sample` para `.env` localizados dentro das pastas `docker/livre-chat/`, `docker/pgvector/`, `docker/livre-chat-rag-api/` e `docker/meilisearch`.
   - Edite o valor de `baseURL` no arquivo `chats/libre-chat/librechat.yaml` para o IP da máquina UBuntu caso deseje acesso remoto.

3. **Subindo o modelo LLM**

   - Acesse o container do Ollama:
     ```bash
     curl -fsSL https://ollama.com/install.sh | sh
     ```
   
   - Para enviar arquivos para o servidor é preciso passar o parâmetro para zero:
     ```bash
     sudo nano /etc/sysctl.d/10-ptrace.conf
     ```
     ```text
        kernel.yama.ptrace_scope = 0
     ```
     [leia sobre a importância](https://docs.linaroforge.com/24.0.5/html/forge/general_troubleshooting_appendix/attaching/system_not_connecting_debuggers_fedora_ubuntu.html)
   
   - Habilite o debug: 
     ```bash
        set debuginfod enabled on
     ```

   - Baixando models usados:
   ```bash
        ollama pull nomic-embed-text llama3.2:1b
   ```

   - Inicie o servidor Ollama acesso remoto Você pode ignorar caso não queira acesso remoto, pois o serviço ollama já está rodando na sua máquina: 
     ```bash
     set debuginfod enabled on
     sudo service ollama stop
     OLLAMA_HOST="0.0.0.0" OLLAMA_ORIGINS="*" ollama serve
     ```

4. **Suba os containers com Docker Compose**
   ```bash
   docker-compose up -d
   ```
   Isso iniciará todos os serviços necessários para o funcionamento do chat baseado em LLM.


5. **Acesse a aplicação**
   - Abra o navegador e acesse: [`http://localhost:3080`](http://localhost:3080)
   - Agora você pode interagir com o modelo de IA via LibreChat.

## 📂 Estrutura do Projeto

```
├── docker/
│   ├── livre-chat/                # Configuração do LibreChat
│   ├── meilisearch/               # Configuração do MeiliSearch
│   ├── pgvector/                  # Configuração do banco de dados vetorial
│   ├── livre-chat-rag-api/         # Configuração da API RAG
├── chats/                         # Dados persistidos das conversas
│   ├── livre-chat/
│   │   ├── images/                 # Imagens usadas na interface
│   │   ├── logs/                   # Logs da aplicação
│   │   ├── librechat.yaml          # Configuração do LibreChat
├── compose.yml                     # Arquivo de configuração do Docker Compose
```

## 🤖 Personalização e Expansão

Se desejar modificar o modelo de LLM ou alterar as configurações da aplicação, edite os arquivos `.env`, `compose.yml` e `librechat.yaml` conforme necessário.

---

Agora você tem uma instância funcional de um chatbot baseado em LLM rodando localmente no Ubuntu com possibilidade de treinamento e personalização. 

Para mais detalhes sobre acesse os projetos oficiais usados neste projeto:

- [LibreChat](https://www.librechat.ai/)
- [Ollama](https://ollama.com/)
- [RAG API](https://github.com/danny-avila/rag_api)
- [PGVector](https://github.com/pgvector/pgvector)
- [MongoDB](https://hub.docker.com/_/mongo)
- [MeiliSearch](https://www.meilisearch.com/)
- [Docker](https://www.docker.com/)
- [Ubuntu](https://ubuntu.com/)
