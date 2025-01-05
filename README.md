# Taski - Gerenciador de Tarefas 📝

Taski é um aplicativo Flutter para gerenciamento de tarefas com persistência local, permitindo criar, listar e editar tarefas de forma eficiente e prática.

---

## 📋 Funcionalidades Implementadas

✅ Listagem de tarefas com scroll infinito  
✅ Listagem de tarefas finalizadas  
✅ Criar tarefa  
✅ Salvar dados localmente utilizando Hive  
✅ Editar tarefa (Bônus)

---

---

## 📋 Bonús

✅  Clean Code
✅ Arquitetura MVVM
✅ Testes Unitários 

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

- **Flutter SDK** (versão 3.27.0 ou superior)
- **Dart SDK** (compatível com o Flutter instalado)
- **Hive** (banco de dados local)
- Emulador ou dispositivo físico para rodar o aplicativo

### Passo a Passo

1. **Clone o Repositório**

   Clone o repositório do projeto para o seu ambiente local:

   ```bash
   git clone https://github.com/seu-usuario/taski.git
   cd taski
2. **Instale as Dependências**

    Antes de rodar o projeto, instale todas as dependências necessárias:

    ```bash
  flutter pub get

3. **Configure o Hive**

   Gere os adaptadores do Hive necessários para o funcionamento do banco de dados:

   ```bash
   flutter packages pub run build_runner build

4. Execute o Projeto:

   Rode o aplicativo em um dispositivo físico ou emulador com o comando abaixo:

   ```bash
   flutter run

5. Estrutura do projeto:

taski/
├── core/
│   ├── widgets/         # Componentes reutilizáveis
│
├── features/
│   ├── tasks/           # Funcionalidade principal
│       ├── models/      # Definição das entidades e modelos
│       ├── viewmodels/  # Lógica de negócios e interação com o Hive
│       ├── views/       # Telas principais do app
│       ├── widgets/     # Componentes de UI específicos
│
├── resources/           # Recursos como ícones, temas e fontes
├── test/                # Testes automatizados
│   ├── unit/            # Testes unitários para lógica de negócios
│       ├── task_view_model_test.dart   # Testes do ViewModel de tarefas
│
├── main.dart            # Arquivo principal do aplicativo


