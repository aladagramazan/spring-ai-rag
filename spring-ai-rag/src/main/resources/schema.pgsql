                ┌─────────────────────────────┐
                │     Embedding Model         │
                │ (converts text to vectors)  │
                └─────────────┬───────────────┘
                              │
                              │
                    ┌─────────▼─────────┐
                    │  SimpleVectorStore│
                    │  (stores document │
                    │   embeddings)     │
                    └─────────┬─────────┘
                              │
   ┌──────────────────────────┼─────────────────────────────┐
   │                          │                             │
   │    (if vector store      │     (if vector store file   │
   │     file exists, load    │      does NOT exist, load    │
   │     embeddings from      │      documents and process)  │
   │     disk)                │                             │
   │                          │                             │
   ▼                          ▼                             ▼
┌─────────┐         ┌──────────────────────────┐     ┌────────────────────────────┐
│  Load   │         │ TikaDocumentReader       │     │   TextSplitter (TokenTextSplitter)
│ existing│         │ (reads raw documents)    │     │ (splits docs for better    │
│ embeddings             └──────────┬────────────┘     │  embedding quality)        │
└─────────┘                    │                  └────────────┬──────────────┘
                               ▼                               │
                      ┌───────────────────┐                     │
                      │  Document List    │◄────────────────────┘
                      └───────────────────┘
                               │
                               ▼
                      ┌───────────────────┐
                      │  Add to Vector    │
                      │      Store        │
                      └───────────────────┘
                               │
                               ▼
                      ┌───────────────────┐
                      │   Save Vector     │
                      │     Store File    │
                      └───────────────────┘

                              │
                              │
                              ▼
                    ┌────────────────────┐
                    │  User Question     │
                    └─────────┬──────────┘
                              │
                              ▼
                    ┌────────────────────┐
                    │ Similarity Search  │
                    │ (using vector store│
                    │ to retrieve top-K  │
                    │ matching docs)     │
                    └─────────┬──────────┘
                              │
                              ▼
                    ┌────────────────────┐
                    │   Prepare Prompt   │
                    │ (rag-prompt-template│
                    │  + retrieved docs) │
                    └─────────┬──────────┘
                              │
                              ▼
                    ┌────────────────────┐
                    │    Chat Model      │
                    │  (LLM, e.g., GPT-4o)│
                    │   processes prompt │
                    │   and returns answer│
                    └─────────┬──────────┘
                              │
                              ▼
                    ┌────────────────────┐
                    │      Answer        │
                    └────────────────────┘
