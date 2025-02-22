# 🚀 LLM Chat Deployment with LibreChat and Ollama

This project allows hosting a large language model (LLM) on an Ubuntu machine using Docker. The application uses [LibreChat](https://www.librechat.ai/) as a web interface to interact with the [Llama 3.2:1b](https://ollama.com/library/llama3.2:1b) model, running on the [Ollama](https://ollama.com/) platform. Additionally, the system uses a vector database ([PGVector](https://github.com/pgvector/pgvector)) utilized by the [RAG API](https://github.com/danny-avila/rag_api) and [MongoDB](https://hub.docker.com/_/mongo) to store conversations and relevant data.

![system_design](/data/docs/system_design.png)

## 📌 Architecture Overview

The application consists of the following services:

- **Web Chat**: `LibreChat` - Web interface for interacting with the LLM.
- **RAG API**: Service responsible for the retrieval-augmented generation (RAG) process.
- **Database**:
  - `MongoDB`: For storing conversation metadata.
  - `PGVector (PostgreSQL)`: For storing vector embeddings.
- **LLM Model**: `Llama 3.2:1b` - Executed via Ollama.
- **Containers**: All services are managed by `Docker`.
- **Environment**: `Ubuntu` as the operating system.

## 🔧 Prerequisites

Before starting the installation, make sure you meet the following requirements:

- **Ubuntu** installed and updated (24.04).
- **Docker** and **Docker Compose** (27.5) installed.
- **Compatible GPU** (optional since Ollama runs on CPU) for LLM model inference acceleration.

## 📥 Installation and Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/glaucomunsberg/llm_charts
   cd llm_charts
   ```

2. **Configure environment variables**
   - Copy the `.env.sample` files to `.env` located inside the `docker/livre-chat/`, `docker/pgvector/`, `docker/livre-chat-rag-api/`, and `docker/meilisearch` folders.
   - Edit the `baseURL` value in the `chats/libre-chat/librechat.yaml` file to the Ubuntu machine's IP if you want remote access.

3. **Starting the LLM model**

   - Access the Ollama container:
     ```bash
     curl -fsSL https://ollama.com/install.sh | sh
     ```
   
   - To send files to the server, set the parameter to zero:
     ```bash
     sudo nano /etc/sysctl.d/10-ptrace.conf
     ```
     ```text
        kernel.yama.ptrace_scope = 0
     ```
     [read about its importance](https://docs.linaroforge.com/24.0.5/html/forge/general_troubleshooting_appendix/attaching/system_not_connecting_debuggers_fedora_ubuntu.html)
   
   - Enable debugging:
     ```bash
        set debuginfod enabled on
     ```
   
   - Download the required models:
   ```bash
        ollama pull nomic-embed-text llama3.2:1b
   ```
   
   - Start the Ollama server for remote access. You can skip this step if you don't need remote access, as the Ollama service is already running locally:
     ```bash
     set debuginfod enabled on
     sudo service ollama stop
     OLLAMA_HOST="0.0.0.0" OLLAMA_ORIGINS="*" ollama serve
     ```

4. **Start the containers with Docker Compose**
   ```bash
   docker-compose up -d
   ```
   This will start all necessary services for the LLM-based chat.

5. **Access the application**
   - Open a browser and go to: [`http://localhost:3080`](http://localhost:3080)
   - Now you can interact with the AI model via LibreChat.

## 📂 Project Structure

```
├── docker/
│   ├── livre-chat/                # LibreChat configuration
│   ├── meilisearch/               # MeiliSearch configuration
│   ├── pgvector/                  # Vector database configuration
│   ├── livre-chat-rag-api/         # RAG API configuration
├── chats/                         # Persisted conversation data
│   ├── livre-chat/
│   │   ├── images/                 # Images used in the interface
│   │   ├── logs/                   # Application logs
│   │   ├── librechat.yaml          # LibreChat configuration
├── compose.yml                     # Docker Compose configuration file
```

## 🤖 Customization and Expansion

If you want to modify the LLM model or change application settings, edit the `.env`, `compose.yml` and `librechat.yaml` files as needed.

---

Now you have a fully functional LLM-based chatbot running locally on Ubuntu, with training and customization capabilities.

For more details, visit the official projects used in this deployment:

- [LibreChat](https://www.librechat.ai/)
- [Ollama](https://ollama.com/)
- [RAG API](https://github.com/danny-avila/rag_api)
- [PGVector](https://github.com/pgvector/pgvector)
- [MongoDB](https://hub.docker.com/_/mongo)
- [MeiliSearch](https://www.meilisearch.com/)
- [Docker](https://www.docker.com/)
- [Ubuntu](https://ubuntu.com/)

